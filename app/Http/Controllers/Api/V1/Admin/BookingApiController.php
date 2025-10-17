<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Traits\BookingAvailableTrait;
use App\Http\Controllers\Traits\MediaUploadingTrait;
use App\Http\Controllers\Traits\MiscellaneousTrait;
use App\Http\Controllers\Traits\OTPTrait;
use App\Http\Controllers\Traits\PaymentStatusUpdaterTrait;
use App\Http\Controllers\Traits\ResponseTrait;
use App\Http\Controllers\Traits\UserWalletTrait;
use App\Http\Controllers\Traits\VendorWalletTrait;
use App\Models\AppUser;
use App\Models\Booking;
use App\Models\BookingCancellationReason;
use App\Models\BookingExtension;
use App\Models\CancellationPolicy;
use App\Models\Modern\Currency;
use App\Models\Modern\Item;
use App\Models\Modern\ItemDate;
use App\Models\Modern\ItemType;
use App\Models\Review;
use App\Models\VendorWallet;
use Carbon\Carbon;
use DateTime;
use DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class BookingApiController extends Controller
{
    use BookingAvailableTrait, MediaUploadingTrait, MiscellaneousTrait, OTPTrait, PaymentStatusUpdaterTrait, ResponseTrait, UserWalletTrait, VendorWalletTrait;

    /**
     * Check the availability of bookings for a item within a given date range.
     *
     * @return \Illuminate\Http\Response
     */
    public function checkBookingAvailability(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'item_id' => 'required|exists:rental_items,id',
            'check_in' => 'required|date_format:Y-m-d|after_or_equal:today',
            'check_out' => 'required|date_format:Y-m-d',
        ]);
        $allowedModules = $this->sameDayBookingModule();

        $validator->sometimes('check_out', 'after:check_in', function ($input) use ($request, $allowedModules) {
            return ! in_array($request->input('module_id'), $allowedModules);
        });

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        // try {
        $ItemId = $request->input('item_id');
        $checkInDate = $request->input('check_in');
        $checkOutDate = $request->input('check_out');
        $module = $this->getModuleIdOrDefault($request);
        $start_time = $request->input('start_time', null);
        $end_time = $request->input('end_time', null);
        $start_time = $request->input('start_time');
        $end_time = $request->input('end_time');
        $checkOutDateReturn = $checkOutDate;
        $checkOutDate = $this->returncheckOutDateByModule($checkInDate, $start_time, $checkOutDate, $end_time, $module);

        // Find the item by ID
        $item = Item::findOrFail($ItemId);
        // DB::enableQueryLog();
        $lastBooking = Booking::where('itemid', $ItemId)
            ->where('check_out', '<=', $checkInDate)
            ->whereIn('status', ['Pending', 'Confirmed', 'Completed'])
            ->orderBy('check_out', 'desc')
            ->first();

        $overlappingBookings = Booking::where('itemid', $ItemId)
            ->where('check_in', '<', $checkOutDate)
            ->where('check_out', '>', $checkInDate)
            ->whereIn('status', ['Pending', 'Confirmed', 'Completed'])
            ->get();

        $isAvailable = $overlappingBookings->isEmpty();
        if ($overlappingBookings->isNotEmpty()) {
            $bookingSummary = [];

            foreach ($overlappingBookings as $booking) {
                $date = $booking->check_in;
                $startTime = Carbon::parse($booking->start_time)->format('H:i');
                $endTime = Carbon::parse($booking->end_time)->format('H:i');

                if (! isset($bookingSummary[$date])) {
                    $bookingSummary[$date] = [
                        'date' => $date,
                        'start_time' => $startTime,
                        'end_time' => $endTime,
                    ];
                } else {
                    $bookingSummary[$date]['start_time'] = min($bookingSummary[$date]['start_time'], $startTime);
                    $bookingSummary[$date]['end_time'] = max($bookingSummary[$date]['end_time'], $endTime);
                }
            }

            foreach ($bookingSummary as &$summary) {
                $summary['start_time'] = Carbon::createFromFormat('H:i', $summary['start_time'])->format('g:i A');
                $summary['end_time'] = Carbon::createFromFormat('H:i', $summary['end_time'])->format('g:i A');
            }
            $flatBookingSummary = array_values($bookingSummary);

            return $this->addSuccessResponse(422, 'dates overlap with existing bookings', ['bookingOverlapDetails' => $flatBookingSummary]);
        }

        $getMissingDaya = $this->getMissingDays($ItemId); // It's for office module

        if ($isAvailable) {
            $dates = [];
            $currentDate = Carbon::parse($checkInDate);
            $endDate = Carbon::parse($checkOutDate);
            $allDaysMatch = true;

            while ($currentDate < $endDate) {
                $dates[] = $currentDate->toDateString();
                $currentDate->addDay(); // Increment by one day

                $dayOfWeek = $currentDate->format('l'); // Get the day of the week (e.g., Monday, Tuesday, etc.)
                if (in_array($dayOfWeek, $getMissingDaya)) {
                    $allDaysMatch = false;
                    break;
                }
            }

            if (! $allDaysMatch) {
                return $this->addErrorResponse(422, trans('global.dates_are_not_available'), '');
            }

            $ItemDates = ItemDate::where('item_id', $ItemId)
                ->whereIn('date', $dates)
                ->where('status', 'not Available')
                ->get();

            if (count($ItemDates) > 1) {
                return $this->addErrorResponse(422, trans('global.dates_are_not_available'), '');
            }

            $force = true;

            if ($ItemDates->where('status', trans('global.not_available'))->count() > 0) {
                $isAvailable = false;
            } else {
                $isAvailable = true;
            }
            $nextStartTime = '12:00 AM';
        } else {
            return $this->addErrorResponse(422, 'The selected dates overlap with an existing booking', '');
        }

        if ($lastBooking && Carbon::parse($lastBooking->check_out)->equalTo(Carbon::parse($checkInDate))) {

            $nextStartTime = $lastBooking->end_time;
        }

        // Prepare the response data
        $responseData = [
            'item_id' => $ItemId,
            'check_in' => $checkInDate,
            'check_out' => $checkOutDateReturn,
            'next_start_time' => $nextStartTime,
            'is_available' => $isAvailable,
        ];

        if ($isAvailable) {
            return $this->addSuccessResponse(200, trans('global.Result_found'), ['availability' => $responseData]);
        } else {
            return $this->addErrorResponse(500, trans('global.dates_are_not_available'), '');
        }
        try {
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.ServerError_internal_server_error'), $e->getMessage());
        }
    }

    public function bookItem(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'item_id' => 'required|exists:rental_items,id',
            'driver_id' => 'required|exists:app_users,id',
            'token' => 'required|exists:app_users,token',
            'item_type_id' => 'required|exists:rental_item_types,id',
            'pickup_latitude' => 'required|numeric',
            'pickup_longitude' => 'required|numeric',
            'dropoff_latitude' => 'required|numeric',
            'dropoff_longitude' => 'required|numeric',
            'estimated_distance_km' => 'required|numeric|min:0.1',
            'pickup_address' => 'required|string',
            'dropoff_address' => 'required|string',
            'service_charge' => 'nullable|numeric',
            'wallet_amount' => 'nullable|numeric',
            'payment_method' => 'nullable|string',
            'currency_code' => 'nullable|string',
            'coupon_code' => 'nullable|string',
            'coupon_discount' => 'nullable|numeric',
            'discount_price' => 'nullable|numeric',
            'amount_to_pay' => 'nullable|numeric',
            'estimated_duration_min' => 'nullable|numeric',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $userId = $this->checkUserByToken($request->token);
        if (! $userId) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $walletAmount = $request->wallet_amount ?? 0;
        $distance = $request->estimated_distance_km;
        $itemTypeId = $request->item_type_id;
        $couponCode = $request->coupon_code;
        $currencyCode = $request->currency_code ?? 'USD';
        $itemId = $request->input('item_id');
        $conversionRate = Currency::getValueByCurrencyCode($currencyCode);
        $pricingResult = $this->getItemPricesDetails($itemTypeId, $distance, $couponCode, $walletAmount, $currencyCode, $conversionRate);
        $pricing = $pricingResult->getData(true)['data'];

        $booking = new Booking;
        $booking->itemid = $itemId;
        $booking->userid = $userId;
        $booking->host_id = $request->driver_id;
        $booking->ride_date = $request->ride_date;
        $booking->payment_status = 'notpaid';
        $booking->price_per_km = $pricing['price_per_km'];
        $booking->base_price = $pricing['price_before_discount'];
        $booking->total = $pricing['gross_price'];
        $booking->wall_amt = $pricing['wallet_amount'];
        $booking->payment_status = 'notpaid';
        $booking->payment_method = '';
        $booking->currency_code = $request->currency_code ?? 'USD';
        $booking->coupon_code = $pricing['coupon_code'];
        $booking->coupon_discount = $pricing['coupon_discount'];
        $booking->discount_price = $pricing['coupon_discount'];
        $booking->amount_to_pay = $pricing['gross_price'];
        $booking->rating = 0;
        $booking->module = $request->module_id;
        $booking->status = 'Accepted';
        $bookingItem = Item::where('id', $itemId)->get()->map(function ($bookingItem) {
            $formattedItem = $this->formatItemData($bookingItem);
            $itemType = ItemType::find($bookingItem->item_type_id);
            $formattedItem['item_type'] = $itemType ? $itemType->name : null;
            $formattedItem['item_info'] = $this->getModuleInfoValues('', $bookingItem->id);

            return $formattedItem;
        });

        $vehicleSpeed = $bookingItem[0]['average_speed_kmph'] ?? 40;

        $estimatedDurationMin = null;

        if ($vehicleSpeed && $vehicleSpeed > 0 && $distance > 0) {
            $estimatedDurationMin = ($distance / $vehicleSpeed) * 60;
        }

        $commissions = $this->calculateCommissions($this->convertFormattedNumber($pricing['total_price']), $bookingItem[0]['item_type_id']);
        $booking->admin_commission = $commissions['admin_commission'];
        $booking->vendor_commission = $commissions['vendor_commission'];

        $booking->save();

        $bookingExtension = new BookingExtension;
        $bookingExtension->booking_id = $booking->id;
        $bookingExtension->pickup_location = [
            'latitude' => $request->pickup_latitude,
            'longitude' => $request->pickup_longitude,
            'address' => $request->pickup_address,
        ];
        $bookingExtension->dropoff_location = [
            'latitude' => $request->dropoff_latitude,
            'longitude' => $request->dropoff_longitude,
            'address' => $request->dropoff_address,
        ];
        $bookingExtension->estimated_distance_km = $request->estimated_distance_km ?? null;
        $bookingExtension->estimated_duration_min = $estimatedDurationMin ?? null;
        $bookingExtension->pick_otp = $this->createPickDropOTP();
        $bookingExtension->ride_id = $request->ride_id;
        $bookingExtension->save();

        if ($booking->wall_amt > 0) {
            $this->addWalletTransaction($userId, $booking->wall_amt, 'debit', 'Wallet used for ride #'.$booking->id);
        }

        if ($pricing['gross_price'] < 1) {
            $booking->payment_status = 'paid';
            $booking->payment_method = 'wallet';
            $booking->save();
            $responseData = [
                'booking_id' => $booking->id,
                'status' => $booking->status,
                'payment_url' => route('payment_success', ['booking' => $booking->id]),
            ];

            return $this->addSuccessResponse(200, trans('global.booked_succesfully'), $responseData);
        }
        // $onlinePyament = $request->onlinepayment;
        $onlinePyament = 'Inactive';
        if ($onlinePyament == 'Inactive') {
            $booking->payment_status = 'notpaid';
            $booking->payment_method = 'cash';
            // $template_id = 10;
            $booking->save();

            $responseData = [
                'booking_id' => $booking->id,
                'ride_id' => $booking->extension->ride_id ?? 0,
                'booking_token' => $booking->token ?? 0,
                'pickup_otp' => $booking->extension->pick_otp ?? 0,
                'status' => $booking->status,
                'payment_url' => route('payment_methods', ['booking' => $booking->id]),
            ];

            return $this->addSuccessResponse(200, trans('global.booked_succesfully'), $responseData);
        }

    }

    private function calculateCommissions_bkp($basePrice)
    {

        $adminCommission = ($basePrice * $this->getGeneralSettingValue('feesetup_admin_commission') / 100);
        $vendorCommission = ($basePrice) - $adminCommission;

        return [
            'admin_commission' => $adminCommission,
            'vendor_commission' => $vendorCommission,
        ];
    }

    private function calculateCommissions($basePrice, $itemTypeId)
    {
        $itemType = ItemType::find($itemTypeId);
        $adminCommissionPercent = optional($itemType->cityFare)->admin_commission ?? 0;
        $adminCommission = floor(($basePrice * $adminCommissionPercent) / 100);
        $vendorCommission = $basePrice - $adminCommission;

        return [
            'admin_commission' => (int) $adminCommission,
            'vendor_commission' => (int) $vendorCommission,
        ];
    }

    public function bookingRecord(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'booking_status' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $limit = $request->input('limit', 10);
        $offset = $request->input('offset', 0);

        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(419, trans('global.token_not_match'), '');
        }

        $module = 2;
        $bookingsQuery = Booking::with(['extension', 'review', 'host'])
            ->where('userid', $user_id)
            ->where('module', $module)
            ->whereIn('status', ['Completed', 'Cancelled']);

        if ($request->filled('booking_status')) {
            $bookingsQuery->where('status', $request->input('booking_status'));
        }

        $bookings = $bookingsQuery
            ->orderBy('id', 'desc')
            ->skip($offset)
            ->take($limit)
            ->get()
            ->map(function ($booking) {
                $review = $booking->review;
                $booking['review_status'] = $review ? '1' : '0';
                $booking['review_rating'] = $review->guest_rating ?? '';
                $booking['review'] = $review->guest_message ?? '';
                $host = $booking->host;
                $booking['host_name'] = $host ? ($host->first_name.' '.$host->last_name) : '';
                $booking['host_number'] = $host->phone ?? '';
                $booking['host_email'] = $host->email ?? '';
                $booking['host_phone_country'] = $host->phone_country ?? '';
                $extension = $booking->extension;
                $booking['doorStep_price'] = $extension->doorStep_price ?? 0;
                $booking['pickup_otp'] = $extension->pick_otp ?? 0;
                $booking['pickup_location'] = $extension->pickup_location ?? null;
                $booking['dropoff_location'] = $extension->dropoff_location ?? null;
                $booking['estimated_distance_km'] = $extension->estimated_distance_km ?? 0;
                $booking['firebase_json'] = json_decode($booking->firebase_json);
                unset($booking->extension, $booking->review, $booking->host);

                return $booking;
            });

        $nextOffset = $bookings->isEmpty() ? -1 : ($offset + count($bookings));

        return $this->addSuccessResponse(200, trans('global.booking_list'), [
            'Bookings' => $bookings,
            'offset' => $nextOffset,
            'limit' => $limit,
        ]);
    }

    public function itemBookingDate(Request $request)
    {
        // try {
        $validator = Validator::make($request->all(), [
            'id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(500, $validator->errors()->first());
        }

        $upcomingBookings = Booking::where('itemid', $request->id)
            ->where('check_in', '>', Carbon::now())
            ->whereIn('status', ['pending', 'approved'])
            ->get();

        $selectedFields = $upcomingBookings->map(function ($booking) {
            return [
                'check_in' => $booking->check_in,
                'check_out' => Carbon::parse($booking->check_out)->subDay()->toDateString(),
            ];
        });

        $itemDates = ItemDate::where('item_id', $request->id)->where('status', 'Not available')->get();

        foreach ($itemDates as $date) {

            // Add Not Available date information to the notAvailableDates array
            $selectedFields[] = [
                'check_in' => $date->date,
                'check_out' => $date->date,
            ];
        }
        //

        $weekdays = $this->getMissingDays($request->id);

        $currentDate = new DateTime;
        if (! empty($weekdays)) {
            for ($i = 0; $i < 4; $i++) {

                $firstDayOfMonth = new DateTime($currentDate->format('Y-m-01'));
                if ($firstDayOfMonth < $currentDate) {
                    $firstDayOfMonth = clone $currentDate;
                }
                while ($firstDayOfMonth->format('m') === $currentDate->format('m')) {
                    $currentDayName = $firstDayOfMonth->format('l');
                    if (in_array($currentDayName, $weekdays)) {

                        if ($firstDayOfMonth >= $currentDate) {
                            $selectedFields[] = [
                                'check_in' => $firstDayOfMonth->format('Y-m-d'),
                                'check_out' => $firstDayOfMonth->format('Y-m-d'),
                            ];
                        }
                    }
                    $firstDayOfMonth->modify('+1 day');
                }
                $currentDate->modify('first day of next month');
            }
        }

        return $this->successResponse(200, trans('global.itemBookingDate'), ['itemBookingDate' => $selectedFields]);
        try {
        } catch (\Exception $e) {
            return $this->errorResponse(500, trans('global.something_wrong'));
        }
    }

    public function bookingpaymentsuccess(Request $request)
    {
        // try {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(500, $validator->errors()->first());
        }

        $booking_payment_status = Booking::where('id', $request->booking_id)->whereIn('payment_status', ['Paid', 'authorized'])->first();

        if ($booking_payment_status) {
            return $this->successResponse(200, trans('global.bookingpayment'), ['bookingpayment' => 'Paid']);
        }
        $booking_payment_status = Booking::where('id', $request->booking_id)->delete();

        ItemDate::where('item_id', $booking_payment_status->itemid)->where('booking_id', $request->booking_id)
            ->update([
                'status' => 'Available',
            ]);

        return $this->successResponse(200, trans('global.bookingpayment'), ['bookingpayment' => 'Fail']);
        try {
        } catch (\Exception $e) {
            return $this->errorResponse(500, trans('global.something_wrong'));
        }
    }

    public function vendorBookingRecord(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'type' => 'required',
            'token' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $limit = $request->input('limit', 10);
        $offset = $request->input('offset', 0);
        $user_id = $this->checkUserByToken($request->token);

        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $type = $request->type;
        $module = $this->getModuleIdOrDefault($request);

        $query = Booking::with(['extension', 'user:id,first_name,last_name,phone,email,phone_country'])
            ->where('host_id', $user_id)
            ->where('module', $module);

        switch ($type) {
            case 'rejected':
                $query->where('status', 'Rejected');
                break;
            case 'cancelled':
                $query->where('status', 'Cancelled');
                break;
            case 'previous':
                $query->where('check_out', '<', now()->format('Y-m-d'));
                break;
            case 'completed':
                $query->where('status', 'completed');
                break;
            default:
                return $this->addErrorResponse(400, 'Invalid type');
        }

        $bookings = $query->orderByDesc('id')->skip($offset)->take($limit)->get()
            ->map(function ($booking) use ($type) {
                if ($booking->user) {
                    $booking['user_name'] = $booking->user->first_name.' '.$booking->user->last_name;
                    $booking['user_number'] = $booking->user->phone;
                    $booking['user_email'] = $booking->user->email;
                    $booking['user_phone_country'] = $booking->user->phone_country;
                } else {
                    $booking['user_name'] = $booking['user_number'] = $booking['user_email'] = $booking['user_phone_country'] = null;
                }
                $booking['doorStep_price'] = $booking->extension->doorStep_price ?? 0;
                $booking['pickup_otp'] = $booking->extension->pick_otp ?? 0;
                $booking['pickup_location'] = $booking->extension->pickup_location ?? null;
                $booking['dropoff_location'] = $booking->extension->dropoff_location ?? null;
                $booking['estimated_distance_km'] = $booking->extension->estimated_distance_km ?? 0;
                $booking['estimated_duration_min'] = $booking->extension->estimated_duration_min ?? 0;
                unset($booking->extension);
                $today = now()->format('Y-m-d');
                $booking['is_item_delivered_button'] = ($booking->check_in === $today && $booking->is_item_received == 0 && $booking->is_item_delivered == 0) ? 'yes' : 'no';
                $booking['is_item_returned_button'] = ($booking->is_item_delivered == 1 && $booking->is_item_returned == 0) ? 'yes' : 'no';
                if (in_array($type, ['previous', 'completed'])) {
                    $review = Review::where('bookingid', $booking->id)->where('host_rating', '>', 0)->first();
                    $booking['review_status'] = $review ? '1' : '0';
                    $booking['review_rating'] = $review->host_rating ?? '';
                    $booking['review'] = $review->host_message ?? '';
                }
                $booking['firebase_json'] = json_decode($booking->firebase_json);

                return $booking;
            });

        $nextOffset = $bookings->isEmpty() ? -1 : ($offset + $bookings->count());

        return $this->addSuccessResponse(200, trans("global.vendor_{$type}_bookings_is"), [
            'Bookings' => $bookings,
            'offset' => $nextOffset,
            'limit' => $limit,
        ]);
    }

    public function cancelBookingByUser(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'booking_id' => 'required|exists:bookings,id',
                'token' => 'required|exists:app_users,token',
                'cancellation_reasion' => 'required',
            ]);

            if ($validator->fails()) {
                return $this->errorComputing($validator);
            }
            $user = AppUser::where('token', $request->input('token'))->first();
            if (! $user) {
                return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            }

            $order_cancellation = BookingCancellationReason::where('order_cancellation_id', $request->input('cancellation_reasion'))->first();
            if (! $order_cancellation) {
                return $this->errorResponse(500, trans('global.please_choose_cancellation_reason'));
            }

            $bookingId = $request->input('booking_id');
            $token = $request->input('token');
            $userId = $user->id;

            $booking = Booking::where('id', $bookingId)
                ->where('userid', $userId)
                ->where('status', '<>', 'Cancelled')
                ->first();

            if (! $booking) {
                return $this->addErrorResponse(500, trans('global.booking_not_found_or_not_editable'), '');
            }

            // $cancellationTimeLimit = Carbon::parse($booking->check_out)->subDay();

            // if (Carbon::now()->isAfter($cancellationTimeLimit)) {
            //     return $this->addErrorResponse(500, trans('global.booking_cancellation_time_limit_exceeded'), '');
            // }
            // if ($booking->payment_status == 'paid') {

            //     $item = Item::findOrFail($booking->itemid);

            //     $bookingCancellationPolicy = CancellationPolicy::findOrFail($item->booking_policies_id);
            //     $refundableAmount = $booking->vendor_commission;
            //     $deductedAmount = 0.00;

            //     if ($bookingCancellationPolicy->type === 'percent') {
            //         $deductedPercentage = $bookingCancellationPolicy->value;
            //         $deductedAmount = ($booking->vendor_commission * ($deductedPercentage / 100));
            //         $refundableAmount = $booking->vendor_commission - $deductedAmount;
            //     }
            // } else {
            //     $refundableAmount = 0;
            // }

            if ($booking->payment_status == 'paid') {
                // $departureTime = Carbon::parse($booking->itemTripSummary->departure_date);
                $departureTime = Carbon::parse($booking->check_in.' '.$booking->start_time);

                $currentTime = Carbon::now();

                $timeDifference = $departureTime->diffInHours($currentTime);

                if ($currentTime >= $departureTime || $timeDifference == 0) {
                    $refundableAmount = 0;
                } else {

                    if ($timeDifference <= 12) {
                        $cancellationTime = 12;
                    } elseif ($timeDifference > 12 && $timeDifference <= 24) {
                        $cancellationTime = 24;
                    } else {
                        $cancellationTime = 48;
                    }

                    $policy = CancellationPolicy::where('status', 1)
                        ->where('cancellation_time', $cancellationTime)
                        ->first();

                    if ($policy) {
                        $deductedAmount = 0.00;
                        $refundableAmount = $booking->vendor_commission;

                        if ($policy->type === 'percent') {
                            $deductedAmount = ($booking->vendor_commission * ($policy->value / 100));
                        }

                        $refundableAmount -= $deductedAmount;
                    } else {
                        $refundableAmount = 0;
                    }
                }
            } else {
                $refundableAmount = 0;
            }

            $transactionDescription = 'Cancellation refund for booking #'.$booking->id;
            $this->addWalletTransaction($userId, $refundableAmount, 'credit', $transactionDescription, $booking->currency_code);

            $description = 'Vendor portion after cancellation by user for booking  #'.$booking->id;
            $this->addToVendorWallet($booking->host_id, $deductedAmount, $booking->id, '0', $description);

            $booking->status = 'Cancelled';
            $booking->cancelled_by = 'guest';
            $booking->cancellation_reasion = $order_cancellation->reason;
            $booking->deductedAmount = $deductedAmount;
            $booking->refundableAmount = $refundableAmount;
            $booking->save();

            $this->rollbackItemAvailability($booking->itemid, $booking->check_in, $booking->check_out);

            // $template_id = 5;
            $template_id = 22;
            $valuesArray = [];
            $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
            $dataVal['message_key'] = $booking;
            $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);

            return $this->addSuccessResponse(200, trans('global.booking_cancelled_successfully'), '');
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.ServerError_internal_server_error'), $e->getMessage());
        }
    }

    public function cancelBookingByHost(Request $request)
    {

        try {
            $validator = Validator::make($request->all(), [
                'booking_id' => 'required|exists:bookings,id',
                'token' => 'required|exists:app_users,token',
                'cancellation_reasion' => 'required',
            ]);

            if ($validator->fails()) {
                return $this->errorComputing($validator);
            }
            $user = AppUser::where('token', $request->input('token'))->first();
            if (! $user) {
                return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            }

            $order_cancellation = BookingCancellationReason::where('order_cancellation_id', $request->input('cancellation_reasion'))->first();
            if (! $order_cancellation) {
                return $this->errorResponse(500, trans('global.please_choose_cancellation_reason'));
            }

            $bookingId = $request->input('booking_id');
            $token = $request->input('token');
            $userId = $user->id;

            $booking = Booking::where('id', $bookingId)
                ->where('host_id', $userId)
                ->where('status', '<>', 'Diclined')
                ->first();

            if (! $booking) {
                return $this->addErrorResponse(500, trans('global.booking_not_found_or_not_editable'), '');
            }

            $cancellationTimeLimit = Carbon::parse($booking->check_out)->subDay();

            if (Carbon::now()->isAfter($cancellationTimeLimit)) {
                return $this->addErrorResponse(500, trans('global.booking_cancellation_time_limit_exceeded'), '');
            }

            if ($booking->payment_status == 'paid') {
                $refundableAmount = $booking->vendor_commission + $booking->admin_commission;
                $deductedAmount = 0;
            } else {
                $deductedAmount = 0;
            }

            $transactionDescription = 'Cancellation refund for booking #'.$booking->id;
            $this->addWalletTransaction($booking->userid, $refundableAmount, 'credit', $transactionDescription, $booking->currency_code);

            $booking->status = 'Declined';
            $booking->cancelled_by = 'host';
            $booking->refundableAmount = $refundableAmount;
            $booking->deductedAmount = $deductedAmount;
            $booking->cancellation_reasion = $order_cancellation->reason;
            $booking->save();
            $this->rollbackItemAvailability($booking->itemid, $booking->check_in, $booking->check_out);

            // $template_id = 11;
            $template_id = 26;
            $valuesArray = [];
            $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
            $dataVal['message_key'] = $booking;
            $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);

            return $this->addSuccessResponse(200, trans('global.booking_cancelled_successfully'), '');
            // try {

        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.ServerError_internal_server_error'), $e->getMessage());
        }
    }

    public function confirmBookingByHost(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'token' => 'required|exists:app_users,token',
            'pickup_otp' => 'required|string',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user = AppUser::where('token', $request->input('token'))->first();
        if (! $user) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $bookingId = $request->input('booking_id');
        $userId = $user->id;

        $booking = Booking::where('id', $bookingId)
            ->where('host_id', $userId)
            ->where('status', '<>', 'Confirmed')
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(500, trans('global.booking_not_found_or_not_editable'), '');
        }

        $bookingExtension = BookingExtension::where('booking_id', $bookingId)->first();

        if (! $bookingExtension) {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        if ($bookingExtension->pick_otp !== $request->pickup_otp) {
            return $this->addErrorResponse(400, trans('global.invalid_otp'), '');
        }

        $bookingDate = Carbon::parse($booking->check_out);

        $booking->status = 'Confirmed';
        $booking->save();

        // $template_id = 18;
        // $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
        // $dataVal['message_key'] = $booking;
        // $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);

        try {
            return $this->addSuccessResponse(200, trans('global.booking_confirmed_successfully'), ['booking' => $booking]);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.ServerError_internal_server_error'), $e->getMessage());
        }
    }

    public function getCancellationPolicies(Request $request)
    {
        try {
            $module = $this->getModuleIdOrDefault($request);
            $cancellationPolicies = CancellationPolicy::where('status', 1)
                ->where('module', $module)
                ->get();

            return $this->addSuccessResponse(200, trans('global.Result_found'), ['cancellation_policies' => $cancellationPolicies]);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.ServerError_internal_server_error'), $e->getMessage());
        }
    }

    public function distributeVendorCommission()
    {
        try {
            $affectedRows = DB::transaction(function () {
                $currentDate = Carbon::now();
                $affectedRows = 0;
                Booking::where('status', 'Completed')
                    ->where('vendor_commission_given', 0)
                    ->chunkById(100, function ($bookings) use (&$affectedRows, $currentDate) {
                        $updates = [];
                        $walletInserts = [];

                        foreach ($bookings as $booking) {
                            $description = "Driver commission for ride #{$booking->token}";
                            $walletInserts[] = [
                                'vendor_id' => $booking->host_id,
                                'amount' => $booking->vendor_commission,
                                'booking_id' => $booking->id,
                                'type' => 'credit',
                                'description' => $description,
                                'created_at' => $currentDate,
                                'updated_at' => $currentDate,
                            ];
                            $updates[] = $booking->id;
                        }

                        if (! empty($walletInserts)) {
                            VendorWallet::insert($walletInserts);
                        }

                        if (! empty($updates)) {
                            Booking::whereIn('id', $updates)->update([
                                'vendor_commission_given' => 1,
                                'updated_at' => $currentDate,
                            ]);
                        }
                        $affectedRows += count($updates);
                    });

                return $affectedRows;
            });

            return response()->json([
                'status' => 'success',
                'message' => 'Driver commissions distributed successfully.',
                'affected_rows' => $affectedRows,
            ], 200);
        } catch (\Throwable $e) {
            \Log::error('Driver commission distribution failed: '.$e->getMessage(), [
                'exception' => $e,
            ]);

            return response()->json([
                'status' => 'failure',
                'message' => 'Failed to distribute vendor commissions.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function removeUnpaidBookings(Request $request)
    {
        try {
            $unpaidBookings = Booking::where('payment_status', 'notpaid')
                ->where('created_at', '<=', Carbon::now()->subHour())
                ->get();
            $count = $unpaidBookings->count();
            if ($count == 0) {
                return;
            }

            $unpaidBookingIds = $unpaidBookings->pluck('id')->toArray();
            DB::beginTransaction();
            DB::table('rental_item_dates')
                ->whereIn('booking_id', $unpaidBookingIds)
                ->update(['status' => 'Available', 'booking_id' => 0]);
            Booking::whereIn('id', $unpaidBookingIds)->delete();
            DB::commit();

            return response()->json(['message' => 'Done', 'removed_count' => $count], 200);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json(['error' => 'Done', 'details' => $e->getMessage()], 500);
        }
    }

    public function getItemPrices(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'item_type_id' => 'required|exists:rental_item_types,id',
            'distance' => 'required|numeric|min:0',
            'coupon_code' => 'nullable|string',
            'wallet_amount' => 'nullable|numeric|min:0',
            'selected_currency_code' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $itemTypeId = $request->input('item_type_id');
        $distance = $request->input('distance');
        $couponCode = $request->input('coupon_code');
        $walletAmount = $request->input('wallet_amount', 0);
        $selectedCurrencyCode = $request->input('selected_currency_code', 'USD');
        $conversionRate = Currency::getValueByCurrencyCode($selectedCurrencyCode);

        return $this->getItemPricesDetails($itemTypeId, $distance, $couponCode, $walletAmount, $selectedCurrencyCode, $conversionRate);
    }

    public function updateItemDeliveredStatus(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'is_item_delivered' => 'required|boolean',
            'token' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);

        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $booking = Booking::where('id', $request->booking_id)
            ->where('host_id', $user_id)
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        $bookingExtension = BookingExtension::where('booking_id', $request->booking_id)->first();

        if (! $bookingExtension) {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        $bookingExtension->is_item_delivered = $request->is_item_delivered;
        $bookingExtension->save();

        // email sending
        $template_id = 43;
        $valuesArray = [];
        $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
        $dataVal['message_key'] = $booking;
        $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);

        return $this->addSuccessResponse(200, trans('global.item_delivered_status_updated'), ['booking_extension' => $bookingExtension]);
    }

    public function updateItemReceivedStatus(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'is_item_received' => 'required|boolean',
            'token' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);

        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $booking = Booking::where('id', $request->booking_id)
            ->where('userid', $user_id)
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }

        $bookingExtension = BookingExtension::where('booking_id', $request->booking_id)->first();

        if (! $bookingExtension) {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        if ($bookingExtension->is_item_delivered === 1) {

            $bookingExtension->is_item_received = $request->is_item_received;
            $bookingExtension->save();
            // email sending
            $template_id = 44;
            $valuesArray = [];
            $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
            $dataVal['message_key'] = $booking;
            $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);
        } else {
            return $this->addErrorResponse(404, trans('global.item_not_delivered_yet'), '');
        }

        return $this->addSuccessResponse(200, trans('global.item_received_status_updated'), ['booking_extension' => $bookingExtension]);
    }

    public function updateItemReturnedStatus(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'is_item_returned' => 'required|boolean',
            'token' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);

        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $booking = Booking::where('id', $request->booking_id)
            ->where('host_id', $user_id)
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }

        $bookingExtension = BookingExtension::where('booking_id', $request->booking_id)->first();

        if (! $bookingExtension) {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        if ($bookingExtension->is_item_received === 1) {
            $bookingExtension->is_item_returned = $request->is_item_returned;
            $bookingExtension->save();

            // email sending
            $template_id = 45;
            $valuesArray = [];
            $valuesArray = $this->createNotificationArray($booking->userid, $booking->host_id, $booking->itemid, $booking->id);
            $dataVal['message_key'] = $booking;
            $this->sendAllNotifications($valuesArray, $booking->userid, $template_id, $dataVal, $booking->host_id);
            $distributionResult = $this->distributeVendorCommission();
        } else {
            return $this->addErrorResponse(404, trans('global.booking_extension_not_found'), '');
        }

        return $this->addSuccessResponse(200, trans('global.item_returned_status_updated'), ['booking_extension' => $bookingExtension]);
    }

    public function updateBookingStatusByDriver(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'token' => 'required|exists:app_users,token',
            'status' => 'required|string|in:Pending,Ongoing,Accepted,Rejected,Completed,Cancelled',
            'estimated_duration_min' => 'nullable|integer|min:1',

        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user = AppUser::where('token', $request->input('token'))->first();
        if (! $user) {
            return $this->addErrorResponse(401, trans('global.token_not_match'), '');
        }

        $booking = Booking::where('id', $request->input('booking_id'))
            ->where('host_id', $user->id)
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }
        $booking->status = $request->input('status');
        if ($request->has('firebase_json')) {
            $booking->firebase_json = json_encode($request->input('firebase_json'));
        }

        if ($request->has('total_time_taken')) {
            $extension = $booking->extension;
            if ($extension) {
                $extension->estimated_duration_min = $request->input('total_time_taken');
                $extension->save();
            }
        }
        $booking->save();

        return $this->addSuccessResponse(200, trans('global.booking_status_updated_successfully'), [
            'booking_id' => $booking->id,
            'status' => $booking->status,
        ]);
    }

    public function updateBookingStatusByUser(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'token' => 'required|exists:app_users,token',
            'status' => 'required|string',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user = AppUser::where('token', $request->input('token'))->first();
        if (! $user) {
            return $this->addErrorResponse(401, trans('global.token_not_match'), '');
        }
        $booking = Booking::where('id', $request->input('booking_id'))
            ->where('userid', $user->id)
            ->first();
        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }
        $booking->status = $request->input('status');
        $booking->save();

        return $this->addSuccessResponse(200, trans('global.booking_status_updated_successfully'), [
            'booking_id' => $booking->id,
            'status' => $booking->status,
        ]);
    }

    public function updatePaymentStatusByDriver(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'token' => 'required|exists:app_users,token',
            'payment_method' => 'required|string', // You can customize the accepted methods like cash, online, etc.
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        $userid = $this->checkUserByToken($request->token);
        if (! $userid) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        $booking = Booking::where('id', $request->input('booking_id'))
            ->where('host_id', $userid)
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }
        if ($booking->payment_status == 'paid') {
            return $this->addErrorResponse(400, trans('global.payment_status_already_paid'), '');
        }
        $booking->payment_status = 'paid';
        $booking->payment_method = $request->input('payment_method');
        $booking->save();

        return $this->addSuccessResponse(200, trans('global.payment_status_updated_successfully'), [
            'booking_id' => $booking->id,
            'payment_status' => $booking->payment_status,
            'payment_method' => $booking->payment_method,
        ]);
    }

    public function updatePaymentStatusByUser(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'booking_id' => 'required|exists:bookings,id',
            'payment_method' => 'required',
            'token' => 'required|exists:app_users,token',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $userid = $this->checkUserByToken($request->token);
        if (! $userid) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        $existingBooking = Booking::where('id', $request->input('booking_id'))
            ->where('userid', $userid)
            ->first();

        if (! $existingBooking) {
            return $this->addErrorResponse(404, trans('global.booking_not_found'), '');
        }
        if ($existingBooking->payment_status == 'Paid') {
            return $this->addErrorResponse(400, trans('global.payment_already_processed'), '');
        }
        $booking = Booking::where('id', $request->input('booking_id'))
            ->where('userid', $userid)
            ->where('payment_status', 'notpaid')
            ->first();

        if (! $booking) {
            return $this->addErrorResponse(400, trans('global.booking_payment_status_invalid'), '');
        }
        $booking->payment_status = 'pending';
        $booking->payment_method = $request->payment_method;
        $booking->save();

        return $this->addSuccessResponse(200, trans('global.payment_status_updated_successfully'), [
            'booking_id' => $booking->id,
            'payment_status' => $booking->payment_status,
            'payment_method' => $booking->payment_method,
        ]);
    }
}

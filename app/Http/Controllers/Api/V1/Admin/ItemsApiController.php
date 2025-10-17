<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Traits\BookingAvailableTrait;
use App\Http\Controllers\Traits\FirestoreTrait;
use App\Http\Controllers\Traits\MediaUploadingTrait;
use App\Http\Controllers\Traits\MiscellaneousTrait;
use App\Http\Controllers\Traits\ResponseTrait;
use App\Models\AppUser;
use App\Models\Modern\Currency;
use App\Models\Modern\Item;
use App\Models\Modern\ItemDate;
use App\Models\Modern\ItemFeatures;
use App\Models\Modern\ItemMeta;
use App\Models\Modern\ItemType;
use App\Models\Modern\ItemVehicle;
use Carbon\Carbon;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Validator;

class ItemsApiController extends Controller
{
    use BookingAvailableTrait, FirestoreTrait, MediaUploadingTrait, MiscellaneousTrait, ResponseTrait;

    public function getItemDetails(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'item_id' => 'required|numeric',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        try {
            $itemId = $request->input('item_id');

            $user = null;
            if ($request->has('token')) {
                $user = AppUser::where('token', $request->input('token'))->first();
            }
            $selectedCurrencyCode = $request->input('selected_currency_code');
            $convertionRate = Currency::getValueByCurrencyCode($selectedCurrencyCode);

            $itemDetail = Item::with(['item_type:id,name', 'place:id,city_name', 'bookingPolicy:id,name,description', 'appUser:id,first_name,last_name,email,phone', 'appUser.metadata', 'reviews.guest:id', 'itemMeta'])
                ->where('id', $itemId)
                ->where('status', 1)
                ->firstOrFail();
            $itemMetaData = $itemDetail->itemMeta->keyBy('meta_key');

            // Define the expected meta keys and their default values
            $metaKeys = [
                'weekly_discount' => 'null',
                'weekly_discount_type' => 'percent',
                'monthly_discount' => 'null',
                'monthly_discount_type' => 'percent',
            ];
            $itemData = [
                'item_id' => $itemDetail->id,
                'title' => $itemDetail->title,
                'price' => $this->formatPriceWithConversion($itemDetail->price, $selectedCurrencyCode, $convertionRate),
                'description' => $itemDetail->description,
                'item_rating' => (string) $itemDetail->item_rating,
                'mobile' => $itemDetail->mobile,
                'status' => (string) $itemDetail->status,
                'address' => $itemDetail->address,
                'state_region' => (string) $itemDetail->state_region,
                'zip_postal_code' => (string) $itemDetail->zip_postal_code,
                'latitude' => (string) $itemDetail->latitude,
                'longitude' => (string) $itemDetail->longitude,
                'is_verified' => (string) $itemDetail->is_verified,
                'is_featured' => (string) $itemDetail->is_featured,
                'booking_policies_id' => (string) $itemDetail->booking_policies_id,

            ];
            foreach ($metaKeys as $key => $defaultValue) {
                $itemData[$key] = isset($itemMetaData[$key]) ? (string) $itemMetaData[$key]->meta_value : (string) $defaultValue;
            }
            $itemData['cancellation_reason']['title'] = $itemDetail->bookingPolicy->name;
            $itemData['cancellation_reason']['description'] = $itemDetail->bookingPolicy->description;
            $itemData['item_type'] = $itemDetail->item_type ? $itemDetail->item_type->name : '';

            $itemData['city'] = $itemDetail->place ? $itemDetail->place->city_name : '';

            $featutes = ItemFeatures::whereIn('id', explode(',', $itemDetail->features_id))->get();
            $featutesData = [];
            foreach ($featutes as $feature) {
                $featutesData[] = [
                    'id' => $feature->id,
                    'name' => $feature->name,
                    'image_url' => $feature->icon ? $feature->icon->url : null,
                ];
            }
            $itemData['amenities'] = $featutesData;
            $itemData['host_id'] = (string) $itemDetail->appUser->id;
            $playerIdMeta = $itemDetail->appUser->metadata->firstWhere('meta_key', 'player_id');
            $itemData['host_player_id'] = $playerIdMeta ? $playerIdMeta->meta_value : '';
            $itemData['host_first_name'] = $itemDetail->appUser->first_name;
            $itemData['host_last_name'] = $itemDetail->appUser->last_name;
            $itemData['host_email'] = $itemDetail->appUser->email;
            $itemData['host_phone'] = $itemDetail->appUser->phone;
            if (isset($itemDetail->appUser->profile_image->preview_url)) {
                $itemData['host_profile_image'] = $itemDetail->appUser->profile_image->preview_url;
            } else {
                $itemData['host_profile_image'] = null;
            }

            $frontImage = $itemDetail->front_image;
            $itemData['front_image_url'] = $frontImage ? $frontImage->url : null;
            $galleryImages = $itemDetail->gallery;
            $galleryImageUrls = [];
            foreach ($galleryImages as $image) {
                $galleryImageUrls[] = $image->url;
            }
            $itemData['gallery_image_urls'] = $galleryImageUrls;
            $reviewData = [];
            foreach ($itemDetail->reviews as $review) {

                if (empty($review->guest->profile_image->url)) {
                    $profile_image = 'null';
                } else {
                    $profile_image = $review->guest->profile_image->url;
                }
                $reviewData[] = [
                    'id' => $review->id,
                    'booking_id' => (string) $review->bookingid,
                    'guest_id' => (string) $review->guestid,
                    'guest_name' => $review->guest_name,
                    'guest_profile_image' => $profile_image,
                    'rating' => (string) $review->guest_rating,
                    'message' => $review->guest_message,
                    'created_at' => $review->created_at->format('F Y'),
                    'updated_at' => $review->updated_at->format('F Y'),
                ];
            }
            $itemData['reviews'] = $reviewData;
            $itemData['total_reviews'] = $itemDetail->reviews->count();

            $itemDates = ItemDate::where('item_id', $itemId)
                ->where('date', '>=', Carbon::today())
                ->orderBy('date', 'asc')
                ->get();

            $availableDates = [];
            $notAvailableDates = [];
            foreach ($itemDates as $date) {
                if ($date->status === 'Available') {
                    $availableDates[] = [
                        'date' => $date->date,
                        'price' => $this->formatPriceWithConversion(($date->price > 0 ? $date->price : $itemDetail->price), $selectedCurrencyCode, $convertionRate, 1),
                    ];
                } else {
                    $notAvailableDates[] = [
                        'date' => $date->date,
                        'price' => $this->formatPriceWithConversion($date->price, $selectedCurrencyCode, $convertionRate, 1),
                    ];
                }
            }

            if (! empty($availableDates)) {
                $currentDate = date('Y-m-d');
                $currentDatePrices = array_filter($availableDates, function ($dateDetails) use ($currentDate) {
                    return $dateDetails['date'] === $currentDate;
                });
                $maxPrice = $currentDatePrices ? reset($currentDatePrices)['price'] : min(array_column($availableDates, 'price'));
            } else {
                $maxPrice = $itemData['price'];
            }

            if ($maxPrice > 0) {
                $propertyData['price'] = $this->formatPriceWithConversion($maxPrice, $selectedCurrencyCode, $convertionRate, 1);
            }

            $notAvailableDatesMap = [];
            foreach ($notAvailableDates as $dateInfo) {
                $notAvailableDatesMap[$dateInfo['date']] = $dateInfo['price'];
            }
            $availableDatesMap = [];
            foreach ($availableDates as $dateInfo) {
                $availableDatesMap[$dateInfo['date']] = $dateInfo['price'];
            }
            $startDate = new DateTime;
            $endDate = (new DateTime)->modify('+2 months');
            while ($startDate <= $endDate) {
                $dateStr = $startDate->format('Y-m-d');
                if (isset($notAvailableDatesMap[$dateStr])) {
                    $startDate->modify('+1 day');

                    continue;
                }
                if (isset($availableDatesMap[$dateStr])) {
                    $startDate->modify('+1 day');

                    continue;
                }
                $availableDates[] = [
                    'date' => $dateStr,
                    'price' => $this->formatPriceWithConversion($itemDetail->price, $selectedCurrencyCode, $convertionRate),
                ];
                $availableDatesMap[$dateStr] = $itemDetail->price;
                $startDate->modify('+1 day');
            }

            $itemData['available_dates'] = $availableDates;
            $itemData['not_available_dates'] = $notAvailableDates;
            $itemData['item_info'] = $this->getModuleInfoValues('', $itemId);
            if ($user) {
                $itemData['is_in_wishlist'] = $user->itemWishlists()
                    ->where('item_id', $itemId)
                    ->exists();
            } else {
                $itemData['is_in_wishlist'] = false;
            }
            $itemDetail->increment('views_count');
            $itemDetail->save();

            return $this->addSuccessResponse(200, trans('global.Result_found'), ['ItemDetails' => $itemData]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {

            return $this->addErrorResponse(500, trans('global.item_not_found'), '');
        } catch (Exception $e) {
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function insertItem_bkp(Request $request)
    {

        // $myfile = fopen($_SERVER['DOCUMENT_ROOT'] . "/api-result/InsertItemData.txt", "w") or die("Unable to open file!");
        // $requestData = json_encode($request->all(), JSON_PRETTY_PRINT);
        // fwrite($myfile, $requestData);
        // fclose($myfile);
        // Validate the request parameters
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'item_type_id' => 'required|exists:rental_item_types,id',
            'features_id' => 'nullable',
            'features_id.*' => 'exists:features,id',
            'place_id' => 'required|exists:cities,id',
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'item_rating' => 'nullable|numeric',
            'mobile' => 'nullable|string|max:255',
            'status' => 'nullable|string|max:255',
            'price' => 'nullable|numeric',
            'address' => 'nullable|string',
            'state_region' => 'nullable|string|max:255',
            'zip_postal_code' => 'nullable|string|max:255',
            'platitude' => 'nullable|string|max:255',
            'plongitude' => 'nullable|string|max:255',
            'is_verified' => 'nullable|string|max:255',
            'is_featured' => 'nullable|boolean',
            'weekly_discount' => 'nullable|integer',
            'weekly_discount_type' => 'required|string',
            'monthly_discount' => 'nullable|integer',
            'monthly_discount_type' => 'required|string',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        $module = $this->getModuleIdOrDefault($request);

        $remainingItems = $this->checkRemainingItems($user_id, $module);

        if ($remainingItems === null) {
            return $this->addErrorResponse(402, 'Item limit Exceeded', '');
        }

        // try {
        $Item = new Item;
        $Item->userid_id = $user_id;
        $Item->item_type_id = $request->input('item_type_id');

        $featuresString = str_replace(']', '', str_replace('[', '', $request->input('features_id')));
        $Item->features_id = $featuresString;
        $Item->place_id = $request->input('place_id');
        $Item->title = $request->input('title');
        $Item->description = $request->input('description');
        $Item->item_rating = '0';
        $Item->mobile = '';
        $Item->status = 0;
        $Item->price = $request->input('price');
        $Item->address = $request->input('address');
        $Item->state_region = $request->input('state_region');
        $Item->zip_postal_code = $request->input('zip_postal_code');
        $Item->city_name = $request->input('city_name');
        $Item->country = $request->input('country');
        $Item->latitude = $request->input('platitude');
        $Item->longitude = $request->input('plongitude');
        $Item->is_verified = 0;
        $Item->is_featured = 0;
        $Item->booking_policies_id = $request->input('booking_policies_id');
        $Item->token = $this->generateUniqueToken();

        $steps = [
            'basic' => true,
            'title' => true,
            'location' => true,
            'features' => true,
            'price' => true,
            'policies' => true,
            'photos' => false,
            'document' => false,
            'calendar' => false,
        ];

        $Item->steps_completed = json_encode($steps);
        $Item->step_progress = 66.66;
        $Item->module = $module;
        $Item->save();
        if ($request->has('availability_dates')) {
            $availabilityDatesArray = json_decode($request->input('availability_dates'), true);
            foreach ($availabilityDatesArray as $index => $availabilityDates) {
                foreach ($availabilityDates as $date) {
                    $itemDate = new ItemDate;
                    $itemDate->item_id = $Item->id;
                    $itemDate->date = $date['date'];
                    $itemDate->status = $date['status'];
                    $itemDate->price = $date['price'];
                    $itemDate->range_index = $index;
                    $itemDate->save();
                }
            }
        }

        $this->insertItemMetaData($request, $module, $Item->id);
        $itemMetaInfo = $this->getModuleInfoValues($module, $Item->id);
        $data = [
            'itemMetaInfo' => $itemMetaInfo ?? null,
        ];
        $this->addOrUpdateItemMeta($Item->id, $data);

        $discountData = [
            'weekly_discount' => $request->input('weekly_discount'),
            'weekly_discount_type' => $request->input('weekly_discount_type', 'percent'), // Default to 'percent'
            'monthly_discount' => $request->input('monthly_discount'),
            'monthly_discount_type' => $request->input('monthly_discount_type', 'percent'), // Default to 'percent'
        ];
        $this->addOrUpdateItemMeta($Item->id, $discountData);

        if ($request->input('front_image')) {
            $frontImage = $request->input('front_image');
            $frontImageUrl = $this->serveBase64Image($frontImage);
            $Item->addMedia($frontImageUrl)->toMediaCollection('front_image');
        }
        if ($request->input('gallery_image')) {
            $gallery_images = explode('##', $request->input('gallery_image'));
            foreach ($gallery_images as $galleryImage) {

                $gallaeryImageUrl[] = $this->serveBase64Image($galleryImage);
            }
            foreach ($gallaeryImageUrl as $url) {
                $Item->addMedia($url)->toMediaCollection('gallery');
            }
        }

        return $this->addSuccessResponse(200, trans('global.item_added'), $Item);
        try {
        } catch (\Exception $e) {

            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function insertItem(Request $request)
    {

        // $myfile = fopen($_SERVER['DOCUMENT_ROOT'] . "/api-result/InsertItemData.txt", "w") or die("Unable to open file!");
        // $requestData = json_encode($request->all(), JSON_PRETTY_PRINT);
        // fwrite($myfile, $requestData);
        // fclose($myfile);
        // Validate the request parameters
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'item_type_id' => 'required|exists:rental_item_types,id',
            'description' => 'nullable|string',
            'item_rating' => 'nullable|numeric',
            'status' => 'nullable|string|max:255',
            'address' => 'nullable|string',
            'state_region' => 'nullable|string|max:255',
            'zip_postal_code' => 'nullable|string|max:255',
            'platitude' => 'nullable|string|max:255',
            'plongitude' => 'nullable|string|max:255',
            'is_verified' => 'nullable|string|max:255',
            'is_featured' => 'nullable|boolean',
        ]);

        // Check if validation fails
        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        $module = $this->getModuleIdOrDefault($request);

        $remainingItems = $this->checkRemainingItems($user_id, $module);

        if ($remainingItems === null) {
            return $this->addErrorResponse(402, 'Item limit Exceeded', '');
        }

        // try {
        $Item = new Item;
        $Item->userid_id = $user_id;
        $Item->item_type_id = $request->input('item_type_id');

        $Item->description = $request->input('description');
        $Item->item_rating = '0';
        $Item->status = 0;
        $Item->address = $request->input('address');
        $Item->state_region = $request->input('state_region');
        $Item->zip_postal_code = $request->input('zip_postal_code');
        $Item->city_name = $request->input('city_name');
        $Item->country = $request->input('country');
        $Item->latitude = $request->input('platitude');
        $Item->latitude = $request->input('platitude');
        $Item->longitude = $request->input('plongitude');
        $Item->token = $this->generateUniqueToken();

        $Item->module = $module;
        $Item->save();

        if ($request->input('front_image')) {

            $frontImage = $request->input('front_image');
            $frontImageUrl = $this->serveBase64Image($frontImage);
            $Item->addMedia($frontImageUrl)->toMediaCollection('front_image');
        }

        if ($request->has('vehicle_registration_doc') && $request->input('vehicle_registration_doc')) {

            $frontImageDoc = $request->input('vehicle_registration_doc');
            $frontImageDocUrl = $this->serveBase64Image($frontImageDoc);
            $Item->addMedia($frontImageDocUrl)->toMediaCollection('vehicle_registration_doc');
        }

        if ($request->has('vehicle_insurance_doc') && $request->input('vehicle_insurance_doc')) {

            $insuranceDoc = $request->input('vehicle_insurance_doc');
            $insuranceDocUrl = $this->serveBase64Image($insuranceDoc);
            $Item->addMedia($insuranceDocUrl)->toMediaCollection('vehicle_insurance_doc');
        }

        $this->insertItemMetaData($request, $module, $Item->id);
        $itemMetaInfo = $this->getModuleInfoValues($module, $Item->id);
        $data = [
            'itemMetaInfo' => $itemMetaInfo ?? null,
        ];
        $this->addOrUpdateItemMeta($Item->id, $data);

        return $this->addSuccessResponse(200, trans('global.item_added'), $Item);
        try {
        } catch (\Exception $e) {

            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function editItem(Request $request)
    {

        $data = json_encode($request->all())."\n";
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'item_type_id' => 'required|exists:rental_item_types,id',
            'item_rating' => 'nullable|numeric',
            'status' => 'nullable|string|max:255',
            'address' => 'nullable|string',
            'state_region' => 'nullable|string|max:255',
            'zip_postal_code' => 'nullable|string|max:255',
            'platitude' => 'nullable|string|max:255',
            'plongitude' => 'nullable|string|max:255',
            'is_verified' => 'nullable|string|max:255',
            'is_featured' => 'nullable|boolean',

        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        // try {

        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        $item = Item::where('id', $request->input('id'))->where('userid_id', $user_id)->first();
        $item->update([
            'item_type_id' => $request->item_type_id,
            'status' => $item->status,
            'place_id' => $request->place_id,
            'latitude' => $request->platitude,
            'longitude' => $request->plongitude,
            'make' => $request->make,
            'model' => $request->model,
            'registration_number' => $request->registration_number,

        ]);
        ItemVehicle::updateOrCreate(
            ['item_id' => $item->id],
            [
                'year' => $request->year,
                'color' => $request->color,
            ]
        );
        $userData = AppUser::find($user_id);

        if (! $userData->firestore_id) {
            $firestoreData = $this->generateDriverFirestoreData($userData);
            $firestoreDoc = $this->storeDriverInFirestore($firestoreData);
            $firestoreDocId = $firestoreDoc->id();

            $userData->update([
                'firestore_id' => $firestoreDocId,
                'user_type' => 'driver',
            ]);

            $user['firestore_id'] = $firestoreDocId;
        }

        $firestoreData = $this->generateDriverFirestoreData($userData);
        $documentId = $userData->firestore_id;
        $this->updateDocument('drivers', $documentId, $firestoreData);

        return $this->addSuccessResponse(200, trans('global.item_updated_successfully'), $item);

        try {
        } catch (ModelNotFoundException $e) {
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        } catch (\Exception $e) {
            // update, return a generic error response
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function deleteItem(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'id' => 'required|exists:rental_items,id',
                'token' => 'required|exists:app_users,token',
            ]);

            if ($validator->fails()) {
                return $this->errorComputing($validator);
            }

            $user = AppUser::where('token', $request->input('token'))->first();

            if (! $user) {
                return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            }

            $item = Item::where('id', $request->input('id'))
                ->where('userid_id', $user->id)
                ->first();

            if (! $item) {
                return $this->errorResponse(404, trans('global.item_not_found'));
            }

            // Delete associated media
            $item->getMedia('gallery')->each(function ($media) {
                $media->delete();
            });

            if ($item->front_image) {
                $item->front_image->delete();
            }

            // Delete item
            $item->delete();

            return $this->addSuccessResponse(200, trans('global.item_deleted_successfully'), []);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function deletefrontimage(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'item_id' => 'required|exists:rental_items,id',
        ]);
        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        try {
            $user_id = $this->checkUserByToken($request->token);
            if (! $user_id) {
                return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            }
            $item = Item::where('id', $request->item_id)->where('userid_id', $user_id)->first();
            if ($item->front_image) {
                $item->front_image->delete();
            } else {
                return $this->addErrorResponse(500, trans('global.please_upload_image_after_delete'), '');
            }

            return $this->addSuccessResponse(200, trans('global.Deleted_successful '), '');
        } catch (\Exception $e) {
            // update, return a generic error response
            return response()->json([
                'message' => trans('global.Failed_to_delete_front_image_Please_try_again_later'),
            ], 500);
        }
    }

    public function deletegalleryimage(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
            'item_id' => 'required|exists:rental_items,id',
        ]);
        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        // try {
        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        $item = Item::where('id', $request->item_id)->where('userid_id', $user_id)->first();

        if (count($item->gallery) > 0) {
            foreach ($item->gallery as $media) {
                $media->delete();
            }
        } else {
            return $this->addErrorResponse(500, trans('global.please_upload_image_after_delete'), '');
        }

        return $this->addSuccessResponse(200, trans('global.Deleted_successful '), '');
        try {
        } catch (\Exception $e) {
            // update, return a generic error response
            return response()->json([
                'message' => trans('global.Failed_to_delete_gallery_image_Please_try_again_later'),
            ], 500);
        }
    }

    public function myItems(Request $request)
    {

        try {
            $validator = Validator::make($request->all(), [
                'token' => 'required|exists:app_users,token',
            ]);

            if ($validator->fails()) {
                return $this->errorComputing($validator);
            }

            $limit = (int) $request->input('limit', 10);
            $offset = (int) $request->input('offset', 0);
            $search = $request->input('search');

            $user = AppUser::select('id', 'host_status')->where('token', $request->token)->first();

            if (! $user) {
                return $this->addErrorResponse(419, trans('front.token_not_match'), '');
            }

            $user_id = $user->id;
            $hostStatus = $user->host_status;
            if (! $user_id) {
                return $this->addErrorResponse(419, trans('front.token_not_match'), '');
            }

            $module = $this->getModuleIdOrDefault($request);
            $checkLimit = 1;
            $itemsQuery = Item::with(['item_type', 'itemVehicle'])
                ->where('userid_id', $user_id)
                ->where('module', $module);
            if (! empty($search)) {
                $itemsQuery->where('title', 'like', "%{$search}%");
            }
            $items = $itemsQuery->skip($offset)->take($limit)->get();
            $formattedItems = $items->map(function ($item) {
                $item['item_type'] = $item->itemType->name ?? '';
                $latitude = $item->latitude;
                $longitude = $item->longitude;
                unset($item->latitude);
                unset($item->longitude);
                $item['year'] = $item->itemVehicle->year ?? null;
                $item['color'] = $item->itemVehicle->color ?? null;
                $item['latitude'] = $latitude;
                $item['longitude'] = $longitude;

                return $item;
            });

            $nextOffset = $formattedItems->isNotEmpty() ? $offset + $formattedItems->count() : -1;
            $responseData = [
                'items' => $formattedItems,
                'offset' => $nextOffset,
                'limit' => $limit,
                'host_status' => $hostStatus,
                'checkLimit' => $checkLimit,
            ];

            return $this->addSuccessResponse(200, trans('front.item_found'), $responseData);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, trans('front.something_wrong'), $e->getMessage());
        }
    }

    public function getItemsByLocation(Request $request)
    {
        $validator = Validator::make($request->all(), [

            'offset' => 'nullable|numeric|min:0',
            'limit' => 'nullable|numeric|min:1',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }
        $module = $this->getModuleIdOrDefault($request);
        try {
            $user = null;
            // if ($request->has('token')) {
            //     $user = AppUser::where('token', $request->input('token'))->first();
            // }
            // if (!$user) {
            //     return $this->addErrorResponse(500, trans('global.token_not_match'), '');
            // }
            $offset = $request->input('offset', 0);
            $limit = $request->input('limit', 10);

            $locationItem = Item::where('place_id', $request->location_id)
                ->orderBy('id')
                ->where('status', 1)
                ->where('module', $module)
                ->skip($offset)
                ->take($limit)
                ->get()
                ->map(function ($item) use ($user) {

                    $formattedItem = $this->formatItemData($item);
                    if ($user) {
                        $formattedItem['is_in_wishlist'] = $user->itemWishlists()
                            ->where('item_id', $item->id)
                            ->exists();
                    } else {
                        $formattedItem['is_in_wishlist'] = false;
                    }

                    $itemType = ItemType::find($item->item_type_id);
                    $formattedItem['item_type'] = $itemType ? $itemType->name : '';

                    return $formattedItem;
                });

            // Calculate the offset for the next page
            $nextOffset = $offset + count($locationItem);

            if ($locationItem->isEmpty()) {
                $nextOffset = -1;
            }

            return $this->addSuccessResponse(200, trans('global.Result_found'), [
                'items' => $locationItem,
                'offset' => $nextOffset,
                'limit' => $limit,
            ]);
        } catch (Exception $e) {
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function itemSearch(Request $request)
    {
        // try {
        $offset = $request->input('offset', 0);
        $limit = $request->input('limit', 20);
        $limit = 30;
        $module = $this->getModuleIdOrDefault($request);
        $query = Item::query();
        $latitude = $request->input('Slatitude');
        $longitude = $request->input('Slongitude');
        $checkInDate = $request->input('check_in');
        $checkOutDate = $request->input('check_out');

        // $myfile = fopen($_SERVER['DOCUMENT_ROOT'] . "/api-result/newitemsearch.txt", "w") or die("Unable to open file!");
        // $requestData = json_encode($request->all(), JSON_PRETTY_PRINT);
        // fwrite($myfile, $requestData);
        // fclose($myfile);

        $selectedCurrencyCode = $request->input('selected_currency_code');
        $convertionRate = Currency::getValueByCurrencyCode($selectedCurrencyCode);
        $miles = 31; // near about 50 km

        if ($request->input('search_on_map') == 1) {
            $miles = 80000;
        }

        if (! empty($request->input('Slatitude')) && ! empty($request->input('Slongitude'))) {

            $query->selectRaw('*, ( 3959 * acos( cos( radians(?) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(?) ) + sin( radians(?) ) * sin(radians(latitude)) ) ) AS distance', [$latitude, $longitude, $latitude])
                ->havingRaw('distance < ?', [$miles]);
        }

        $query->where('status', '1');
        $query->where('module', $module);
        if (! empty($request->input('title'))) {
            $title = $request->input('title');
            $query->where('title', 'LIKE', '%'.$title.'%');
        }

        if (! empty($request->input('country'))) {
            $query->where('country', $request->input('country'));
        }
        // if (!empty($request->input('state'))) {
        //     $state = $request->input('state');
        //     $query->where('state_region', 'LIKE', "%$state%");
        // }
        // if (!empty($request->input('city')) && $request->input('city') != $request->input('state')) {
        //     $city = $request->input('city');
        //     $query->where('city_name', 'LIKE', "%$city%");
        // }

        if (! empty($request->input('price'))) {
            $priceRange = explode('-', $request->input('price'));
            if (count($priceRange) === 2) {
                $query->whereBetween('price', [$priceRange[0], $priceRange[1]]);
            }
        }

        // $item_type_val = str_replace("]", "", str_replace("[", "", $request->input('item_type_search')));
        // if (!empty($item_type_val)) {
        //     $itemTypes = is_array($item_type_val) ?
        //         $item_type_val : explode(',', $item_type_val);
        //     if (!empty($itemTypes)) {
        //         $query->whereIn('item_type_id', $itemTypes);
        //     }
        // }

        $item_type_val = str_replace(']', '', str_replace('[', '', $request->input('item_type')));

        if ($item_type_val !== '0' && ! empty($item_type_val)) {
            $itemTypes = is_array($item_type_val) ? $item_type_val : explode(',', $item_type_val);
            if (! empty($itemTypes)) {
                $query->whereIn('item_type_id', $itemTypes);
            }
        }

        $facility_val = str_replace(']', '', str_replace('[', '', $request->input('facility')));
        if (! empty($facility_val)) {
            $features = is_array($facility_val) ?
                $facility_val : explode(',', $facility_val);
            if (! empty($features)) {
                foreach ($features as $featuresId) {
                    $query->whereRaw('FIND_IN_SET(?, features_id)', [$featuresId]);
                }
            }
        }
        // new code comment for Vechile

        if ($module == 2) {
            $makeType = $request->input('meta');

            if (! empty($makeType)) {
                $makeTypeDecoded = json_decode($makeType, true);
                if (isset($makeTypeDecoded['make_type']) && ! empty($makeTypeDecoded['make_type'])) {
                    $makeTypeArray = json_decode($makeTypeDecoded['make_type'], true);
                    if (is_array($makeTypeArray) && ! empty($makeTypeArray)) {

                        $query->whereIn('category_id', $makeTypeArray);
                    }
                }
            }
        }

        $user = null;
        if ($request->has('token')) {
            $user = AppUser::where('token', $request->input('token'))->first();
        }

        $allowedModules = $this->sameDayBookingModule();
        $AvailableItemsForPrice = collect();
        $itemIDs = $query->pluck('id');
        if (! empty($request->input('check_in')) && ! empty($request->input('check_out'))) {
            $currentDate = Carbon::parse($checkInDate);
            $endDate = Carbon::parse($checkOutDate);
            if (in_array($module, $allowedModules)) {
                $endDate = Carbon::parse(date('Y-m-d', strtotime($checkOutDate.' + 1 day')));
            }
            $dates = [];
            while ($currentDate < $endDate) {
                $dates[] = $currentDate->toDateString();
                $currentDate->addDay();
            }

            $notAvailableItems = ItemDate::select('item_id')
                ->whereIn('date', $dates)
                ->whereIn('item_id', $itemIDs)
                ->where('status', 'Not available')
                ->groupBy('item_id')
                ->get();

            $notAvailableItemsID = $notAvailableItems->pluck('item_id');
            $availableItemIds = $itemIDs->diff($notAvailableItemsID);

            $AvailableItemsForPrice = ItemDate::select('item_id', DB::raw('MIN(price) as min_price'))
                ->whereIn('date', $dates)
                ->whereIn('item_id', $availableItemIds)
                ->where('status', 'Available')
                ->groupBy('item_id')
                ->get();

            $query->whereIn('id', $availableItemIds);
        }

        if ($module == 2) {
            if (! empty($request->input('odometer'))) {
                $odometerArray = json_decode($request->input('odometer'), true);
                if (is_array($odometerArray) && ! empty($odometerArray)) {
                    $query->whereHas('itemVehicle', function ($q) use ($odometerArray) {
                        $q->whereIn('odometer', $odometerArray);
                    });
                }
            }
            if (! empty($request->input('modelYear'))) {
                $modelYearArray = json_decode($request->input('modelYear'), true);
                if (is_array($modelYearArray) && ! empty($modelYearArray)) {
                    $query->whereHas('itemVehicle', function ($q) use ($modelYearArray) {
                        $q->whereIn('year', $modelYearArray);
                    });
                }
            }
        }
        // Sorting

        $sort = $request->input('sort');
        if ($sort == 'cheapest_price') {
            $query->orderBy('price', 'asc');
        } elseif ($sort == 'nearest_location' && ! empty($latitude) && ! empty($longitude)) {
            $query->orderBy('distance', 'asc');
        } elseif ($sort == 'most_viewed') {
            $query->orderBy('views_count', 'desc');
        } elseif (! empty($latitude) && ! empty($longitude)) {
            $query->orderBy('distance', 'asc');
        }

        $items = $query->with('item_Type:id,name')->skip($offset)->take($limit)->get();

        $formattedItems = $items->map(function ($item) use ($user, $AvailableItemsForPrice, $convertionRate, $selectedCurrencyCode) {
            $formattedItem = $this->formatItemData($item);
            if ($user) {
                $formattedItem['is_in_wishlist'] = $user->itemWishlists()
                    ->where('item_id', $item->id)
                    ->exists();
            } else {
                $formattedItem['is_in_wishlist'] = false;
            }

            $formattedItem['distance'] = $item->distance ? number_format($item->distance, 2).' km' : null;
            $formattedItem['item_type'] = $item->item_Type ? $item->item_Type->name : '';
            $priceItem = $AvailableItemsForPrice->firstWhere('item_id', $item->id);
            if ($priceItem) {
                $formattedItem['price'] = $priceItem->min_price;
            }
            $formattedItem['price'] = $this->formatPriceWithConversion($formattedItem['price'], $selectedCurrencyCode, $convertionRate);

            return $formattedItem;
        });

        $nextOffset = $offset + count($formattedItems);
        if ($formattedItems->isEmpty()) {
            $nextOffset = -1;
        }

        return $this->addSuccessResponse(200, trans('global.itemType_found'), [
            'items' => $formattedItems,
            'offset' => $nextOffset,
            'limit' => $limit,
        ]);
        try {
        } catch (\Exception $e) {
            // Handle exceptions here
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function addEditItemImage(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:rental_items,id',
            'token' => 'required|exists:app_users,token',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }
        try {
            $item = Item::where('id', $request->input('id'))->where('userid_id', $user_id)->first();
            $steps = json_decode($item->steps_completed, true) ?: [];

            // Define progress increments

            $photoIncrement = 0;
            $documentIncrement = 0;

            if ($request->input('front_image')) {

                if ($item->hasMedia('front_image')) {

                    $item->getFirstMedia('front_image')->delete();
                }

                $frontImage = $request->input('front_image');
                $frontImageUrl = $this->serveBase64Image($frontImage);
                $item->addMedia($frontImageUrl)->toMediaCollection('front_image');

                if (isset($steps['photos']) && $steps['photos'] === false) {
                    $steps['photos'] = true;
                    $photoIncrement = 11.11;
                }
            }
            $gallery_image_delete = explode(',', str_replace(']', '', str_replace('[', '', $request->input('gallery_image_delete'))));

            if (! empty($gallery_image_delete)) {
                foreach ($gallery_image_delete as $val) {
                    $url = $val;
                    $fileName = basename($url);

                    // $media = Media::where('file_name', 'LIKE', '%' . $fileName . '%')
                    //     ->where('model_id', $request->input('id'))
                    //     ->first();
                    $media = Media::where('file_name', $fileName)
                        ->where('model_id', $request->input('id')) // Ensure the model_id matches the given ID
                        ->first();
                    if ($media) {
                        $media->delete();
                    }
                }
            }
            if ($request->input('gallery_image')) {
                $gallery_images = explode('##', $request->input('gallery_image'));
                foreach ($gallery_images as $galleryImage) {
                    $gallaeryImageUrl[] = $this->serveBase64Image($galleryImage);
                }
                foreach ($gallaeryImageUrl as $url) {

                    $item->addMedia($url)->toMediaCollection('gallery');
                }
            }
            if ($request->has('vehicle_registration_doc') && $request->input('vehicle_registration_doc')) {

                if ($item->hasMedia('vehicle_registration_doc')) {
                    $item->getFirstMedia('vehicle_registration_doc')->delete();
                }

                $frontImageDoc = $request->input('vehicle_registration_doc');
                $frontImageDocUrl = $this->serveBase64Image($frontImageDoc);
                $item->addMedia($frontImageDocUrl)->toMediaCollection('vehicle_registration_doc');

                if (isset($steps['document']) && $steps['document'] === false) {
                    $steps['document'] = true;
                    $documentIncrement = 11.11;
                }
            }

            if ($photoIncrement > 0 || $documentIncrement > 0) {
                if (isset($steps['photos']) && $steps['photos']) {
                    if ($item->step_progress < 100) {
                        $item->step_progress += $photoIncrement;
                    }
                }
                if (isset($steps['document']) && $steps['document']) {
                    if ($item->step_progress < 100) {
                        $item->step_progress += $documentIncrement;
                    }
                }

                // Ensure step_progress does not exceed 100
                if ($item->step_progress > 100) {
                    $item->step_progress = 100;
                }

                $item->steps_completed = json_encode($steps);
                $item->save();
            }

            $itemMetaInfo = $this->getModuleInfoValues($request->module_id, $item->id);
            $data = [
                'itemMetaInfo' => $itemMetaInfo ?? null,
            ];
            $this->addOrUpdateItemMeta($item->id, $data);

            return $this->addSuccessResponse(200, trans('global.images_added_successfully'), $item);
        } catch (\Exception $e) {
            // update, return a generic error response
            return $this->addErrorResponse(500, trans('global.something_wrong'), $e->getMessage());
        }
    }

    public function addEditItemDocuments(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:rental_items,id',
            'token' => 'required|exists:app_users,token',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        try {
            $item = Item::where('id', $request->input('id'))->where('userid_id', $user_id)->first();
            $imageFields = [
                'driving_licence',
                'driver_authorization',
                'hire_service_licence',
                'inspection_certificate',
            ];
            $uploadedImages = [];

            foreach ($imageFields as $field) {
                if ($request->has($field) && ! empty($request->input($field))) {
                    if ($item->hasMedia($field)) {
                        $item->getFirstMedia($field)->delete();
                    }

                    $imageData = $request->input($field);
                    $imageUrl = $this->serveBase64Image($imageData);
                    $item->addMedia($imageUrl)->toMediaCollection($field);
                    $uploadedImages[$field] = $imageUrl;

                    ItemMeta::updateOrCreate(
                        ['rental_item_id' => $item->id, 'meta_key' => $field.'_status'],
                        ['meta_value' => 'pending']
                    );
                }
            }

            if (empty($uploadedImages)) {
                return $this->addErrorResponse(500, trans('global.No_image_found_in_the_request'), '');
            }

            $item->save();
            $itemMeta = ItemMeta::where('rental_item_id', $item->id)->get();
            $item->meta_data = $itemMeta;

            return $this->addSuccessResponse(200, trans('global.images_added_successfully'), $item);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, $e->getMessage(), $e->getMessage());
        }
    }

    public function getItemDocuments(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required|exists:app_users,token',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        // Get the user ID from token
        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        // Fetch all items for the user with media and meta in a single query
        $items = Item::where('userid_id', $user_id)
            ->with(['media', 'itemMeta']) // Eager load media & meta
            ->get();

        if ($items->isEmpty()) {
            return $this->addErrorResponse(404, trans('global.no_items_found'), '');
        }

        // Define document keys
        $imageFields = [
            'driving_licence',
            'driver_authorization',
            'hire_service_licence',
            'inspection_certificate',
        ];

        $itemsData = [];

        foreach ($items as $item) {
            $documentData = [];

            // Convert item metadata into a key-value array for easy lookup
            $metaData = $item->itemMeta->pluck('meta_value', 'meta_key');

            foreach ($imageFields as $field) {
                // Get media URL from the preloaded media collection
                $file = $item->getMedia($field)->last();
                $imageUrl = $file ? $file->getUrl() : null;

                // Get metadata status from the preloaded metadata collection
                $metaKey = "{$field}_status";
                $metaStatus = $metaData[$metaKey] ?? '';

                // Structure the response for each document
                $documentData[$field] = [
                    "{$field}_image" => $imageUrl,
                    "{$field}_status" => $metaStatus,
                ];
            }

            // Add item data to the response
            $itemsData[] = [
                'item_id' => $item->id,
                'documents' => $documentData,
            ];
        }

        return $this->addSuccessResponse(200, trans('global.items_documents_fetched_successfully'), $itemsData);
    }

    public function addEditItemImages(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|exists:rental_items,id',
            'token' => 'required|exists:app_users,token',
        ]);

        if ($validator->fails()) {
            return $this->errorComputing($validator);
        }

        $user_id = $this->checkUserByToken($request->token);
        if (! $user_id) {
            return $this->addErrorResponse(500, trans('global.token_not_match'), '');
        }

        try {
            $item = Item::where('id', $request->input('id'))->where('userid_id', $user_id)->first();

            if (! $item) {
                return $this->addErrorResponse(404, trans('global.item_not_found'), '');
            }

            // FRONT IMAGE
            if ($request->input('front_image')) {
                if ($item->hasMedia('front_image')) {
                    $item->getFirstMedia('front_image')->delete();
                }
                $frontImage = $request->input('front_image');
                $frontImageUrl = $this->serveBase64Image($frontImage);
                $item->addMedia($frontImageUrl)->toMediaCollection('front_image');
            }

            // FRONT IMAGE DOC
            if ($request->has('vehicle_registration_doc') && $request->input('vehicle_registration_doc')) {
                if ($item->hasMedia('vehicle_registration_doc')) {
                    $item->getFirstMedia('vehicle_registration_doc')->delete();
                }
                $frontImageDoc = $request->input('vehicle_registration_doc');
                $frontImageDocUrl = $this->serveBase64Image($frontImageDoc);
                $item->addMedia($frontImageDocUrl)->toMediaCollection('vehicle_registration_doc');
            }

            // INSURANCE DOC
            if ($request->has('vehicle_insurance_doc') && $request->input('vehicle_insurance_doc')) {
                if ($item->hasMedia('vehicle_insurance_doc')) {
                    $item->getFirstMedia('vehicle_insurance_doc')->delete();
                }
                $insuranceDoc = $request->input('vehicle_insurance_doc');
                $insuranceDocUrl = $this->serveBase64Image($insuranceDoc);
                $item->addMedia($insuranceDocUrl)->toMediaCollection('vehicle_insurance_doc');
            }

            return $this->addSuccessResponse(200, trans('global.images_added_successfully'), $item);
        } catch (\Exception $e) {
            return $this->addErrorResponse(500, $e->getMessage(), $e->getMessage());
        }
    }
}

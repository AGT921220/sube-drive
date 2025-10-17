<?php

namespace App\Jobs;

use App\Models\Booking;
use App\Models\VendorWallet;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class DistributeVendorCommissionJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function handle()
    {
        try {
            DB::transaction(function () {
                $currentDate = Carbon::now();
                Booking::where('status', 'Completed')
                    ->where('vendor_commission_given', 0)
                    ->where('payment_method', '!=', 'cash')
                    ->chunkById(100, function ($bookings) use ($currentDate) {
                        $updates = [];
                        $walletInserts = [];

                        foreach ($bookings as $booking) {
                            $description = "Credited {$booking->vendor_commission} to vendor ID {$booking->host_id} for Booking #{$booking->id}";
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
                    });
            });

            Log::info('Vendor commissions distributed successfully.');
        } catch (\Throwable $e) {
            Log::error('Driver commission distribution failed: '.$e->getMessage(), [
                'exception' => $e,
            ]);
        }
    }
}

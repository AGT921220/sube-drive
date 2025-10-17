<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('add_coupons', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('coupon_title');
            $table->string('coupon_subtitle')->nullable();
            $table->string('coupon_image')->nullable();
            $table->date('coupon_expiry_date')->nullable();
            $table->string('coupon_code');
            $table->decimal('min_order_amount', 15)->nullable();
            $table->decimal('coupon_value', 15);
            $table->string('coupon_type', 20)->nullable();
            $table->longText('coupon_description')->nullable();
            $table->string('status')->nullable();
            $table->boolean('module')->default(false);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('add_coupons');
    }
};

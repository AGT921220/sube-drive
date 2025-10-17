<?php

use App\Http\Controllers\Api\V1\Admin\SliderApiController;
use App\Http\Controllers\Front\PaymentFrontController;
use App\Strategies\PaypalStrategy;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Auth\TokenController;
// paypal
Route::post('/paypal/ipn', [PaymentFrontController::class, 'handlePaypalIPN'])
    ->name('paypal.ipn');
Route::post('/paypal/webhook', [PaypalStrategy::class, 'handleWebhook'])
    ->name('paypal.webhook');

Route::post('/generateToken', [TokenController::class, 'issueSanctumToken'])
    ->name('token.generate');
// 'auth:sanctum'

Route::group(['prefix' => 'v1', 'as' => 'api.', 'namespace' => 'Api\V1\Admin', 'middleware' => ['auth:sanctum']], function () {
    // Slider
    Route::post('/sliders', [SliderApiController::class, 'sliders']);

    // App Users
    Route::post('/userRegister', 'AppUsersApiController@userRegister');
    Route::post('/otpVerification', 'AppUsersApiController@otpVerification');
    Route::post('/userLogin', 'AppUsersApiController@userLogin');
    Route::post('/userLogout', 'AppUsersApiController@userLogout');
    Route::post('/puthostRequest', 'AppUsersApiController@puthostRequest');
    Route::post('/gethostStatus', 'AppUsersApiController@gethostStatus');
    Route::post('/socialLogin', 'AppUsersApiController@socialLogin');
    Route::post('/userEmailLogin', 'AppUsersApiController@userEmailLogin');
    Route::post('/forgotPassword', 'AppUsersApiController@forgotPassword');
    Route::post('/verifyResetToken', 'AppUsersApiController@verifyResetToken');
    Route::post('/ResendTokenEmailChange', 'AppUsersApiController@ResendTokenEmailChange');
    Route::post('/sendMobileLoginOtp', 'AppUsersApiController@sendMobileLoginOtp');
    Route::post('/userMobileLogin', 'AppUsersApiController@userMobileLogin');

    Route::post('/sendOnlyEmailLoginOtp', 'AppUsersApiController@sendOnlyEmailLoginOtp');
    Route::post('/userOnlyEmailLogin', 'AppUsersApiController@userOnlyEmailLogin');

    Route::post('/resetPassword', 'AppUsersApiController@resetPassword');
    Route::post('/emailcheck', 'AppUsersApiController@emailcheck');
    Route::post('/mobilecheck', 'AppUsersApiController@mobilecheck');
    Route::post('/ResendOtp ', 'AppUsersApiController@ResendOtp');
    Route::post('/ResendToken ', 'AppUsersApiController@ResendToken');
    Route::post('/updatePassword ', 'AppUsersApiController@updatePassword');
    Route::post('/getUserWallet ', 'AppUsersApiController@getUserWallet');
    Route::post('/getUserWalletTransactions ', 'AppUsersApiController@getUserWalletTransactions');

    Route::post('/getVendorWallet ', 'AppUsersApiController@getVendorWallet');
    Route::post('/getVendorWalletTransactions ', 'AppUsersApiController@getVendorWalletTransactions');
    Route::post('/insertPayout ', 'AppUsersApiController@insertPayout');
    Route::post('/getPayoutTransactions ', 'AppUsersApiController@getPayoutTransactions');

    Route::post('/getDriverEarings ', 'DriverFinanceApiController@getDriverEarings');

    Route::post('/deleteAccount ', 'AppUsersApiController@deleteAccount');
    Route::post('/addEditVerificationDocuments', 'AppUsersApiController@addEditVerificationDocuments');
    Route::post('/getVerificationDocuments', 'AppUsersApiController@getVerificationDocuments');

    // UserProfile
    Route::post('/getUserProfile ', 'UserProfileController@getUserProfile');
    Route::post('/getUseritems ', 'UserProfileController@getUseritems');
    Route::post('/getVendorItemReviews ', 'UserProfileController@getVendorItemReviews');

    // Cities
    Route::get('/yourLocations', 'CitiesApiController@yourLocations');
    Route::post('/searchCities', 'CitiesApiController@searchCities');

    // Item Type

    Route::get('/getAllCategories', 'ItemTypeApiController@getAllCategories');
    Route::post('/getItemsByItemType', 'ItemTypeApiController@getItemsByItemType');

    // features
    Route::get('/amenities', 'FeaturesApiController@features');
    // HomeData
    Route::get('/homeData', 'HomeApiController@homeData');

    // Items
    Route::post('/featuredItems', 'HomeApiController@featuredItems');
    Route::post('/mostViewedItems', 'HomeApiController@mostViewedItems');
    Route::post('/nearbyItems', 'HomeApiController@nearbyItems');
    Route::post('/newArrivalItems', 'HomeApiController@newArrivalItems');

    Route::post('/getItemDetails', 'ItemsApiController@getItemDetails');
    Route::post('/insertItem', 'ItemsApiController@insertItem');
    Route::post('/editItem', 'ItemsApiController@editItem');
    Route::post('/myItems', 'ItemsApiController@myItems');
    Route::post('/deletefrontimage', 'ItemsApiController@deletefrontimage');
    Route::post('/deletegalleryimage', 'ItemsApiController@deletegalleryimage');

    Route::post('/getItemsByLocation', 'ItemsApiController@getItemsByLocation');
    Route::post('/itemSearch', 'ItemsApiController@itemSearch');
    Route::post('/deleteItem', 'ItemsApiController@deleteItem');
    Route::post('/getCurrentAndFuturePrices', 'ItemsApiController@getCurrentAndFuturePrices');
    Route::post('/getHomeData', 'ItemsApiController@getHomeData');

    Route::post('/addEditItemImage', 'ItemsApiController@addEditItemImage');
    Route::post('/addEditItemImages', 'ItemsApiController@addEditItemImages');
    Route::post('/addEditItemDocuments', 'ItemsApiController@addEditItemDocuments');
    Route::post('/getItemDocuments', 'ItemsApiController@getItemDocuments');

    // Calender
    Route::get('/getItemDates', 'ItemDateController@getItemDates');
    Route::post('/addEditCalender', 'ItemDateController@addEditCalender');

    // Support Ticket

    Route::post('/createSupportTicket', 'SupportTicketController@createSupportTicket');
    Route::post('/replyToSupportTicket', 'SupportTicketController@replyToSupportTicket');
    Route::post('/getUserThreads', 'SupportTicketController@getUserThreads');
    Route::post('/getReplyThreads', 'SupportTicketController@getReplyThreads');
    Route::post('/closeSupportTicket', 'SupportTicketController@closeSupportTicket');

    // Item Rules
    Route::get('/getItemRules', 'RentalItemRuleApiController@getItemRules');

    // Item Rules
    Route::get('/getMakes', 'MakeApiController@getMakes');
    Route::get('/getMakesModel', 'MakeApiController@getMakesModel');

    // Cancellations rasons
    Route::get('/getCancelReasons', 'CancellationReasonController@getCancelReasons');
    Route::get('/getCancellationPolicies', 'BookingApiController@getCancellationPolicies');

    // Review
    Route::post('/getItemReviews', 'ReviewApiController@getItemReviews');
    Route::post('/giveReviewByUser', 'ReviewApiController@giveReviewByUser');
    Route::post('/giveReviewByHost', 'ReviewApiController@giveReviewByHost');

    // Booking
    Route::post('/checkBookingAvailability', 'BookingApiController@checkBookingAvailability');
    Route::post('/getItemPrices', 'BookingApiController@getItemPrices');
    Route::post('/bookItem', 'BookingApiController@bookItem'); // Need to change
    Route::post('/bookingRecord', 'BookingApiController@bookingRecord');
    Route::post('/itemBookingDate', 'BookingApiController@itemBookingDate'); // Need to change
    Route::post('/bookingpaymentsuccess', 'BookingApiController@bookingpaymentsuccess');
    Route::post('/vendorbookingRecord', 'BookingApiController@vendorBookingRecord');
    Route::post('/cancelBookingByUser', 'BookingApiController@cancelBookingByUser');
    Route::post('/cancelBookingByHost', 'BookingApiController@cancelBookingByHost');
    Route::post('/confirmBookingByHost', 'BookingApiController@confirmBookingByHost');
    Route::post('/updateItemDeliveredStatus', 'BookingApiController@updateItemDeliveredStatus');
    Route::post('/updateItemReceivedStatus', 'BookingApiController@updateItemReceivedStatus');
    Route::post('/updateItemReturnedStatus', 'BookingApiController@updateItemReturnedStatus');
    Route::post('/updateBookingStatusByDriver', 'BookingApiController@updateBookingStatusByDriver');
    Route::post('/updatePaymentStatusByDriver', 'BookingApiController@updatePaymentStatusByDriver');
    Route::post('/updatePaymentStatusByUser', 'BookingApiController@updatePaymentStatusByUser');
    Route::post('/updateBookingStatusByUser', 'BookingApiController@updateBookingStatusByUser');

    Route::post('/getCategories', 'CategoryApiController@getCategories');
    Route::post('/getSubcategories', 'CategoryApiController@getSubcategories');
    Route::post('/getCategoriesData', 'CategoryApiController@getCategoriesData');

    // Testimonial
    Route::post('testimonials/media', 'TestimonialApiController@storeMedia')->name('testimonials.storeMedia');
    Route::apiResource('testimonials', 'TestimonialApiController');

    Route::post('/addToWishlist', 'ItemWishlistController@addToWishlist');
    Route::post('/removeFromWishlist', 'ItemWishlistController@removeFromWishlist');
    Route::post('/getWishlist', 'ItemWishlistController@getWishlist');

    Route::post('/editProfile', 'MyAccountController@editProfile');
    Route::post('/uploadProfileImage', 'MyAccountController@uploadProfileImage');
    Route::post('/checkMobileNumber', 'MyAccountController@checkMobileNumber');
    Route::post('/changeMobileNumber', 'MyAccountController@changeMobileNumber');
    Route::post('/checkEmail', 'MyAccountController@checkEmail');
    Route::post('/changeEmail', 'MyAccountController@changeEmail');
    Route::post('/insertBankAccount', 'MyAccountController@insertBankAccount');
    Route::post('/getBankAccount', 'MyAccountController@getBankAccount');
    Route::post('/getDriverDashboardStats', 'MyAccountController@getDriverDashboardStats');
    Route::post('/toggle-product-status', 'MyAccountController@toggleProductStatus');

    // Static Pages
    Route::post('static-pages/media', 'StaticPagesApiController@storeMedia')->name('static-pages.storeMedia');
    Route::apiResource('static-pages', 'StaticPagesApiController');
    Route::get('StaticPage', 'StaticPagesApiController@StaticPage');

    // All Packages
    Route::post('all-packages/media', 'AllPackagesApiController@storeMedia')->name('all-packages.storeMedia');
    Route::apiResource('all-packages', 'AllPackagesApiController', ['except' => ['destroy']]);

    // General Setting
    Route::get('getgeneralSettings', 'GeneralSettingApiController@getgeneralSettings');


    // Payout
    Route::post('/getTotalPayoutAmount', 'PayoutApiController@getTotalPayoutAmount');

    // contactus
    Route::post('contactUs', 'ContactUsApiController@contactUs');
    Route::post('fcmUpdate', 'AppUsersApiController@fcmUpdate');
    // email sms push notification
    Route::post('emailSmsNotification', 'AppUsersApiController@emailSmsNotification');
    // vechile odometer api
    Route::get('vechileOdometer', 'VehicleOdometerAPiController@vechileodometer');
    Route::post('odometerModelYear', 'VehicleOdometerAPiController@odometerModelYear');
    Route::get('odometermannual', 'VehicleOdometerAPiController@odometermannual');

    // currency
    Route::post('/getCurrencyDetails', 'CurrencyApiController@index');
    Route::get('/updateRates', 'CurrencyApiController@updateRates'); // set in cron JOB
    // https://domainname.com/api/v1/updateRates

});

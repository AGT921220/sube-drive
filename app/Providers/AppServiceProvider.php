<?php

namespace App\Providers;

use App\Models\GeneralSetting;
use App\Models\Module;
use App\Services\FirestoreService;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(FirestoreService::class, function ($app) {
            return new FirestoreService;
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        app()->singleton('currentModule', function () {
            return Cache::remember('current_module_default', 6000, function () {
                return Module::where('default_module', '1')->first();
            });
        });

        $settings = Cache::rememberForever('general_settings', function () {
            return GeneralSetting::pluck('meta_value', 'meta_key')->toArray();
        });

        foreach ($settings as $key => $value) {
            Config::set("general.$key", $value);
        }

        try {
            /** @var \App\Services\FirestoreService $firestore */
            $firestore = app(FirestoreService::class);

            // Trigger a harmless read to force credentials init
            $firestore->getCollection('drivers');
        } catch (\Throwable $e) {
            \Log::warning('Firestore warmup failed: '.$e->getMessage());
        }
    }
}

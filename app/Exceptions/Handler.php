<?php

namespace App\Exceptions;

use App\Http\Controllers\Traits\ResponseTrait;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Throwable;

class Handler extends ExceptionHandler
{
    use ResponseTrait;

    protected $levels = [];

    protected $dontReport = [];

    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            // Registrar todas las excepciones con información detallada
            Log::error('Exception occurred: ' . get_class($e), [
                'message' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString(),
                'url' => request()->fullUrl(),
                'method' => request()->method(),
                'ip' => request()->ip(),
                'user_agent' => request()->userAgent(),
                'input' => request()->except(['password', 'password_confirmation', 'current_password']),
            ]);
        });
    }

    public function render($request, Throwable $exception)
    {
        // Registrar errores 500 específicamente
        if ($exception instanceof HttpException && $exception->getStatusCode() >= 500) {
            Log::error('HTTP 500 Error', [
                'message' => $exception->getMessage(),
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
                'url' => $request->fullUrl(),
                'method' => $request->method(),
                'ip' => $request->ip(),
            ]);
        }

        return parent::render($request, $exception);
    }

    public function unauthenticated($request, AuthenticationException $exception)
    {
        if ($request->expectsJson() || $request->is('api/*')) {
            return $this->addSuccessResponse(498, trans('front.Unauthenticated_or_token_expired.'), []);
        }

        return redirect()->guest(route('login'));
    }
}

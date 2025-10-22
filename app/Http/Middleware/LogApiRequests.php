<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class LogApiRequests
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Registrar la petición entrante
        Log::channel('api')->info('API Request', [
            'method' => $request->method(),
            'url' => $request->fullUrl(),
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
            'input' => $request->except(['password', 'password_confirmation', 'current_password']),
        ]);

        $response = $next($request);

        // Registrar la respuesta
        $statusCode = $response->getStatusCode();
        $logLevel = $statusCode >= 500 ? 'error' : ($statusCode >= 400 ? 'warning' : 'info');

        Log::channel('api')->{$logLevel}('API Response', [
            'method' => $request->method(),
            'url' => $request->fullUrl(),
            'status_code' => $statusCode,
            'duration' => microtime(true) - LARAVEL_START,
        ]);

        // Si hay un error 500, registrar detalles adicionales
        if ($statusCode >= 500) {
            Log::error('Error 500 detectado en API', [
                'method' => $request->method(),
                'url' => $request->fullUrl(),
                'status_code' => $statusCode,
                'ip' => $request->ip(),
                'input' => $request->except(['password', 'password_confirmation', 'current_password']),
                'response' => $response->getContent(),
            ]);
        }

        return $response;
    }
}


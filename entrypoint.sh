#!/bin/bash

# Cambiar al directorio de la aplicación
cd /var/www/html

# Esperar a que MySQL esté disponible (timeout de 30 segundos)
echo "Esperando a que MySQL esté listo..."
COUNTER=0
MAX_TRIES=30
until mysql -h"${DB_HOST:-mysql-sube}" -u"${DB_USERNAME:-user}" -p"${DB_PASSWORD:-password}" --skip-ssl -e "SELECT 1" > /dev/null 2>&1 || [ $COUNTER -eq $MAX_TRIES ]; do
    echo "Esperando MySQL... intento $COUNTER/$MAX_TRIES"
    sleep 1
    COUNTER=$((COUNTER + 1))
done

if [ $COUNTER -eq $MAX_TRIES ]; then
    echo "Warning: No se pudo conectar a MySQL después de $MAX_TRIES intentos. Continuando de todas formas..."
else
    echo "MySQL está listo!"
fi

# Establecer permisos correctos
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache 2>/dev/null || true

# Limpiar cachés (solo si artisan está disponible y la base de datos conecta)
if [ $COUNTER -lt $MAX_TRIES ]; then
    echo "Limpiando cachés..."
    php artisan config:clear 2>/dev/null || true
    php artisan cache:clear 2>/dev/null || true
    php artisan route:clear 2>/dev/null || true
    php artisan view:clear 2>/dev/null || true
fi

# Iniciar PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm


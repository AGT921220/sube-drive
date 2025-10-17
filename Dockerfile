FROM php:8.0-fpm

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    supervisor \
    libzip-dev \
    zip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mbstring exif pcntl bcmath soap \
    && pecl install redis && docker-php-ext-enable redis

# Instalar Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copiar Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Establecer permisos para las carpetas de Laravel
RUN mkdir -p /var/www/html/bootstrap/cache && \
    chown -R www-data:www-data /var/www/html/bootstrap/cache && \
    chmod -R 775 /var/www/html/bootstrap/cache

# Copiar archivos de configuración de Supervisor
COPY horizon.conf /etc/supervisor/conf.d/horizon.conf

# Copiar el script de entrada y otros archivos de configuración necesarios
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./docker/php/php.ini /usr/local/etc/php/

# Hacer ejecutable el script de entrada
#RUN chmod +x /usr/local/bin/entrypoint.sh

# Define el comando para ejecutar el script de entrada
#ENTRYPOINT ["entrypoint.sh"]


RUN chmod +x /usr/local/bin/entrypoint.sh

# Definir el comando para ejecutar el script de entrada
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
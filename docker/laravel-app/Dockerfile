FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

COPY ./docker/laravel-app/conf.d /usr/local/etc/php/conf.d
COPY ./src/laravel-app /var/www

RUN composer install

# Опционально: выполняем миграции и сиды Laravel
# RUN php artisan migrate
# RUN php artisan db:seed

# Опционально: настраиваем права доступа к файлам и директориям, если это необходимо
# RUN chown -R www-data:www-data /var/www/html/storage
# RUN chmod -R 775 /var/www/html/storage

# Опционально: настраиваем конфигурацию PHP, если это необходимо
# COPY php.ini /usr/local/etc/php/conf.d/custom.ini

EXPOSE 9000

CMD ["php-fpm"]
FROM nginx:latest

COPY ./docker/nginx/configs/conf.d /etc/nginx/conf.d

COPY ./src/laravel-app /var/www

WORKDIR /var/www
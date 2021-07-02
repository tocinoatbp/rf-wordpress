FROM composer:latest as vendor

COPY wordpress .

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

FROM wordpress:5.7.1-fpm-alpine

COPY . /var/www/html
COPY --from=vendor /app/ /var/www/html/
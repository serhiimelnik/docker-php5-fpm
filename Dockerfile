FROM php:5.6-fpm

COPY php.ini /usr/local/etc/php/php.ini

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        php5-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install mongo \
    && docker-php-ext-enable mongo \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

COPY xdebug.ini /usr/local/etc/php/xdebug.ini

WORKDIR /var/www

CMD ["php-fpm"]

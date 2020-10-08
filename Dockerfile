FROM php:7.4-alpine
WORKDIR /Tripresso
COPY . /Tripresso
RUN docker-php-source extract && \
    docker-php-source delete && \
    docker-php-ext-install mysqli pdo_mysql && \
    apk add git openssh && \
    apk add curl

RUN curl -s http://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN composer install && \
    composer update && \
    cp .env.example .env
ENTRYPOINT ["php","artisan","serve","--host=0.0.0.0","--port=8000"]

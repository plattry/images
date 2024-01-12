FROM php:8.3-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --no-cache linux-headers $PHPIZE_DEPS \
    && docker-php-ext-install sockets \
    && pecl install ev \
    && docker-php-ext-enable ev \
    && apk del $PHPIZE_DEPS \
    && rm -rf /var/cache/apk/* /tmp/pear/*

RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /home/www-data

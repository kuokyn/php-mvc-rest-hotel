FROM php:7.2-apache
RUN apt-get update -y && apt-get install -y apache2-utils libaprutil1-dbd-mysql
RUN a2enmod authn_dbd
RUN docker-php-ext-install mysqli
WORKDIR /var/www/html


FROM php:7-apache

# Activation des modules php
RUN docker-php-ext-install pdo pdo_mysql

COPY . /var/www/html/

WORKDIR  /var/www/html

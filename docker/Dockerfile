FROM php:8.2-apache

# Instalar extensiones necesarias para MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo_mysql

# Opcional: activar mod_rewrite en Apache
RUN a2enmod rewrite


# en consola:
# cd C:\usuario\documentos\phpProject\docker
# docker-compose down
# docker-compose build --no-cache
# docker-compose up -d

# Tu app PHP → http://localhost:8080
# phpMyAdmin → http://localhost:8081

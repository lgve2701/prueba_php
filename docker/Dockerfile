FROM php:8.2-apache

# Instalar extensiones necesarias para MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli pdo_mysql

# Opcional: activar mod_rewrite en Apache
RUN a2enmod rewrite

# Cambiar DocumentRoot a /app
ENV APACHE_DOCUMENT_ROOT=/app

# Reemplazar configuración por defecto de Apache
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/default-ssl.conf

# en consola:
# cd C:\usuario\documentos\phpProject\docker
# docker-compose down
# docker-compose build --no-cache
# docker-compose up -d

# Tu app PHP → http://localhost:8080
# phpMyAdmin → http://localhost:8081

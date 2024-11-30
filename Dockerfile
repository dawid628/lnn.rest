FROM php:8.3-fpm

# Instalacja wymaganych pakietów i rozszerzeń PHP
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instalacja Composera
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Ustawienie katalogu roboczego
WORKDIR /var/www/html

# Kopiowanie plików projektu
COPY . .

# Ustawienia dostępu do plików
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html

# Domyślne polecenie startowe
CMD ["php-fpm"]

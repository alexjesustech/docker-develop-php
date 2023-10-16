# Imagem PHP oficial com Apache como imagem base.
# https://github.com/docker-library/php/tree/7f89b1440e0122cc0edaf4ee0dbd8e1d7510df73/8.2/bookworm/apache
FROM php:8.2.11-apache-bookworm

# Argumentos definidos em docker-compose.yml
ARG user
ARG uid

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer
RUN mkdir -p /home/$user/project/public
RUN chown -R $user:$user /home/$user

# Defini diretório de trabalho
WORKDIR /home/$user/project

ENV APACHE_DOCUMENT_ROOT /home/$user/project/public
RUN sed -i -e 's/Listen 80/Listen 80\nServerName localhost/' /etc/apache2/ports.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite headers

# Atualiza a lista de pacotes
RUN apt-get update

# Instala as dependências do sistema
RUN apt-get install -y --no-install-recommends \
	git \
	curl \
	libpng-dev \
	libonig-dev \
	libxml2-dev \
	libicu-dev \
	zip \
	cron \
	unzip \
	redis-tools

# Limpa o cache
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# Instala as extensões do PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd intl

# Instala o compose
COPY --from=composer:2.6.5 /usr/bin/composer /usr/bin/composer

RUN pecl install redis-5.3.7
RUN docker-php-ext-enable redis

RUN pecl install xdebug-3.2.2
RUN docker-php-ext-enable xdebug

COPY etc/php/local.ini /usr/local/etc/php/conf.d/local.ini
#COPY etc/apache/vhost.conf /etc/apache/sites-available/000-default.conf

#RUN chown -R www-data:www-data /var/www

USER $user

EXPOSE 80
CMD ["apache2-foreground"]

FROM php:5.6-apache
#
# Esta imagem herda de php:5.6-apache que já possui WebServer Apache
# com PHP sobre a versão 8 do Debian de codinome Jessie.
# Aqui habilito o módulo mod_rewrite que permite usar as regras
# RewriteRule do Apache. Além disso instalo o Drupal 8 e o
# Drupal Console
#
MAINTAINER João Antonio Ferreira "joao.parana@gmail.com"

ENV REFRESHED_AT 2015-11-20

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
COPY opcache-segment.ini /opcache-segment.ini
RUN cat /opcache-segment.ini >> /usr/local/etc/php/conf.d/opcache-recommended.ini

WORKDIR /var/www/html

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 8.0.0
ENV DRUPAL_MD5 92ce9a54fa926b58032a4e39b0f9a9f1

RUN curl -fSL "http://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
	&& echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
	&& tar -xz --strip-components=1 -f drupal.tar.gz \
	&& rm drupal.tar.gz \
	&& chown -R www-data:www-data sites

# # install Composer globally
# RUN curl -sS https://getcomposer.org/installer | php \
#   && mv composer.phar /usr/local/bin/composer
#
# # install Drush 8.x
# RUN composer global require drush/drush:dev-master \
#   && echo "export PATH=\"$HOME/.composer/vendor/bin:$PATH\"" > ~/.bashrc

# Install Drupal Console for future use
# Doc on https://hechoendrupal.gitbooks.io/drupal-console/content/en/index.html
RUN curl -LSs http://drupalconsole.com/installer | php \
  && mv console.phar /usr/local/bin/drupal

RUN cd profiles && \
    curl -O  http://ftp.drupal.org/files/projects/panopoly-8.x-2.0-alpha1-no-core.tar.gz && \
    tar -xzf panopoly-8.x-2.0-alpha1-no-core.tar.gz && \
    rm panopoly-8.x-2.0-alpha1-no-core.tar.gz && \
    cd ..

RUN mkdir -p /var/log/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /var/log/php

ENV PHP_MEMORY_LIMIT 129M
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY test-mail.php /var/www/html/test-mail.php

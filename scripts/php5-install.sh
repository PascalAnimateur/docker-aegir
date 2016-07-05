#!/bin/sh

# Install PHP5 packages
apt-get install -y \
  php-apc \
  php-codesniffer \
  php-pear \
  php5 \
  php5-cli \
  php5-curl \
  php5-dev \
  php5-gd \
  php5-mcrypt \
  php5-mysql \
  php5-xdebug

# Configure PHP options for Apache2 and CLI
declare -A PHP_OPTIONS
PHP_OPTIONS[memory_limit]="384M"
PHP_OPTIONS[upload_max_filesize]="2048M"
PHP_OPTIONS[post_max_size]="2048M"
PHP_OPTIONS[max_execution_time]="300"
for option in "${!PHP_OPTIONS[@]}" ; do
  sed -i "s@$option.*=.*@$option=${PHP_OPTIONS[$option]}@g" /etc/php5/apache2/php.ini
  sed -i "s@$option.*=.*@$option=${PHP_OPTIONS[$option]}@g" /etc/php5/cli/php.ini
done

# Configure XDebug
echo "xdebug.remote_enable = 1" | tee -a /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_output_dir = /tmp/xdebug"  | tee -a /etc/php5/apache2/conf.d/20-xdebug.ini
echo "xdebug.profiler_enable_trigger = 1" | tee -a /etc/php5/apache2/conf.d/20-xdebug.ini
mkdir -p /tmp/xdebug
chmod 777 /tmp/xdebug

# Install uploadprogress
pecl install uploadprogress
echo "extension=uploadprogress.so" | tee /etc/php5/mods-available/uploadprogress.ini

# Enable PHP modules
php5enmod curl mcrypt uploadprogress

# Install Composer globally
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/bin/composer

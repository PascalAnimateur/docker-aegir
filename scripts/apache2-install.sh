#!/bin/sh

# Install Apache2 package
apt-get install -y apache2

# Configure Apache2 ServerName
echo "ServerName `hostname`" | tee -a /etc/apache2/conf-available/fqdn.conf
a2enconf fqdn

# Enable Apache2 modules
a2enmod actions rewrite headers

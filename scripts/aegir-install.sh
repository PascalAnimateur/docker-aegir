#!/bin/sh

# Create Aegir system user
adduser --system --group --home /var/aegir aegir
adduser aegir www-data
echo 'Defaults:aegir !requiretty' |  tee -a /etc/sudoers.d/aegir
echo 'aegir ALL=NOPASSWD: /usr/sbin/apache2ctl' | tee -a /etc/sudoers.d/aegir
chmod 0440 /etc/sudoers.d/aegir

# Create Aegir MySQL user
mysql -h $MYSQL_HOST -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e \
  "GRANT ALL PRIVILEGES ON *.* TO '$AEGIR_MYSQL_USER'@'%' IDENTIFIED BY '$AEGIR_MYSQL_PASSWORD' WITH GRANT OPTION;"

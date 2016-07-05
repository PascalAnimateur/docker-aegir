#!/bin/sh

# Install MySQL only if using localhost
if [ "$MYSQL_HOST" == 'localhost' ] ; then
  # Preconfigure MySQL root password
  MYSQL_ROOT_USER = 'root'
  echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

  # Install MySQL server package
  apt-get install -y mysql-server
fi

# Check MySQL configuration
mysql -h $MYSQL_HOST -u $MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "quit"
if [ ! $? == "0" ] ; then
  echo "Invalid MySQL configuration. Please verify MYSQL_* environment variables."
  exit 0
fi

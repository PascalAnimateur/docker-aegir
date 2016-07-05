FROM ubuntu:trusty

# Environment variables
ENV DEBIAN_FRONTEND noninteractive \
  MYSQL_HOST localhost \
  MYSQL_ROOT_USER root \
  MYSQL_ROOT_PASSWORD changeme \
  AEGIR_MYSQL_USER aegir_root \
  AEGIR_MYSQL_PASSWORD changeme

# Update packages list and install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  mysql-client \
  rsync \
  unzip

# Copy install scripts
RUN mkdir /root/scripts
ADD scripts/*.sh /root/scripts/

# Apache2
RUN bash /root/scripts/apache2-install.sh

# PHP5
RUN bash /root/scripts/php5-install.sh

# MySQL
RUN bash /root/scripts/mysql-install.sh

# Aegir
RUN bash /root/scripts/aegir-install.sh

EXPOSE 80
EXPOSE 3306

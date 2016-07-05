FROM ubuntu:trusty

# Environment variables
ENV DEBIAN_FRONTEND noninteractive

# Update packages list and install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  rsync \
  unzip

# Copy install scripts
RUN mkdir /root/scripts
ADD scripts/*.sh /root/scripts/

# Apache2
RUN bash /root/scripts/apache2-install.sh

# PHP5
RUN bash /root/scripts/php5-install.sh

EXPOSE 80

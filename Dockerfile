FROM ubuntu:16.04
MAINTAINER Hyphen IO <services@hyphenio.com.au>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu xenial main universe" > /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install \
  php7.0 \
  php7.0-fpm \
  php7.0-tidy \
  php7.0-xml \
  php7.0-bcmath \
  php7.0-gd \
  php7.0-mbstring \
  php7.0-curl \
  php7.0-mysql \
  php7.0-zip \
  php7.0-mcrypt \
  php-imagick
RUN apt-get -y clean
RUN apt-get -y autoclean
RUN apt-get -y autoremove

WORKDIR /opt/app
RUN echo "#!/bin/bash" > /usr/local/bin/entry.sh
RUN echo "/usr/sbin/php-fpm7.0 --nodaemonize -y /opt/app/server/fpm/php-fpm.conf -c /opt/app/server/php" >> /usr/local/bin/entry.sh
RUN chmod 777 /usr/local/bin/entry.sh

EXPOSE 9000
CMD ["/usr/local/bin/entry.sh"]

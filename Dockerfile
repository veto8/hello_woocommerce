FROM debian:latest
LABEL version="0.1"
MAINTAINER veto<veto@myridia.com>
RUN apt-get update && apt-get install -y \
  nginx \
  apt-transport-https \ 
  lsb-release \
  ca-certificates \
  curl \
  wget \	      
  apt-utils \
  openssh-server \
  supervisor \
  default-mysql-client \
  libpcre3-dev \
  gcc \
  make \
  emacs-nox \ 
  vim \ 
  git \
  gnupg \
  sqlite3 \
  unzip \
  p7zip-full \
  postgresql-client \
  inetutils-ping  \
  net-tools \
  nginx \
  mariadb-server \
  mariadb-client \
  php 






RUN ln  -s /usr/bin/composer.phar /usr/bin/composer 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp


WORKDIR /var/www/html/
EXPOSE 22 80
CMD ["/usr/bin/bash"]



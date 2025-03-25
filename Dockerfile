FROM debian:latest
LABEL version="0.1"
MAINTAINER veto<veto@myridia.com>

RUN apt-get update && apt-get install -y \
  apache2 \
  apt-transport-https \ 
  lsb-release \
  ca-certificates \
  curl \
  wget \	      
  apt-utils \
  openssh-server \
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
  inetutils-ping  \
  net-tools \
  mariadb-server \
  mariadb-client 



RUN apt-key adv  --keyserver hkp://keyserver.ubuntu.com:80 --recv-key B188E2B695BD4743
RUN mv /etc/apt/trusted.gpg  /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update && apt-get install -y \
  php8.4 \
  php8.4-xml \
  php8.4-cgi  \
  php8.4-mysql  \
  php8.4-mbstring \
  php8.4-gd \
  php8.4-curl \
  php8.4-zip \
  php8.4-dev \
  php8.4-sqlite3 \
  php8.4-ldap \
  php8.4-sybase \
  php8.4-pgsql \
  php8.4-soap \
  libapache2-mod-php8.4 \
  php-pear 
    

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
RUN php /tmp/composer-setup.php --install-dir=/usr/bin --filename=composer

# Install Wordpress Cli 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp


RUN echo "<?php phpinfo() ?>" > /var/www/html/info.php ; \
rm /var/www/html/index.html ; \
mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd ; \
a2enmod rewrite  ; \
sed -i -e '/memory_limit =/ s/= .*/= 2056M/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/post_max_size =/ s/= .*/= 800M/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/max_file_uploads =/ s/= .*/= 200/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/upload_max_filesize =/ s/= .*/= 800M/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/display_errors =/ s/= .*/= ON/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/8.4/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/8.4/cli/php.ini ; \
sed -i -e '/AllowOverride / s/ .*/ All/' /etc/apache2/apache2.conf ; \
sed -i -e '/max_execution_time =/ s/= .*/= 1200/' /etc/php/8.4/apache2/php.ini ; \
echo 'open_basedir = "/"' >> /etc/php/8.4/apache2/php.ini ; 



RUN DEBIAN_FRONTEND=noninteractive apt-get -y install phpmyadmin

RUN cp /etc/dbconfig-common/phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf 



WORKDIR /var/www/html/

EXPOSE 22 80 3306
COPY entrypoint.sh /entrypoint.sh
COPY phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf
RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
#ENTRYPOINT /bin/bash



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
mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor ; \
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

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

WORKDIR /var/www/html/
RUN wp core download --force --skip-content  --allow-root




#RUN 
#RUN wp plugin install bw-coupon --activate --allow-root
#RUN wp plugin install wordpress-importer --activate --allow-root
#RUN wp theme install starter-shop --activate --allow-root 
#RUN wp wc payment_gateway update cheque --enabled=true --user=1 --allow-root



EXPOSE 22 80 3306 

#wp core install --url=https://example.com --title="Site Title" --admin_user=admin --admin_password=strongpassword --admin_email=admin@example.com --allow-root && \
ENTRYPOINT service mariadb start && service apache2 start && \
wp core config --dbname=database_name --dbuser=root --dbpass=password --dbhost=localhost  --allow-root && \
wp db create --allow-root && \
wp core install --url=https://example.com --title="Site Title" --admin_user=admin --admin_password=strongpassword --admin_email=admin@example.com --allow-root && \
wp plugin install woocommerce --activate --allow-root && /bin/bash



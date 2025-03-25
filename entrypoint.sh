# entrypoint.sh
#!/usr/bin/env bash

set -e

function main() {
    echo "Hello Wordpress Woocommerce"
    service mariadb start && service apache2 start
    mysql -e "CREATE DATABASE hello_woocommerce /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER hello_woocommerce@localhost IDENTIFIED BY 'hello_woocommerce';"
    mysql -e "GRANT ALL PRIVILEGES ON hello_woocommerce.* TO 'hello_woocommerce'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    
    if [ ! -f "wp-config.php" ]; then
	echo "...install wordpress"
	wp core download --force --skip-content  --allow-root
	wp core config --dbname=hello_woocommerce --dbuser=hello_woocommerce --dbpass=hello_woocommerce --dbhost=localhost  --allow-root
	wp core install --url=http://127.0.0.1 --title="Hello Woocoomerce" --admin_user=admin --admin_password=strongpassword --admin_email=info@myridia.com --allow-root
	wp plugin install woocommerce --activate --allow-root
	wp plugin install bw-coupon --activate --allow-root
        wp plugin install wordpress-importer --activate --allow-root
        wp theme install starter-shop --activate --allow-root
	wp wc payment_gateway update cheque --enabled=true --user=1 --allow-root
	
    fi
    
    
}

main "$@"

/bin/bash

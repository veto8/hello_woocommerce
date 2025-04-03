# hello_woocommerce

To show a basic Worpdress WooCommerce Setup. Its purpose is to have a quick fully working setup, so we could test our own plugins and settings.
It also helps to show the mechanics of the wordpress plugins



### Run Examples: 

#### Run the plain container and remove the container after close the bash
```
docker run --name hello_woocommerce --rm  -it  -p 80:80 myridia/woocommerce
```

* Access Wordpress with a Browser on https://127.0.0.1
* Access the Database with a Browser on https://127.0.0.1/phpmyadmin/
* DB user:  hello_woocommerce
* DB pass: hello_woocommerce





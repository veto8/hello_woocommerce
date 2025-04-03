# hello_woocommerce

To show a basic Worpdress WooCommerce Setup. Its purpose is to have a quick fully working setup, so we could test our own plugins and settings.
It also helps to show the mechanics of the wordpress plugins



### Run Examples: 

### After each run you can access Wordpress with
* Access Wordpress with a Browser on http://127.0.0.1
* Access the Database with a Browser on http://127.0.0.1/phpmyadmin/
* DB user:  hello_woocommerce
* DB pass: hello_woocommerce


#### Build and run the container and remove the container with all its data after you close the bash
```
docker run --name hello_woocommerce --rm  -it  -p 80:80 myridia/woocommerce
```

#### Build and Run the container and kepp the container with all data after you close the bash
```
docker run --name hello_woocommerce -it  -p 80:80 myridia/woocommerce
```






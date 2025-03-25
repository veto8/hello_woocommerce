#!/bin/bash

#docker run --name hello_woocommerce  -it --rm -p 80:80 -v "$(pwd)":"/var/www/html"   myridia/woocommerce
docker run --name hello_woocommerce  -it  -p 80:80   myridia/woocommerce



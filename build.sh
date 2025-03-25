#!/bin/bash

docker build -t myridia/woocommerce:latest .
docker run --name hello_woocommerce  -it --rm -p 80:80 myridia/woocommerce /bin/bash


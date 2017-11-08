#!/bin/sh
yum install -y httpd
service httpd start
chkconfig httpd on

## Number 1
echo "Hello darkness my old friend" > /var/www/html/index.html

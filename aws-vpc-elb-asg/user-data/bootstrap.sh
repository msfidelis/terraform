#!/bin/sh
yum install -y httpd
service httpd start
chkconfig httpd on

echo "Go Go Power Rangers" > /var/www/html/index.html

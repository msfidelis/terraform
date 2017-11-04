#!/bin/sh
yum install -y httpd
service httpd start
chkconfig httpd on

## Number 1
echo "<img src='https://vignette.wikia.nocookie.net/knd/images/4/4d/Numbuh_1.jpg/revision/latest?cb=20070305114531'>" > /var/www/html/index.html

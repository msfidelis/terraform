#!/bin/sh
yum install -y httpd
service httpd start
chkconfig httpd on

## Number 2
echo "<img src='https://vignette.wikia.nocookie.net/knd/images/2/28/Numbuh_2.jpg/revision/latest?cb=20070306114350'>" > /var/www/html/index.html

#!/bin/bash
yum install -y httpd
echo “hello, I am WebServer” >index.html
nohup busybox httpd -f -p 80 &
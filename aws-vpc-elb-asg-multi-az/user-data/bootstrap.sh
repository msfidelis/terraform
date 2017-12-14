#!/bin/sh

yum update -y
yum install -y git

git clone https://github.com/msfidelis/whoami-api.git
cd whoami-api

pip install -r requeriments.txt

python app.py
#!/bin/sh

yum update -y
yum install -y git

#Node Install
sudo su ec2-user
cd ~
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
chmod +x /.nvm/nvm.sh
bash
. /.nvm/nvm.sh
nvm install 8.0.0

git clone https://github.com/msfidelis/whoami-api.git
cd whoami-api

npm install 
npm start

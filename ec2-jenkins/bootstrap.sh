#!/bin/sh

yum install docker -y
curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

service docker start

mkdir /home/jenkins && chmod 777 /home/jenkins

wget https://raw.githubusercontent.com/msfidelis/CintoDeUtilidadesDocker/master/Jenkins/docker-compose.yml -O /home/jenkins/docker-compose.yml
wget https://raw.githubusercontent.com/msfidelis/CintoDeUtilidadesDocker/master/Jenkins/Dockerfile -O /home/jenkins/Dockerfile

cd /home/jenkins && docker-compose up -d
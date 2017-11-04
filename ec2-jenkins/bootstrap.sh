#!/bin/sh

yum install docker docker-compose -y

mkdir /home/jenkins && chmod 777 /home/jenkins

wget https://raw.githubusercontent.com/msfidelis/CintoDeUtilidadesDocker/master/Jenkins/docker-compose.yml -O /home/jenkins/docker-compose.yml
wget https://raw.githubusercontent.com/msfidelis/CintoDeUtilidadesDocker/master/Jenkins/Dockerfile -O /home/jenkins/Dockerfile

cd /home/jenkins && docker-compose up -d
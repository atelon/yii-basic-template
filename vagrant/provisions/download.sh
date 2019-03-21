#!/bin/sh

curl -LJOsS https://github.com/Atelon/docker-backend-yii/archive/master.zip
yum -y -q install unzip
unzip docker-backend-yii-master.zip
rm -f docker-backend-yii-master.zip
mv docker-backend-yii-master docker-backend-yii

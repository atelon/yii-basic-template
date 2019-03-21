#!/bin/sh

cd docker-backend-yii
systemctl start docker
docker-compose up -d

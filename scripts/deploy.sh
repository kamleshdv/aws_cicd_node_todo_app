#!/bin/bash

docker stop nodejs-app || true

docker rm nodejs-app || true

docker pull 848928399247.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app:latest

docker run -d -p 80:3000 --name nodejs-app 848928399247.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app:latest
#!/bin/bash
export app_v=$1
sudo docker image pull techwithnc/betterhrapp:$app_v
sudo docker container run -d -p 8080:8080 techwithnc/betterhrapp:$app_v
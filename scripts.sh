#!/bin/bash
export app_v=$1
sudo docker image pull techwithnc/betterhrapp:$app_v
sudo docker service update --image techwithnc/betterhrapp:$app_v svc01
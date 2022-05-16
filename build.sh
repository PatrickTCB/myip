#!/bin/sh
echo "Building and pushing container with name $1"
docker build -t $1 .
docker push $1 

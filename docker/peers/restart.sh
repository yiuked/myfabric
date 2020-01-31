#!/bin/bash

docker-compose down
rm -rf ../../production/*
docker-compose up -d

#docker logs -f orderer.36sn.com
docker logs -f peer0.org1.36sn.com

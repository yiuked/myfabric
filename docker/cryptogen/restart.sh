#!/bin/bash

docker-compose down
docker-compose up -d

docker logs -f docker_cryptogen

#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

export FABRIC_CFG_PATH=${APP_PATH}/config
export GOPATH=/home/vagrant/go

# Print a fatal error message and exit
function fatal {
   echo "FATAL: $*"
   exit 1
}

# Print a debug message
function debug {
   echo "    $*"
}
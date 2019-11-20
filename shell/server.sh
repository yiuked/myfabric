#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

set -x
export FABRIC_LOGGING_SPEC=DEBUG
export FABRIC_LOGGING_SPEC=info
export FABRIC_CFG_PATH=/home/vagrant/fabric/config
set +x

function Stop(){
    echo "===================== Killing orderer and peer ... ===================== "
    set -x
    ps aux|grep 'bin/peer'|awk '{print $2}'|xargs kill -9
    ps aux|grep 'bin/orderer'|awk '{print $2}'|xargs kill -9
    set +x
    echo "===================== Killed orderer and peer ===================== "
}

function Start(){
    set -x
    ${APP_PATH}/bin/orderer start >>${APP_PATH}/logs/orderer.log 2>&1 &
    ${APP_PATH}/bin/peer node start >>${APP_PATH}/logs/peer.log 2>&1 &
    set +x
    echo
}



if [ "$1" == "start" ]; then
    Start
elif [ "$1" == 'restart' ]; then
    Stop
    Start
elif [ "$1" == 'stop' ]; then
    Stop
fi


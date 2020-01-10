#!/bin/bash

source ./base.sh

export FABRIC_LOGGING_SPEC=DEBUG

function printHelp() {
  echo "Usage: "
  echo "  server.sh <mode>"
  echo "    <mode> - one of 'start', 'restart', 'stop', 'help'"
  echo "      - 'start' - start orderer and peer"
  echo "      - 'restart' - restart orderer and peer"
  echo "      - 'stop' - stop orderer and peer"
  echo "      - 'help' - show help"
  echo
}


function Stop(){
    StopPid ${APP_PATH}/logs/orderer.pid
    StopPid ${APP_PATH}/logs/peer.pid
}


function StopPid {
  if [ ! -f $1 ]; then
     debug "\"$1\" is not a file"
     return
  fi
  pid=`cat $1`
  dir=$(dirname $1)
  file=$(filename $1)
  debug "Stopping node($file) in $dir with PID $pid ..."
  if ps -p $pid > /dev/null
  then
     kill -9 $pid
     wait $pid 2>/dev/null
     rm -f $1
     debug "Stopped node in $dir with PID $pid"
  fi
}

function Start(){
    debug "Start orderer ..."
    ${APP_PATH}/bin/orderer start > ${APP_PATH}/logs/orderer.log 2>&1&
    echo $! > ${APP_PATH}/logs/orderer.pid
    if [ $! -gt 0 ];then
        debug "Start success"
    fi
    
    debug "Start peer ..."
    ${APP_PATH}/bin/peer node start > ${APP_PATH}/logs/peer.log 2>&1&
    echo $! > ${APP_PATH}/logs/peer.pid
        if [ $! -gt 0 ];then
        debug "Start success"
    fi
    echo
}

if [ "$1" == "start" ]; then
    Start
elif [ "$1" == 'restart' ]; then
    Stop
    Start
elif [ "$1" == 'stop' ]; then
    Stop
else
    printHelp
fi


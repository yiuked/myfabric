#!/bin/bash

APP_PATH=/home/vagrant/fabric

export FABRIC_LOGGING_SPEC=debug
export FABRIC_CFG_PATH=/home/vagrant/fabric/config

${APP_PATH}/bin/orderer start & >>${APP_PATH}/logs/orderer.log
${APP_PATH}/bin/peer node start & >>${APP_PATH}/logs/peer.log


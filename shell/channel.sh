#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

export CORE_PEER_MSPCONFIGPATH=/home/vagrant/fabric/crypto-config/peerOrganizations/org1.36sn.com/users/Admin@org1.36sn.com/msp
export FABRIC_CFG_PATH=/home/vagrant/fabric/config

${APP_PATH}/bin/peer channel create -o orderer.36sn.com:7050 -c ${CHANNEL_NAME} -f ${APP_PATH}/channel-artifacts/channel.tx --outputBlock=${APP_PATH}/channel-artifacts/${CHANNEL_NAME}.block
${APP_PATH}/bin/peer channel join -b ${APP_PATH}/channel-artifacts/${CHANNEL_NAME}.block
${APP_PATH}/bin/peer channel update -o orderer.36sn.com:7050 -c ${CHANNEL_NAME} -f ${APP_PATH}/channel-artifacts/anchors.tx


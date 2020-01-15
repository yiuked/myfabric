#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/opt/fabric

export FABRIC_CFG_PATH=${APP_PATH}/config

# Print a fatal error message and exit
function fatal {
   echo "FATAL: $*"
   exit 1
}

# Print a debug message
function debug {
   echo "    $*"
}

SYS_CHANNEL=first-channel

rm -rf ${APP_PATH}/crypto-config/*
rm -rf ${APP_PATH}/channel-artifacts/*

echo "===================== rm temp file ===================== "
set -x
${APP_PATH}/bin/cryptogen generate --config=${APP_PATH}/config/crypto-config.yaml --output=${APP_PATH}/crypto-config
res=$?
set +x
if [ $res -ne 0 ]; then
    fatal "Failed to generate certificates..."
fi
set -x
${APP_PATH}/bin/configtxgen -channelID ${SYS_CHANNEL} -profile OneOrgsOrdererGenesis -outputBlock ${APP_PATH}/channel-artifacts/mygenesis.block
res=$?
set +x
if [ $res -ne 0 ]; then
    fatal "Failed to generate mygenesis.block..."
fi
set -x
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputCreateChannelTx ${APP_PATH}/channel-artifacts/channel.tx -channelID ${CHANNEL_NAME}
res=$?
set +x
if [ $res -ne 0 ]; then
    fatal "Failed to generate channel.tx..."
fi
set -x
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputAnchorPeersUpdate ${APP_PATH}/channel-artifacts/anchors.tx -channelID ${CHANNEL_NAME} -asOrg Org1MSP
res=$?
set +x
if [ $res -ne 0 ]; then
    fatal "Failed to generate anchors.tx..."
fi

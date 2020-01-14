#!/bin/bash

source ./base.sh

SYS_CHANNEL=first-channel
ps aux|grep 'bin/peer'|awk '{print $2}'|xargs kill -9 2> /dev/null
ps aux|grep 'bin/orderer'|awk '{print $2}'|xargs kill -9 2> /dev/null

echo "===================== Kill orderer and peer ===================== "

rm -rf ${APP_PATH}/crypto-config/*
rm -rf ${APP_PATH}/channel-artifacts/*
rm -rf /var/hyperledger/production/*
rm -rf ${APP_PATH}/production/*

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

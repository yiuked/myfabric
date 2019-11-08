#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

ps aux|grep 'bin/peer'|awk '{print $2}'|xargs kill -9
ps aux|grep 'bin/orderer'|awk '{print $2}'|xargs kill -9

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
    echo "Failed to generate certificates..."
    exit 1
fi
set -x
${APP_PATH}/bin/configtxgen -channelID ${CHANNEL_NAME} -profile OneOrgsOrdererGenesis -outputBlock ${APP_PATH}/channel-artifacts/mygenesis.block
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to generate mygenesis.block..."
    exit 1
fi
set -x
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputCreateChannelTx ${APP_PATH}/channel-artifacts/channel.tx -channelID ${CHANNEL_NAME}
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to generate channel.tx..."
    exit 1
fi
set -x
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputAnchorPeersUpdate ${APP_PATH}/channel-artifacts/anchors.tx -channelID ${CHANNEL_NAME} -asOrg Org1MSP
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to generate anchors.tx..."
    exit 1
fi

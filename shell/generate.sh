#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

ps aux|grep 'bin/peer'|awk '{print $2}'|xargs kill -9
ps aux|grep 'bin/orderer'|awk '{print $2}'|xargs kill -9

echo "===================== Kill orderer and peer ===================== "

rm -rf ${APP_PATH}/crypto-config/*
rm -rf ${APP_PATH}/channel-artifacts/*
rm -rf /var/hyperledger/production/*

echo "===================== rm temp file ===================== "

${APP_PATH}/bin/cryptogen generate --config=${APP_PATH}/config/crypto-config.yaml --output=${APP_PATH}/crypto-config

${APP_PATH}/bin/configtxgen -channelID ${CHANNEL_NAME} -profile OneOrgsOrdererGenesis -outputBlock ${APP_PATH}/channel-artifacts/mygenesis.block
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputCreateChannelTx ${APP_PATH}/channel-artifacts/channel.tx -channelID ${CHANNEL_NAME}
${APP_PATH}/bin/configtxgen -profile OneOrgsChannel -outputAnchorPeersUpdate ${APP_PATH}/channel-artifacts/anchors.tx -channelID ${CHANNEL_NAME} -asOrg Org1MSP


${APP_PATH}/bin/orderer start & >>${APP_PATH}/logs/orderer.log
${APP_PATH}/bin/peer node start & >>${APP_PATH}/logs/peer.log
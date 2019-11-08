#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

export CORE_PEER_MSPCONFIGPATH=/home/vagrant/fabric/crypto-config/peerOrganizations/org1.36sn.com/users/Admin@org1.36sn.com/msp
export FABRIC_CFG_PATH=/home/vagrant/fabric/config
export GOPATH=/home/vagrant/go

${APP_PATH}/bin/peer chaincode install -n example -v 0.0.1 -p github.com/hyperledger/fabric-demo/chaincode/chaincode_example02/go/
${APP_PATH}/bin/peer chaincode instantiate -o orderer.36sn.com:7050 -C zsjr -n example -v 0.0.1 -c '{"Args":["init","a","100","b","200"]}' -P 'OR ('\''Org1MSP.member'\'')'


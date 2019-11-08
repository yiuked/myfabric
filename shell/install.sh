#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

CAFILE=/home/vagrant/fabric/crypto-config/ordererOrganizations/36sn.com/orderers/orderer.36sn.com/msp/tlscacerts/tlsca.36sn.com-cert.pem

export CORE_PEER_MSPCONFIGPATH=/home/vagrant/fabric/crypto-config/peerOrganizations/org1.36sn.com/users/Admin@org1.36sn.com/msp
export FABRIC_CFG_PATH=/home/vagrant/fabric/config
export GOPATH=/home/vagrant/go

${APP_PATH}/bin/peer chaincode install -n example -v 0.0.2 -p github.com/hyperledger/fabric-demo/chaincode/chaincode_example02/go/ --tls --cafile=${CAFILE}
${APP_PATH}/bin/peer chaincode instantiate -o orderer.36sn.com:7050 -C zsjr -n example -v 0.0.2 -c '{"Args":["init","a","100","b","200"]}' -P 'OR ('\''Org1MSP.member'\'')' --tls --cafile=${CAFILE}


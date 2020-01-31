#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/opt/gopath/src/github.com/hyperledger/fabric/peer

CAFILE=${APP_PATH}/crypto/ordererOrganizations/36sn.com/orderers/orderer.36sn.com/msp/tlscacerts/tlsca.36sn.com-cert.pem

set -x
peer chaincode install -n example -v 0.0.1 -p github.com/chaincode/chaincode_example02/go/ --tls --cafile=${CAFILE}
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to install chiancode faile..."
    exit 1
fi

set -x
peer chaincode instantiate -o orderer.36sn.com:7050 -C zsjr -n example -v 0.0.1 -c '{"Args":["init","a","100","b","200"]}' -P 'OR ('\''Org1MSP.member'\'')' --tls --cafile=${CAFILE}
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to instantiate chiancode faile..."
    exit 1
fi

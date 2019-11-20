#!/bin/bash

CHANNEL_NAME="zsjr"
APP_PATH=/home/vagrant/fabric

echo "===================== Start generate org2 ===================== "
set -x
${APP_PATH}/bin/cryptogen generate --config=${APP_PATH}/config/crypto-config-org2.yaml --output=${APP_PATH}/crypto-config
res=$?
set +x
if [ $res -ne 0 ]; then
    echo "Failed to generate certificates..."
    exit 1
fi

#!/bin/bash

SERVICE="blockchain-node"
LOG_FILE="/home/tameeeeeem/scripts/blockchain-node-monitoring/node_monitor.log"

if ! systemctl is-active --quiet $SERVICE; then
  systemctl restart $SERVICE
  echo "$(date) - Restarted $SERVICE" >>  /home/tameeeeeem/scripts/blockchain-node-monitoring/node_monitor.log

fi

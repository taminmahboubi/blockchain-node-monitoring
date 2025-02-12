#!/bin/bash
SERVICE="blockchain-node"
if ! service $SERVICE status > /dev/null 2>&1  $SERVICE; then
	service $SERVICE restart
	echo "$(date) - Restarted $SERVICE" >> /home/tameeeeeem/scripts/blockchain-node-monitoring/node_monitor.log
fi

#!/usr/bin/env bash
# Runs on the Raspberry Pi. Shuts down the Proxmox server over SSH.
# Requires SSH key login from the Pi to the server (see docs/wake-on-lan.md).
set -euo pipefail

source "$(dirname "$0")/config.sh"

if ! ping -c 1 -W 1 "$SERVER_IP" > /dev/null 2>&1; then
    echo "Server is already off."
    exit 0
fi

echo "Shutting down $SERVER_IP..."
ssh -o ConnectTimeout=10 "$SERVER_USER@$SERVER_IP" "shutdown -h now" || true

echo "Shutdown command sent."

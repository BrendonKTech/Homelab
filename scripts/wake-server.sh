#!/usr/bin/env bash
# Runs on the Raspberry Pi. Sends a Wake-on-LAN magic packet to the
# Proxmox server, then waits until it answers pings.
set -euo pipefail

source "$(dirname "$0")/config.sh"

if ping -c 1 -W 1 "$SERVER_IP" > /dev/null 2>&1; then
    echo "Server is already up."
    exit 0
fi

echo "Sending magic packet to $SERVER_MAC..."
wakeonlan -i "$BROADCAST_IP" "$SERVER_MAC"

echo "Waiting up to ${BOOT_TIMEOUT}s for the server to boot..."
for ((i = 0; i < BOOT_TIMEOUT; i += 5)); do
    if ping -c 1 -W 1 "$SERVER_IP" > /dev/null 2>&1; then
        echo "Server is up after ~${i}s."
        exit 0
    fi
    sleep 5
done

echo "Server did not respond within ${BOOT_TIMEOUT}s." >&2
exit 1

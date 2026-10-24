#!/usr/bin/env bash
# Runs on the Raspberry Pi. Reports whether the server is reachable
# and whether SSH and Jellyfin are responding.
set -uo pipefail

source "$(dirname "$0")/config.sh"

if ping -c 1 -W 1 "$SERVER_IP" > /dev/null 2>&1; then
    echo "Ping:     UP"
else
    echo "Ping:     DOWN"
    exit 1
fi

if ssh -o ConnectTimeout=5 -o BatchMode=yes "$SERVER_USER@$SERVER_IP" true 2> /dev/null; then
    echo "SSH:      OK"
else
    echo "SSH:      NOT RESPONDING"
fi

JELLYFIN_IP="${JELLYFIN_IP:-$SERVER_IP}"
if curl -s -o /dev/null -m 5 "http://$JELLYFIN_IP:8096/health"; then
    echo "Jellyfin: OK"
else
    echo "Jellyfin: NOT RESPONDING"
fi

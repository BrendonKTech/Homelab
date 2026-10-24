# Scripts

Power management scripts that run on the Raspberry Pi. They control the Proxmox server over the local network. I reach the Pi remotely through Tailscale, then run these.

| Script | What it does |
|---|---|
| `wake-server.sh` | Sends a Wake-on-LAN magic packet to the server and waits for it to boot |
| `shutdown-server.sh` | Shuts the server down over SSH |
| `server-status.sh` | Checks if the server, SSH, and Jellyfin are responding |

## Setup (on the Pi)

```bash
sudo apt install wakeonlan
cp config.example.sh config.sh   # then fill in real values
chmod +x *.sh
```

SSH key login from the Pi to the server has to be set up first. See [docs/wake-on-lan.md](../docs/wake-on-lan.md).

## Usage

```bash
ssh <user>@<pi-tailscale-name>   # from anywhere, over Tailscale
./wake-server.sh
./server-status.sh
./shutdown-server.sh
```

`server-status.sh` checks Jellyfin at the server's IP by default. If Jellyfin runs in a VM or container with its own IP, run it as `JELLYFIN_IP=<ip> ./server-status.sh` or add `JELLYFIN_IP` to `config.sh`.

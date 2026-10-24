# Wake-on-LAN + SSH Power Management

The server doesn't need to run 24/7. The Raspberry Pi uses very little power and stays on, so it handles turning the server on and off.

## Why the Pi Sends the Packet

A Wake-on-LAN magic packet is a broadcast on the **local network**. It can't be sent over the internet or through Tailscale to a machine that's turned off. So the flow is:

```
Me (anywhere) ──Tailscale──▶ Raspberry Pi ──magic packet (LAN)──▶ Server powers on
Me (anywhere) ──Tailscale──▶ Raspberry Pi ──SSH "shutdown"──────▶ Server powers off
```

## Server Side

1. **BIOS/UEFI:** enabled Wake-on-LAN (sometimes called "Power On by PCI-E" or "Wake on LAN"). Disabled settings like "ErP" / deep sleep, which cut power to the network card. The exact names differ between motherboards.
2. **Network card:** checked that WoL is supported and enabled:
   ```bash
   ethtool <interface> | grep Wake-on
   # "Wake-on: g" means magic packet wake is on
   ```
   If it showed `d` (disabled):
   ```bash
   ethtool -s <interface> wol g
   ```
3. **Make it persistent:** added this under the interface in `/etc/network/interfaces` on Proxmox so it survives reboots:
   ```
   post-up /usr/sbin/ethtool -s <interface> wol g
   ```
4. Wrote down the server's **MAC address** (`ip link`) for the Pi to target.

## Pi Side

1. Installed the WoL tool:
   ```bash
   sudo apt install wakeonlan
   ```
2. Set up SSH key login from the Pi to the server, so shutdown works without typing a password:
   ```bash
   ssh-keygen -t ed25519
   ssh-copy-id <user>@<server-ip>
   ```
3. Added the scripts from [`scripts/`](../scripts/).

## Usage

```bash
./wake-server.sh       # power on
./server-status.sh     # confirm it's up
./shutdown-server.sh   # power off
```

Proxmox shuts down its VMs/containers cleanly before powering off the host.

## What I Learned

- How Wake-on-LAN works at the network level (MAC addresses, broadcast packets)
- Why WoL can't cross the internet, and using an always-on device as a relay
- SSH key authentication
- Writing small Bash scripts to automate admin tasks

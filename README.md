# Homelab

A small home server setup I built to learn Proxmox and Linux networking, and to give my family one place to stream our own music and videos, both at home and away from it.

## How It Started

I had an old computer with a decent amount of storage that wasn't being used. Nobody remembered the login password, so I wiped it and installed **Proxmox VE** on it. My cousin recommended learning Proxmox for IT. I already run a Linux virtual machine regularly to get better at Linux, so moving to a bare-metal hypervisor seemed like a reasonable next step.

After learning the basics of Proxmox, I gave the server a real job: a dedicated media server for our family's MP3s and MP4s.

## Overview

```
                         Internet
                            │
                     ┌──────┴──────┐
                     │   Router    │  DNS → Pi-hole
                     └──────┬──────┘
                            │
                   ┌────────┴────────┐
                   │ TP-Link Switch  │
                   └───┬─────────┬───┘
                       │         │
          ┌────────────┴───┐ ┌───┴──────────────────┐
          │  Raspberry Pi  │ │  Proxmox VE Server   │
          │  - Pi-hole     │ │  - Jellyfin          │
          │  - Tailscale   │ │  - Tailscale         │
          │  - WoL / SSH ──┼─┼─▶ wake / shutdown    │
          └────────────────┘ └──────────────────────┘

   Remote family devices ──(Tailscale)──▶ Jellyfin / Raspberry Pi
```

| Component | Hardware | Role |
|---|---|---|
| Proxmox VE | Old repurposed desktop | Hypervisor that hosts the media server |
| Jellyfin | Runs on the Proxmox server | Streams the family's music and video library |
| Tailscale | Server + Raspberry Pi | Private VPN for remote access, no open ports |
| Pi-hole | Low-end Raspberry Pi | Network-wide DNS ad blocking |
| Wake-on-LAN + SSH | Raspberry Pi → server | Remote power on/off to cut idle power use |

## Media Server: Jellyfin

- Set up **Jellyfin** on the Proxmox server as the family's media server for music (MP3) and video (MP4).
- Jellyfin works like any other streaming app: family members can use the web client or the mobile/TV apps.
- The library is still growing. I'm adding our music a little at a time while I look for a faster way to get it all onto the server (see [Next Steps](#next-steps)).

## Remote Access: Tailscale

- Configured **Tailscale** with access limited to approved users, so family members can stream securely from anywhere.
- Inside the house, Jellyfin works over the local network. Outside the house, it works over Tailscale the same way, just like a normal music app would.
- I never had to open or forward ports on the router, so nothing is exposed to the public internet.

## Network-Wide Ad Blocking: Pi-hole

- Bought a low-end **Raspberry Pi** and connected it to the network through a **TP-Link network switch**.
- Deployed **Pi-hole** on it and set it as the router's DNS server.
- Since every device gets its DNS from the router, ads are blocked network-wide on every household device without installing anything on them.

## Power Management: Wake-on-LAN + SSH

The media server doesn't need to run all day, so the Raspberry Pi handles turning it on and off:

1. The Raspberry Pi stays on all the time (it uses very little power) and can be reached remotely over Tailscale.
2. **To start the server:** the Pi sends a **Wake-on-LAN magic packet** to the server's MAC address.
3. **To stop the server:** the Pi sends a shutdown command to the server over **SSH**.

This means I can power the server on from anywhere when someone wants to use it and shut it down when it's idle, which cuts idle power use.

Example commands (placeholders, not my real values):

```bash
# Wake the server
wakeonlan <SERVER_MAC_ADDRESS>

# Shut the server down
ssh <user>@<server-ip> "sudo shutdown -h now"
```

## What I Learned

- Installing and managing a bare-metal hypervisor (Proxmox VE)
- Hosting and maintaining a self-hosted service (Jellyfin)
- VPN and zero-trust style remote access without port forwarding (Tailscale)
- DNS and how changing the router's DNS server affects the whole network (Pi-hole)
- Basic networking hardware (switches) and device addressing (MAC/IP)
- Remote administration with SSH and Wake-on-LAN

## Next Steps

- [ ] Find a faster, more organized way to get the family's music onto the server
- [ ] Keep growing the media library

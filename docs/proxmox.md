# Proxmox VE

Proxmox VE is the hypervisor installed directly on the old desktop. Everything on the server runs on top of it.

## Hardware

| Part | Spec |
|---|---|
| CPU | Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz |
| RAM | 32GB |
| Storage | 3TB HDD + 256GB SSD |
| Network | Wired Ethernet |

## Install

1. Downloaded the Proxmox VE ISO from the official site.
2. Flashed it to a USB drive (Rufus / balenaEtcher).
3. Booted the old desktop from the USB and wiped the drive. Nobody remembered the old Windows login, so there was nothing to keep.
4. Went through the installer: target disk, timezone, root password, and a static IP for the management interface.
5. After the reboot, opened the web UI from another computer at `https://<server-ip>:8006`.

## Setup

- **Updates:** switched from the enterprise repository (needs a paid subscription) to the no-subscription repository, then ran updates.
- **Storage:** > Local
- **Jellyfin host:** LXC Container

## What I Learned

- The difference between a type 1 hypervisor (Proxmox, runs on bare metal) and a type 2 (VirtualBox/VMware Workstation, runs inside an OS like my Linux VM)
- Managing a server only through a web UI and SSH, with no monitor attached
- VMs vs LXC containers, and when to use each

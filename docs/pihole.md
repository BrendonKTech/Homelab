# Pi-hole

Pi-hole is a DNS server that blocks requests to known ad and tracking domains. Because the router hands it out as the DNS server, it blocks ads on every device in the house, including phones and smart TVs, without installing anything on them.

## Hardware

- Low-end Raspberry Pi (Pi-hole needs very little CPU or RAM)
- Connected by Ethernet through a TP-Link network switch

## Setup

1. Flashed Raspberry Pi OS (Lite) to the SD card.
2. Gave the Pi a static IP (or a DHCP reservation on the router), so its address never changes. If the DNS server's IP changes, the whole network loses DNS.
3. Installed Pi-hole:
   ```bash
   curl -sSL https://install.pi-hole.net | bash
   ```
4. Went with the default settings during install.
5. Logged into the admin dashboard at `http://<pi-ip>/admin`.

## Router Configuration

In the router's DHCP/LAN settings, I set the **DNS server** to the Pi's IP. Every device that joins the network now gets Pi-hole as its DNS automatically.

Pi-hole is currently running on its default blocklist and settings.

## How It Works

```
Device asks "where is ads.example.com?"
        │
        ▼
     Pi-hole ── on blocklist? ── yes ──▶ blocked, ad never loads
        │
        no
        ▼
  Upstream DNS ──▶ real answer sent back to the device
```

## What I Learned

- How DNS resolution works and why every device depends on it
- Why servers need static IPs
- Reading DNS query logs to see what devices on the network are doing

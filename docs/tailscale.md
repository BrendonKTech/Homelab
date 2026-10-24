# Tailscale

Tailscale is a VPN built on WireGuard. It puts my devices on a private network (a "tailnet") so they can reach each other from anywhere, without opening any ports on the router.

## Why Tailscale Instead of Port Forwarding

Port forwarding Jellyfin would expose it to the whole internet. With Tailscale, only devices signed into my tailnet (or users I approve) can reach the server. The router has **no open ports**.

## Setup

On each Linux device (the Jellyfin host and the Raspberry Pi):

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Then approved the device in the Tailscale admin console.

On phones and laptops, I installed the Tailscale app and signed in.

## Approved-User Access

Family members get access by being **invited to the tailnet** from the admin console. Only invited users can join, so nobody outside the family can reach the server.

## Devices on the Tailnet

| Device | Purpose |
|---|---|
| Jellyfin host | Remote streaming |
| Raspberry Pi | Remote access for Wake-on-LAN and shutdown |
| Family phones/laptops | Clients |

## What I Learned

- How a mesh VPN works compared to a traditional VPN server
- Why not exposing ports matters for security
- Managing who can access what on a network

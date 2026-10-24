# Jellyfin

Jellyfin is the family media server. It holds our MP3s (music) and MP4s (videos) and streams them to any device, like a normal music or video app.

## Setup

1. Installed Jellyfin in a Debian LXC container on Proxmox (see [proxmox.md](proxmox.md)) using Jellyfin's official install script:
   ```bash
   curl https://repo.jellyfin.org/install-debuntu.sh | bash
   ```
2. Finished the setup wizard at `http://<jellyfin-ip>:8096`: admin account, language, and media libraries.
3. Created libraries pointing at the bind-mounted media drive (`/media`):
   - **Music:** MP3 files
   - **Videos:** MP4 files
4. Made a separate user account for each family member instead of sharing the admin login.

## How the Family Connects

| Where | How |
|---|---|
| At home | Connected to the server over the local network |
| Away from home | Tailscale app turned on, then streaming from Jellyfin the same way (see [tailscale.md](tailscale.md)) |

So far the family mainly uses it for music. Video streaming hasn't been tested yet.

## Adding Media

The music is our own purchased music. Right now I download it manually and add it a little at a time to the library folders, then run a library scan in Jellyfin.

Keeping files named and tagged consistently (artist / album / track) makes Jellyfin match album art and metadata correctly.

## Next Steps

- [ ] Find a faster way to get the family's music onto the server
- [ ] Clean up tags and folder structure for existing music
- [ ] Test video streaming (MP4s), at home and over Tailscale

# Audiogravity — Releases

Official release binaries and bootstrap installers for Audiogravi<sup>ty</sup>   .

## Install Backend

```bash
curl -fsSL https://github.com/ad5030/audiogravity-releases/releases/latest/download/install-backend.sh | sudo bash
```

### Install a specific version

```bash
curl -fsSL https://github.com/ad5030/audiogravity-releases/releases/latest/download/install-backend.sh | sudo bash -s -- --version 1.2.0
```

## Install Frontend

```bash
curl -fsSL https://github.com/ad5030/audiogravity-releases/releases/latest/download/install-frontend.sh | sudo bash
```

## Uninstall

```bash
sudo /opt/audiogravity/uninstall.sh                       # backend — preserves /etc/audiogravity/
sudo /opt/audiogravity/uninstall.sh --purge               # backend — removes everything
sudo /var/www/audiogravity-frontend/uninstall.sh          # frontend
```

## What the backend installer does

1. Detects your architecture (x86_64 / aarch64)
2. Downloads the release tarball from GitHub Releases
3. Verifies the SHA256 checksum
4. Installs the backend binary to `/opt/audiogravity/`
5. Creates a `systemd` service (`ag-backend-server`)
6. Configures sudoers and polkit rules
7. Generates a random API key and JWT secret
8. Creates a default admin user (`admin` / `admin123`) — change on first login

## What the frontend installer does

1. Downloads the release tarball from GitHub Releases
2. Verifies the SHA256 checksum
3. Deploys static assets to `/var/www/audiogravity-frontend/`
4. Generates a self-signed SSL certificate
5. Auto-detects the API key from the backend `.env`
6. Creates a `systemd` service (`ag-frontend-server`) — Python HTTPS server on port 443

## Supported platforms

| Architecture | Tested on |
|---|---|
| x86_64 | Debian 12, Ubuntu 22.04+ |
| aarch64 | Raspberry Pi OS (64-bit), DietPi |

> Recommended platform: **DietPi** on a Raspberry Pi or x86 SBC.

## Requirements

- Linux (Debian/Ubuntu recommended)
- `curl`, `tar`, `sha256sum`
- Root access (`sudo`)

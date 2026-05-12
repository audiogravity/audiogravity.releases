# Audiogravity Backend — Releases

Official release binaries and bootstrap installer for the [Audiogravity](https://github.com/AD/audiogravity) backend.

## Install

```bash
curl -fsSL https://github.com/ad5030/audiogravity-releases/releases/latest/download/install.sh | sudo bash
```

### Install a specific version

```bash
curl -fsSL https://github.com/ad5030/audiogravity-releases/releases/latest/download/install.sh | sudo bash -s -- --version 1.2.0
```

## Uninstall

```bash
sudo /opt/audiogravity/uninstall.sh           # preserves /etc/audiogravity/ config files
sudo /opt/audiogravity/uninstall.sh --purge   # removes everything
```

## What the installer does

1. Detects your architecture (x86_64 / aarch64)
2. Downloads the release tarball from GitHub Releases
3. Verifies the SHA256 checksum
4. Installs the backend binary to `/opt/audiogravity/`
5. Creates a `systemd` service (`ag-backend-server`)
6. Configures sudoers and polkit rules
7. Generates a random API key and JWT secret
8. Creates a default admin user (`admin` / `admin123`) — change on first login

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

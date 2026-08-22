# Audiogravi<sup>ty</sup> — Releases

Published binaries for **Audiogravi<sup>ty</sup>**, the audiophile streamer interface.

**No source code lives here.** This repository carries the release artifacts and their
checksums, nothing else. It exists so that a box can install and update itself from a
stable address.

| | |
|---|---|
| Website | <https://audiogravity.app> |
| User manual | <https://audiogravity.app/docs/manual/> |
| Changelog | [CHANGELOG.md](https://github.com/audiogravity/audiogravity.site/blob/main/CHANGELOG.md) · [RELEASE_NOTES.md](https://github.com/audiogravity/audiogravity.site/blob/main/RELEASE_NOTES.md) |
| Bug reports & questions | [audiogravity.site/issues](https://github.com/audiogravity/audiogravity.site/issues) |

## Install

One command on your streamer — core and interface together:

```bash
curl -fsSL https://audiogravity.app/install.sh | sudo bash
```

Then open `https://<ip-of-your-streamer>` in any browser on your network. Your 30-day
trial starts by itself. Full walkthrough: [2. Installation](https://audiogravity.app/docs/manual/02-installation).

To install the two parts on different hosts, run each installer on its own host:

```bash
curl -fsSL https://audiogravity.app/install-core.sh | sudo bash   # the engine
curl -fsSL https://audiogravity.app/install-ui.sh   | sudo bash   # the interface
```

## What a release contains

| Asset | What it is |
|---|---|
| `audiogravity-core-<version>-x86_64.tar.gz` | The core — Debian / DietPi on x86-64 |
| `audiogravity-core-<version>-aarch64.tar.gz` | The core — Raspberry Pi and other aarch64 boards |
| `audiogravity-ui-<version>.tar.gz` | The interface — architecture-independent |
| `install-core.sh`, `install-ui.sh` | The installers the one-line command above downloads |
| `SHA256SUMS` | Checksum of every file in the release |

The core is a compiled binary; the interface is a static web build. Both are installed
as systemd-managed services by the installers — no compilation, no dependencies to
resolve by hand.

## Verifying a download

Every release ships `SHA256SUMS`. The `latest` links below always point at the most
recent release:

```bash
BASE=https://github.com/audiogravity/audiogravity.releases/releases/latest/download
curl -fLO $BASE/SHA256SUMS
curl -fLO $BASE/audiogravity-ui-*.tar.gz          # or the core tarball for your arch
sha256sum --check --ignore-missing SHA256SUMS
```

`--ignore-missing` lets you check one file without downloading the whole release.

## Updating

You do not need this repository to update. From the interface: the **Admin** tab shows a
banner when a new release is available — one click and your admin password, and the box
downloads, installs and health-checks it, rolling back automatically if anything fails.
See [8. Updating](https://audiogravity.app/docs/manual/08-updating).

## Licence

The core is proprietary — see the [EULA](https://github.com/audiogravity/audiogravity.site/blob/main/EULA.md).
The interface is open source (MIT): [audiogravity.ui](https://github.com/audiogravity/audiogravity.ui).
Third-party components are listed in [THIRD_PARTY_NOTICES.md](https://github.com/audiogravity/audiogravity.site/blob/main/THIRD_PARTY_NOTICES.md).

Editions and what each one unlocks: [EDITIONS.md](https://github.com/audiogravity/audiogravity.site/blob/main/EDITIONS.md).

## Contributing

Releases are built and published by the project's release tooling; nothing in this
repository is edited by hand, so a pull request opened here cannot be merged. Open an
issue on [audiogravity.site](https://github.com/audiogravity/audiogravity.site/issues)
instead — that is where bug reports, questions and feature requests are tracked.

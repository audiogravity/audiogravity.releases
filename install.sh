#!/bin/bash
# Audiogravity Backend — Bootstrap Installer
#
# Usage:
#   curl -fsSL https://github.com/AD/audiogravity-releases/releases/latest/download/install.sh | sudo bash
#   curl -fsSL https://github.com/AD/audiogravity-releases/releases/latest/download/install.sh | sudo bash -s -- --version 1.2.0

set -e

REPO="AD/audiogravity-releases"
INSTALL_DIR="/tmp/ag-install-$$"

GREEN='\033[0;32m'; RED='\033[0;31m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1" >&2; exit 1; }
info() { echo -e "  ${BLUE}→${NC} $1"; }
warn() { echo -e "  ${YELLOW}!${NC} $1"; }

[ "$EUID" -eq 0 ] || fail "Run as root: curl ... | sudo bash"

# ── Parse arguments ───────────────────────────────────────────────────────────

VERSION=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --version) VERSION="$2"; shift 2 ;;
        *) fail "Unknown argument: $1" ;;
    esac
done

# ── Detect architecture ───────────────────────────────────────────────────────

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)          ARCH_TAG="x86_64"  ;;
    aarch64|arm64)   ARCH_TAG="aarch64" ;;
    *) fail "Unsupported architecture: $ARCH. Only x86_64 and aarch64 are supported." ;;
esac

# ── Check dependencies ────────────────────────────────────────────────────────

for cmd in curl tar sha256sum; do
    command -v "$cmd" >/dev/null 2>&1 || fail "'$cmd' is required but not installed."
done

# ── Resolve version ───────────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Audiogravity Backend Installer      ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

if [ -z "$VERSION" ]; then
    info "Fetching latest release version..."
    VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
        | grep '"tag_name"' | sed 's/.*"tag_name": *"v\?\([^"]*\)".*/\1/')
    [ -n "$VERSION" ] || fail "Could not determine latest version. Check your internet connection."
fi

info "Version  : $VERSION"
info "Arch     : $ARCH_TAG"

TARBALL="audiogravity-backend-${VERSION}-${ARCH_TAG}.tar.gz"
BASE_URL="https://github.com/$REPO/releases/download/v${VERSION}"

# ── Download ──────────────────────────────────────────────────────────────────

mkdir -p "$INSTALL_DIR"
trap 'rm -rf "$INSTALL_DIR"' EXIT

info "Downloading $TARBALL..."
curl -fsSL --progress-bar "$BASE_URL/$TARBALL" -o "$INSTALL_DIR/$TARBALL" \
    || fail "Download failed. Check that version $VERSION exists for $ARCH_TAG."
ok "Download complete"

# ── Verify checksum ───────────────────────────────────────────────────────────

info "Verifying integrity..."
curl -fsSL "$BASE_URL/SHA256SUMS" -o "$INSTALL_DIR/SHA256SUMS" 2>/dev/null || {
    warn "SHA256SUMS not found — skipping checksum verification"
}

if [ -f "$INSTALL_DIR/SHA256SUMS" ]; then
    cd "$INSTALL_DIR"
    grep "$TARBALL" SHA256SUMS | sha256sum --check --status \
        || fail "Checksum verification failed — the file may be corrupted."
    ok "Checksum verified"
    cd - >/dev/null
fi

# ── Extract and install ───────────────────────────────────────────────────────

info "Extracting..."
tar -xzf "$INSTALL_DIR/$TARBALL" -C "$INSTALL_DIR"
ok "Extracted"

PACKAGE_DIR=$(find "$INSTALL_DIR" -maxdepth 1 -type d -name "audiogravity-backend-*" | head -1)
[ -n "$PACKAGE_DIR" ] || fail "Could not find package directory after extraction."

info "Running installer..."
echo ""
bash "$PACKAGE_DIR/install.sh"

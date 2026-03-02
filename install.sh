#!/bin/bash
set -e

REPO="wanming/SillyAgent-Releases"
APP_NAME="SillyAgent"
INSTALL_DIR="/Applications"

info()  { printf "\033[0;34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[0;32m[ok]\033[0m    %s\n" "$1"; }
error() { printf "\033[0;31m[error]\033[0m %s\n" "$1" >&2; exit 1; }

cleanup() {
  if [ -n "$MOUNT_POINT" ] && [ -d "$MOUNT_POINT" ]; then
    hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
  fi
  [ -n "$TMP_DIR" ] && rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# Check macOS
[ "$(uname)" = "Darwin" ] || error "This installer only works on macOS."

# Fetch latest release info
info "Checking latest version..."
RELEASE_JSON=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest") \
  || error "Failed to fetch release info. Check your network connection."

TAG=$(echo "$RELEASE_JSON" | grep '"tag_name"' | head -1 | sed 's/.*: *"\(.*\)".*/\1/')
DMG_URL=$(echo "$RELEASE_JSON" | grep '"browser_download_url"' | grep '\.dmg"' | head -1 | sed 's/.*: *"\(.*\)".*/\1/')

[ -n "$TAG" ]     || error "Could not determine latest version."
[ -n "$DMG_URL" ] || error "Could not find DMG download URL."

DMG_NAME=$(basename "$DMG_URL")
info "Latest version: ${TAG} (${DMG_NAME})"

# Download
TMP_DIR=$(mktemp -d)
DMG_PATH="${TMP_DIR}/${DMG_NAME}"

info "Downloading ${DMG_NAME}..."
curl -fSL --progress-bar -o "$DMG_PATH" "$DMG_URL" \
  || error "Download failed."

# Mount DMG
info "Installing ${APP_NAME}..."
MOUNT_POINT="/Volumes/${APP_NAME} Installer"
hdiutil detach "$MOUNT_POINT" 2>/dev/null || true
hdiutil attach "$DMG_PATH" -nobrowse -mountpoint "$MOUNT_POINT" -quiet \
  || error "Failed to mount DMG."
[ -d "$MOUNT_POINT" ] || error "Failed to find mount point."

# Find and copy .app
APP_PATH=$(find "$MOUNT_POINT" -maxdepth 1 -name "*.app" -type d | head -1)
[ -n "$APP_PATH" ] || error "Could not find .app in DMG."

# Kill running instance
if pgrep -x "$APP_NAME" >/dev/null 2>&1; then
  info "Closing running ${APP_NAME}..."
  killall "$APP_NAME" 2>/dev/null || true
  sleep 1
fi

# Copy to /Applications
rm -rf "${INSTALL_DIR}/${APP_NAME}.app"
cp -R "$APP_PATH" "${INSTALL_DIR}/" \
  || error "Failed to copy to ${INSTALL_DIR}. Try: sudo bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh)\""

# Remove quarantine
xattr -cr "${INSTALL_DIR}/${APP_NAME}.app" 2>/dev/null || true

ok "${APP_NAME} ${TAG} installed to ${INSTALL_DIR}/${APP_NAME}.app"
echo ""
info "To launch: open -a ${APP_NAME}"

#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_URL="https://github.com/juljus/neovim-config"
ARCHIVE_URL="${REPO_URL}/archive/refs/heads/main.tar.gz"

error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

success_msg() {
    echo -e "${GREEN}$1${NC}"
}

info_msg() {
    echo -e "${YELLOW}$1${NC}"
}

echo "Neovim Configuration Installer"
echo "==============================="
echo ""

# Check for curl
if ! command -v curl >/dev/null 2>&1; then
    error_exit "curl is not installed. Please install it and try again."
fi

# Check for tar
if ! command -v tar >/dev/null 2>&1; then
    error_exit "tar is not installed. Please install it and try again."
fi

# Check for a C compiler (needed for treesitter parser compilation)
if ! command -v cc >/dev/null 2>&1 && ! command -v gcc >/dev/null 2>&1; then
    error_exit "No C compiler found (cc or gcc). Treesitter parsers need one to compile."
fi

# Check for Neovim
echo "Checking for Neovim..."
if ! command -v nvim >/dev/null 2>&1; then
    error_exit "Neovim is not installed. Please install it (>= 0.9) and try again."
fi

NVIM_VERSION=$(nvim --version | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
NVIM_MAJOR=$(echo "$NVIM_VERSION" | cut -d. -f1)
NVIM_MINOR=$(echo "$NVIM_VERSION" | cut -d. -f2)

if [ "$NVIM_MAJOR" -eq 0 ] && [ "$NVIM_MINOR" -lt 9 ]; then
    error_exit "Neovim $NVIM_VERSION is too old. This config requires >= 0.9."
fi

success_msg "Neovim $NVIM_VERSION found."
echo ""

# Detect config directory
echo "Detecting Neovim config directory..."
CONFIG_DIR=$(nvim --headless -c 'lua io.write(vim.fn.stdpath("config"))' -c 'q' 2>&1)
if [ -z "$CONFIG_DIR" ]; then
    error_exit "Could not detect Neovim config directory."
fi
echo "Config directory: $CONFIG_DIR"
echo ""

# Handle existing config
BACKUP_DIR=""
if [ -d "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    info_msg "Existing Neovim configuration detected."
    echo -n "Do you want to backup the current configuration? [Y/n]: "
    read -r answer
    echo ""

    if [ "$answer" = "n" ] || [ "$answer" = "N" ]; then
        info_msg "Removing old configuration..."
        rm -rf "$CONFIG_DIR"
    else
        TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
        BACKUP_DIR="$(dirname "$CONFIG_DIR")/nvim_backup_$TIMESTAMP"
        echo "Creating backup..."
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        success_msg "Backup created: $BACKUP_DIR"
    fi
    echo ""
fi

# Download and extract config
echo "Downloading configuration..."
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

if ! curl -sL "$ARCHIVE_URL" -o "$TMPDIR/config.tar.gz"; then
    error_exit "Failed to download configuration."
fi

tar xzf "$TMPDIR/config.tar.gz" -C "$TMPDIR"
mv "$TMPDIR/neovim-config-main" "$CONFIG_DIR"

success_msg "Configuration installed!"
echo ""

echo "======================================"
success_msg "Installation complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Launch Neovim: nvim"
echo "  2. Plugins install automatically on first launch."
echo "  3. Treesitter parsers compile in the background."
echo ""
if [ -n "$BACKUP_DIR" ]; then
    echo "Old configuration backed up to:"
    echo "  $BACKUP_DIR"
    echo ""
fi

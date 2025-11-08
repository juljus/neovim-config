#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Repository URL
REPO_URL="https://github.com/juljus/neovim-config.git"

# Function to print error and exit
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Function to print success message
success_msg() {
    echo -e "${GREEN}$1${NC}"
}

# Function to print info message
info_msg() {
    echo -e "${YELLOW}$1${NC}"
}

echo "Neovim Configuration Installer"
echo "==============================="
echo ""

# Check if Neovim is installed
echo "Checking for Neovim..."
if ! command -v nvim >/dev/null 2>&1; then
    error_exit "Neovim is not installed on your system. Please install it and run this script again."
fi
success_msg "Neovim found."
echo ""

# Check if Git is installed
echo "Checking for Git..."
if ! command -v git >/dev/null 2>&1; then
    error_exit "Git is not installed on your system. Please install it and run this script again."
fi
success_msg "Git found."
echo ""

# Get Neovim config directory
echo "Detecting Neovim config directory..."
CONFIG_DIR=$(echo 'io.write(vim.fn.stdpath("config"))' | nvim -l - 2>/dev/null)
if [ -z "$CONFIG_DIR" ]; then
    error_exit "Could not detect Neovim config directory."
fi
echo "Config directory: $CONFIG_DIR"
echo ""

# Variables for backup
BACKUP_DIR=""
BACKUP_CREATED=false

# Function to restore backup
restore_backup() {
    if [ "$BACKUP_CREATED" = true ] && [ -d "$BACKUP_DIR" ]; then
        info_msg "Restoring backup..."
        rm -rf "$CONFIG_DIR"
        mv "$BACKUP_DIR" "$CONFIG_DIR"
        success_msg "Backup restored to $CONFIG_DIR"
    fi
}

# Check if config directory exists
if [ -d "$CONFIG_DIR" ]; then
    info_msg "Existing Neovim configuration detected."
    echo -n "Do you want to backup the current configuration? [Y/n]: "
    read -r answer
    echo ""
    
    if [ "$answer" = "n" ] || [ "$answer" = "N" ]; then
        info_msg "Skipping backup. Removing old configuration..."
        rm -rf "$CONFIG_DIR"
        echo "Old configuration removed."
    else
        # Create timestamped backup
        TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
        CONFIG_PARENT_DIR=$(dirname "$CONFIG_DIR")
        BACKUP_DIR="$CONFIG_PARENT_DIR/nvim_backup_$TIMESTAMP"
        
        echo "Creating backup..."
        mv "$CONFIG_DIR" "$BACKUP_DIR"
        BACKUP_CREATED=true
        success_msg "Backup created: $BACKUP_DIR"
    fi
    echo ""
fi

# Clone the repository
echo "Cloning Neovim configuration from repository..."
echo "Repository: $REPO_URL"
echo ""

if ! git clone "$REPO_URL" "$CONFIG_DIR"; then
    error_exit "Failed to clone repository. Restoring backup if available..."
    restore_backup
fi

success_msg "Repository cloned successfully!"
echo ""

# Success message
echo "======================================"
success_msg "Installation completed successfully!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Launch Neovim with: nvim"
echo "  2. Lazy.nvim will automatically install all plugins on first launch"
echo "  3. To update the configuration in the future, run: git pull"
echo "     (from inside $CONFIG_DIR)"
echo ""
if [ "$BACKUP_CREATED" = true ]; then
    echo "Your old configuration has been backed up to:"
    echo "  $BACKUP_DIR"
    echo ""
fi

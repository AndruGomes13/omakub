#!/bin/bash

# Omakub zsh setup for Linux (CLI only)
# Reuses existing install scripts

set -e

echo "Omakub zsh setup for Linux"
echo "=========================="

if [[ "$(uname)" != "Linux" ]]; then
  echo "Error: This script is intended for Linux only."
  exit 1
fi

OMAKUB_PATH="$HOME/.local/share/omakub"

# --- Detect if sudo is available ---
HAS_SUDO=false
if command -v sudo &>/dev/null && sudo -n true 2>/dev/null; then
  HAS_SUDO=true
fi
export HAS_SUDO

# --- Update packages / verify has required packages ---
if [[ "$HAS_SUDO" == "true" ]]; then
  sudo apt update -y
  sudo apt install -y curl git
else
  echo "No sudo access detected — installing to ~/.local"
  # Verify prerequisites
  for cmd in zsh curl git; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: '$cmd' is required but not found. Install it or get sudo access."
      exit 1
    fi
  done
  mkdir -p "$HOME/.local/bin"
fi

# --- Detect architecture for binary downloads ---
case "$(uname -m)" in
  x86_64) ARCH="x86_64" ;;
  aarch64|arm64) ARCH="aarch64" ;;
  *) echo "Error: Unsupported architecture: $ARCH"; exit 1 ;;
esac
export ARCH



# Reuse existing install scripts
source "$OMAKUB_PATH/install/terminal/apps-terminal.sh"
source "$OMAKUB_PATH/install/terminal/a-shell-zsh.sh"

echo ""
echo "Installation complete!"
echo "Restart your terminal or run: exec zsh"

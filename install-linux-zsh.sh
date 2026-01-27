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

sudo apt update -y
sudo apt install -y curl git

# Reuse existing install scripts
source "$OMAKUB_PATH/install/terminal/apps-terminal.sh"
source "$OMAKUB_PATH/install/terminal/a-shell-zsh.sh"

echo ""
echo "Installation complete!"
echo "Restart your terminal or run: exec zsh"

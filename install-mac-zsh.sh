#!/bin/bash

# Omakub zsh setup for macOS (CLI only)
# Reuses existing install scripts

set -e

echo "Omakub zsh setup for macOS"
echo "=========================="

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Error: This script is intended for macOS only."
  exit 1
fi

# Check for Homebrew, install if missing
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add Homebrew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

OMAKUB_PATH="$HOME/.local/share/omakub"

# Reuse existing install scripts (now cross-platform)
source "$OMAKUB_PATH/install/terminal/apps-terminal.sh"
source "$OMAKUB_PATH/install/terminal/a-shell-zsh.sh"

echo ""
echo "Installation complete!"
echo "Restart your terminal or run: exec zsh"

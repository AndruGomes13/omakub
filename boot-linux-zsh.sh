#!/bin/bash
set -e

OMAKUB_PATH="$HOME/.local/share/omakub"
git clone https://github.com/basecamp/omakub.git "$OMAKUB_PATH" 2>/dev/null || git -C "$OMAKUB_PATH" pull
exec "$OMAKUB_PATH/install-linux-zsh.sh"

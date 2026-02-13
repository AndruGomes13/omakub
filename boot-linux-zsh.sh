#!/bin/bash
set -e

OMAKUB_PATH="$HOME/.local/share/omakub"
if [[ -d "$OMAKUB_PATH/.git" ]]; then
  git -C "$OMAKUB_PATH" pull
else
  rm -rf "$OMAKUB_PATH"
  git clone -b no_sudo_installation https://github.com/AndruGomes13/omakub "$OMAKUB_PATH"
fi
exec "$OMAKUB_PATH/install-linux-zsh.sh" "$@"

#!/bin/bash

# Set zsh as the default shell (runs after apps-terminal.sh has installed zsh)
if [[ "$(uname)" == "Darwin" ]]; then
  chsh -s $(which zsh)
elif [[ "$USER_INSTALL" == "true" ]]; then
  ZSH_PATH=$(which zsh)
  MARKER="# Added by omakub: auto-switch to zsh"
  if ! grep -qF "$MARKER" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "$MARKER" >> ~/.bashrc
    echo "[ -x \"$ZSH_PATH\" ] && export SHELL=\"$ZSH_PATH\" && exec \"$ZSH_PATH\" -l" >> ~/.bashrc
  fi
  echo "Note: Added 'exec zsh' to ~/.bashrc (no sudo for chsh)"
else
  sudo chsh -s $(which zsh) $USER
fi

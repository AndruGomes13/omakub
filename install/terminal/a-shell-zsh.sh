#!/bin/bash

# Configure the zsh shell using Omakub defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak.$(date +%F_%H-%M-%S)

if [[ "$(uname)" == "Darwin" ]]; then
  cp ~/.local/share/omakub/configs/zshrc-macos ~/.zshrc
else
  cp ~/.local/share/omakub/configs/zshrc ~/.zshrc
fi

# Copy starship config if it doesn't exist
if [ ! -f ~/.config/starship.toml ]; then
  mkdir -p ~/.config
  cp ~/.local/share/omakub/configs/starship.toml ~/.config/starship.toml
fi

# Change default shell to zsh
if [[ "$(uname)" == "Darwin" ]]; then
  chsh -s $(which zsh)
elif [[ "$HAS_SUDO" == "false" ]]; then
  # Without sudo, add exec zsh to ~/.bashrc instead of using chsh
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

# Load the PATH for use later in the installers (using bash-compatible syntax)
source ~/.local/share/omakub/defaults/bash/shell

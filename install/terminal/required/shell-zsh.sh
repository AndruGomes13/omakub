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

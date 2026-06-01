#!/bin/bash

# Configure the zsh shell using Omakub defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak.$(date +%F_%H-%M-%S)

if [[ "$(uname)" == "Darwin" ]]; then
  cp ~/.local/share/omakub/configs/zshrc-macos ~/.zshrc
else
  cp ~/.local/share/omakub/configs/zshrc ~/.zshrc
fi

# Link starship config so repo updates apply automatically
mkdir -p ~/.config
[ -f ~/.config/starship.toml ] && [ ! -L ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak.$(date +%F_%H-%M-%S)
ln -sf ~/.local/share/omakub/configs/starship.toml ~/.config/starship.toml

#!/bin/bash

# Install zsh and plugins
sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Configure the zsh shell using Omakub defaults
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
cp ~/.local/share/omakub/configs/zshrc ~/.zshrc

# Copy starship config if it doesn't exist
if [ ! -f ~/.config/starship.toml ]; then
  mkdir -p ~/.config
  cp ~/.local/share/omakub/configs/starship.toml ~/.config/starship.toml
fi

# Change default shell to zsh
sudo chsh -s $(which zsh) $USER

# Load the PATH for use later in the installers (using bash-compatible syntax)
source ~/.local/share/omakub/defaults/bash/shell

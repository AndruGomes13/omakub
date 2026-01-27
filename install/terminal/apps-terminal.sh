#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  brew install fzf ripgrep bat eza zoxide fd
  brew install zsh-autosuggestions zsh-syntax-highlighting starship
else
  # Linux
  sudo apt install -y fzf ripgrep bat eza zoxide plocate apache2-utils fd-find
  sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

#!/bin/bash

# Configure the bash shell using Omakub defaults (kept for compatibility)
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/omakub/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/omakub/defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Omakub defaults
cp ~/.local/share/omakub/configs/inputrc ~/.inputrc

# Install and configure zsh as the default shell
source ~/.local/share/omakub/install/terminal/a-shell-zsh.sh

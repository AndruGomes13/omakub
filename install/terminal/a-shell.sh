#!/bin/bash

# Configure the bash shell using Omakub defaults (kept for compatibility)
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/omakub/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/omakub/defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Omakub defaults
cp ~/.local/share/omakub/configs/inputrc ~/.inputrc

# Configure zsh (shell change happens in z-set-default-shell.sh after zsh is installed)
source ~/.local/share/omakub/install/terminal/required/shell-zsh.sh

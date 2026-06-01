#!/bin/bash

# Alacritty is a GPU-powered and highly extensible terminal. See https://alacritty.org/
sudo apt install -y alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/.local/share/omakub/configs/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf ~/.local/share/omakub/configs/alacritty/shared.toml ~/.config/alacritty/shared.toml
ln -sf ~/.local/share/omakub/configs/alacritty/pane.toml ~/.config/alacritty/pane.toml
ln -sf ~/.local/share/omakub/configs/alacritty/btop.toml ~/.config/alacritty/btop.toml
ln -sf ~/.local/share/omakub/themes/everforest/alacritty.toml ~/.config/alacritty/theme.toml
ln -sf ~/.local/share/omakub/configs/alacritty/fonts/CaskaydiaMono.toml ~/.config/alacritty/font.toml
ln -sf ~/.local/share/omakub/configs/alacritty/font-size.toml ~/.config/alacritty/font-size.toml

# Migrate config format if needed
alacritty migrate 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/pane.toml 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/btop.toml 2>/dev/null || true

source ~/.local/share/omakub/install/desktop/set-alacritty-default.sh

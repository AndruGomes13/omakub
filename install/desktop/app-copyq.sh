#!/bin/bash

# Install CopyQ clipboard manager
sudo apt install -y copyq

# Set up autostart
mkdir -p ~/.config/autostart
cp /usr/share/applications/com.github.hluk.copyq.desktop ~/.config/autostart/

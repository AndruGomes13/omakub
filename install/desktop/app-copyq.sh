#!/bin/bash

# Install CopyQ clipboard manager
sudo apt install -y copyq

# Set up autostart with GTK platform theme so CopyQ follows GNOME dark mode
mkdir -p ~/.config/autostart
cp /usr/share/applications/com.github.hluk.copyq.desktop ~/.config/autostart/
sed -i 's/^Exec=copyq/Exec=env QT_QPA_PLATFORMTHEME=gtk3 copyq/' ~/.config/autostart/com.github.hluk.copyq.desktop

#!/usr/bin/env bash


set -euo pipefail

sudo pacman -Syu --needed --noconfirm 
sudo pacman -S foot capitaine-cursors river-classic ttf-profont-nerd waybar swaybg


mkdir -p ~/.config/river
mv ~/River-Minimal/init ~/.config/river/init
chmod +x ~/.config/river/init
mkdir -p ~/.config/gtk-3.0

sudo rm -rf ~/.bash_profile
mv ~/River-Minimal/.profile ~/.profile

#cp -r ~/River-Minimal/waybar/  ~/.config/waybar/
sudo reboot

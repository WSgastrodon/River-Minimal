#!/usr/bin/env bash

# Exit immediately if any command fails, and treat unset variables as an error
set -euo pipefail
echo " Starting the environment installation..."

echo " Installing system packages..."
sudo pacman -Syu --needed --noconfirm 
sudo pacman -S foot capitaine-cursors river-classic 

# Step 3: Create User Configuration Directories
echo "$ Setting up configuration directories..."
mkdir -p ~/.config/river
mv $HOME/River-Minimal/init ~/.config/river/init
chmod +x ~/.config/river/init
mkdir -p ~/.config/gtk-3.0

sudo rm -rf ~/.bash_profile
mv ~/River-Minimal/.bash_profile




echo " Installation completed successfully!"

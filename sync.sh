#!/usr/bin/env bash
# sync — copy live configs back into this repo after you tweak them
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"

# --- river (REPLACED NIRI) ---
mkdir -p "$DOT/config/river"
cp ~/.config/river/init                 "$DOT/config/river/"
cp ~/.config/wlogout/layout             "$DOT/config/wlogout/"       2>/dev/null || true

# --- waybar ---
cp ~/.config/waybar/config.jsonc        "$DOT/config/waybar/"
cp ~/.config/waybar/style.css           "$DOT/config/waybar/"        2>/dev/null || true
cp ~/.config/waybar/colors.css          "$DOT/config/waybar/"        2>/dev/null || true
rsync -a --delete ~/.config/waybar/scripts/  "$DOT/config/waybar/scripts/"
rsync -a --delete ~/.config/waybar/themes/   "$DOT/config/waybar/themes/"

# --- launchers / daemons ---
cp ~/.config/fuzzel/fuzzel.ini          "$DOT/config/fuzzel/"        2>/dev/null || true
cp ~/.config/mako/config                "$DOT/config/mako/"          2>/dev/null || true

# --- foot (terminal) ---
mkdir -p "$DOT/config/foot"
cp ~/.config/foot/foot.ini              "$DOT/config/foot/"
cp ~/.config/foot/rice-theme.ini        "$DOT/config/foot/"          2>/dev/null || true

# --- matugen (wallpaper -> every app) ---
rsync -a --delete ~/.config/matugen/templates/ "$DOT/config/matugen/templates/"
cp ~/.config/matugen/config.toml        "$DOT/config/matugen/"

# --- GTK ---
cp ~/.config/gtk-3.0/gtk.css            "$DOT/config/gtk-3.0/"       2>/dev/null || true
cp ~/.config/gtk-4.0/gtk.css            "$DOT/config/gtk-4.0/"       2>/dev/null || true

# --- environment / misc ---
cp ~/.config/environment.d/*.conf       "$DOT/config/environment.d/"
rsync -a --delete ~/.config/niri-rice/  "$DOT/config/niri-rice/"     2>/dev/null || true

# --- rice scripts ---
rm -f "$DOT"/local-bin/rice-*
cp ~/.local/bin/rice-*                  "$DOT/local-bin/"

# --- editors ---
mkdir -p "$DOT/editors/nvim"
cp ~/.vimrc                             "$DOT/editors/vimrc"         2>/dev/null || true
cp ~/.config/nvim/init.lua              "$DOT/editors/nvim/init.lua" 2>/dev/null || true
cp ~/.config/nano/nanorc                "$DOT/editors/nanorc"        2>/dev/null || true

# --- wallpapers (keep repo copy in step with live pool) ---
mkdir -p "$DOT/wallpapers"
cp -rn ~/Pictures/_wallpapers/*         "$DOT/wallpapers/"           2>/dev/null || true

echo "synced."

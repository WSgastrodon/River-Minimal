#!/usr/bin/env bash
# install — link these dotfiles into $HOME (works on a fresh machine too)
set -euo pipefail
DOT="$(cd "$(dirname "$0")" && pwd)"

link() {  # link <repo-file> <target>
    mkdir -p "$(dirname "$2")"
    ln -sfn "$1" "$2"
}

# --- configs ---
# CREATED RIVER COMPATIBILITY
link "$DOT/config/river/init"             ~/.config/river/init
link "$DOT/config/waybar/config.jsonc"    ~/.config/waybar/config.jsonc
link "$DOT/config/waybar/style.css"       ~/.config/waybar/style.css
mkdir -p ~/.config/waybar
rsync -a "$DOT/config/waybar/scripts/"     ~/.config/waybar/scripts/
rsync -a "$DOT/config/waybar/themes/"      ~/.config/waybar/themes/
link "$DOT/config/foot/foot.ini"          ~/.config/foot/foot.ini
link "$DOT/config/mako/config"            ~/.config/mako/config
link "$DOT/config/matugen/config.toml"    ~/.config/matugen/config.toml
rsync -a "$DOT/config/matugen/templates/" ~/.config/matugen/templates/
link "$DOT/config/environment.d/90-wayland-perf.conf" \
     ~/.config/environment.d/90-wayland-perf.conf
link "$DOT/config/wlogout/layout"          ~/.config/wlogout/layout

# generated files: copy once so apps work before first matugen run
cp -n "$DOT/config/foot/rice-theme.ini"    ~/.config/foot/rice-theme.ini    2>/dev/null || true
cp -n "$DOT/config/waybar/colors.css"      ~/.config/waybar/colors.css      2>/dev/null || true
cp -n "$DOT/config/fuzzel/fuzzel.ini"      ~/.config/fuzzel/fuzzel.ini      2>/dev/null || true
cp -n "$DOT/config/gtk-3.0/gtk.css"        ~/.config/gtk-3.0/gtk.css        2>/dev/null || true
cp -n "$DOT/config/gtk-4.0/gtk.css"        ~/.config/gtk-4.0/gtk.css        2>/dev/null || true

# --- editors ---
link "$DOT/editors/vimrc"                  ~/.vimrc                          2>/dev/null || true
mkdir -p ~/.config/nvim ~/.config/nano
cp -n "$DOT/editors/nvim/init.lua"         ~/.config/nvim/init.lua           2>/dev/null || true
cp -n "$DOT/editors/nanorc"                ~/.config/nano/nanorc             2>/dev/null || true

# --- rice scripts + layout ---
# CLEANED: Purged the old niri-rice folder structures entirely
mkdir -p ~/.local/bin
if [ -d "$DOT/local-bin" ] && [ -n "$(ls -A "$DOT/local-bin" 2>/dev/null)" ]; then
    install -m755 "$DOT"/local-bin/rice-* ~/.local/bin/
fi

# Automatically flag execution permissions for your River startup script
chmod +x ~/.config/river/init 2>/dev/null || true

# --- wallpapers ---
if [ -d "$DOT/wallpapers" ] && [ -n "$(ls -A "$DOT/wallpapers")" ]; then
    mkdir -p ~/Pictures/_wallpapers
    cp -rn "$DOT"/wallpapers/* ~/Pictures/_wallpapers/
    echo "installed $(ls -1 "$DOT/wallpapers" | wc -l) wallpapers to ~/Pictures/_wallpapers"
fi

# --- dependencies check ---
echo "checking packages..."
for c in river waybar swaybg swayidle mako fuzzel foot cliphist wl-paste matugen \
         brightnessctl playerctl wpctl pamixer nmcli grim slurp python; do
    command -v "$c" >/dev/null 2>&1 || echo "  MISSING: $c"
done

echo
echo "done. You can now launch your ultra-lightweight environment by running:"
echo "  river"

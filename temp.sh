#!/bin/sh




doas apk add mesa-dri-gallium seatd river-classic river-classic-doc foot adwaita-icon-theme font-dejavu dbus

doas addgroup "$USER" input
doas addgroup "$USER" video
doas addgroup "$USER" seat

doas setup-devd udev
doas setup-wayland-base
doas rc-update add seatd boot
doas rc-service seatd start

doas mv ~/River-Minimal/init ~/.config/river/init
chmod +x ~/.config/river/init
cat << 'EOL' >> ~/.profile
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/tmp/runtime-$(id -u)
    mkdir -p -m 0700 "$XDG_RUNTIME_DIR"
fi
export MOZ_ENABLE_WAYLAND=1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    WLR_RENDERER=pixman exec river -no-xwayland
fi
EOL


doas reboot

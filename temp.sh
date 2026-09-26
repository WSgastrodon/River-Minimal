#!/bin/sh




doas apk add mesa-dri-gallium seatd river-classic river-classic-doc foot adwaita-icon-theme font-dejavu dbus

doas addgroup evan input
doas addgroup evan video
doas addgroup evan seat

doas setup-devd udev
doas setup-wayland-base
doas rc-update add seatd boot
doas rc-service seatd start

doas install -Dm0755 /usr/share/doc/river/examples/init -t ~/.config/river

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

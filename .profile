doas ip link set usb0 up
doas udhcpc -b -i usb0
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR=/tmp/runtime-$(id -u)
    mkdir -p -m 0700 "$XDG_RUNTIME_DIR"
fi
export WLR_RENDERER=pixman
export MOZ_ENABLE_WAYLAND=1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec river -no-xwayland
fi

# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    # Force application toolkits into native Wayland mode
    export XDG_SESSION_TYPE="wayland"
    export GDK_BACKEND="wayland"
    export QT_QPA_PLATFORM="wayland"
    export MOZ_ENABLE_WAYLAND=1
    export NO_AT_BRIDGE=1
    export WLR_NO_XWAYLAND=1 
    export WLR_NO_HARDWARE_CURSORS=1
    export XCURSOR_THEME="capitaine-cursors"
    export XCURSOR_SIZE="22"
    exec river -no-xwayland
fi

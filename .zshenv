export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum"
export GTK_THEME="Adwaita-dark"
export XCURSOR_PATH=${XCURSOR_PATH}:~/.icons
export XCURSOR_SIZE=24
export GPG_TTY=$(tty)
export BAT_THEME="Visual Studio Dark+"

# Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export XDG_CURRENT_DESKTOP="sway"
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland"
fi

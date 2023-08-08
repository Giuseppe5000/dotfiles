export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum"
export XDG_CURRENT_DESKTOP="sway"

# Wayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland"
fi

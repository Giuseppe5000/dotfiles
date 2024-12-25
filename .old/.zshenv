export PATH="$HOME/.local/bin:$PATH"
export QT_STYLE_OVERRIDE="Adwaita-dark"
export GTK_THEME="Adwaita-dark"
export XCURSOR_PATH=${XCURSOR_PATH}:~/.icons
export XCURSOR_SIZE=24
export GPG_TTY=$(tty)

# Wayland
if command -v sway &> /dev/null
then
    export XDG_CURRENT_DESKTOP="sway"
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland"
fi

export PATH="$HOME/Downloads/ampl:$PATH"

#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    fish -c "printf \"y\n\" | fish_config theme save \"Nord\""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # The following steps are added for GNOME-based OSs only
    # We don't want this to execute if we're not on a GNOME-based OSs.

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nord for gnome-terminal
    # see: https://github.com/nordtheme/gnome-terminal

    # Check if the gnome-terminal command exists
    if cmd_exists "gnome-terminal"; then
        git clone https://github.com/nordtheme/gnome-terminal.git

        cd gnome-terminal/src || exit 1

        ./nord.sh -p Nord
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set the desktop background to the Nord wallpaper

    # Check if the `gsettings` command exists
    if cmd_exists "gsettings"; then
        gsettings \
            set org.gnome.desktop.background \
            picture-uri "file://$HOME/set-me-up/dotfiles/modules/nord/wallpaper/magma.jpg"
    fi

}

main

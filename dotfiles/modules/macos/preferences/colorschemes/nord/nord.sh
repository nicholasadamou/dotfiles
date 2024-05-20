#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    fish -c "printf \"y\n\" | fish_config theme save \"Nord\""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nord for terminal on MacOS

    ./apps/terminal/set_terminal_theme.applescript

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Nord for iTerm2 on MacOS

    ./apps/iterm2/set_iterm2_theme.applescript

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set the desktop background to the Nord wallpaper

    # Check if the `wallpaper` command exists
    if cmd_exists "wallpaper"; then
        wallpaper set "${current_dir}/wallpapers/magma.jpg"
    fi

}

main

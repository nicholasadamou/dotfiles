#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Check if debian

    if [[ "$(get_os)" == "debian" ]]; then
        # Install thoughtbot/RCM for dotfile management.
        # see: https://github.com/thoughtbot/rcm#installation

        ! package_is_installed "rcm" && {
            wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
            echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
            sudo apt update
            sudo apt install -y "rcm"
        }

        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_bundle_install -f "brewfile"

}

main

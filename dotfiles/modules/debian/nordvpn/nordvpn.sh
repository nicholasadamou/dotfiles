#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_nordvpn() {

    # see: https://nordvpn.com/download/linux/

    if cmd_exists "curl"; then
        sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)
    elif cmd_exists "wget"; then
        sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh)
    else
        return 1
    fi

    # Verify that the installation was successful
    if ! nordvpn --version &>/dev/null; then
        return 1
    fi

}

main() {

    # Check if OS is Debian
    if ! is_debian; then
        error "This script is only for Debian!"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    apt_install_from_file "packages"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_nordvpn

}

main

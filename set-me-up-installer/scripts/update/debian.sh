#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ask_for_sudo

	sudo apt update \
			&& sudo apt upgrade -y \
			&& sudo apt full-upgrade -y \
			&& sudo apt autoremove -y \
			&& sudo apt clean

}

main

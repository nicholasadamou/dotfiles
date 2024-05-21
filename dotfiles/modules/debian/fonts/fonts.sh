#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Nerd Fonts
# see: https://www.nerdfonts.com/font-downloads
declare -a fonts=(
    FiraCode
)

main() {

    # Check if OS is Debian
    if ! is_debian; then
        error "This script is only for Debian!"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    apt_install_from_file "packages"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    local fonts_dir="${HOME}/.local/share/fonts"

    if [[ ! -d "$fonts_dir" ]]; then
        mkdir -p "$fonts_dir"
    fi

    # Use GitHub API to fetch the latest version
    local version
    version=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

    if [[ -z "$version" ]]; then
        echo "Error: Unable to fetch latest version of Nerd Fonts."
        exit 1
    fi

    echo "Downloading Nerd Fonts version: $version"

    for font in "${fonts[@]}"; do
        local zip_file="${font}.zip"
        local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"

        wget "$download_url" -O "$zip_file" || continue
        unzip "$zip_file" -d "$fonts_dir"

        rm "$zip_file"
    done

    find "$fonts_dir" -name '*Windows Compatible*' -delete

    fc-cache -fv

}

main

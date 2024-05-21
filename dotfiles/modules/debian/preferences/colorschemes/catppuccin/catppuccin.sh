#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    fisher install catppuccin/fish

    fish_config theme save "Catppuccin Macchiato"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for gnome-terminal
    # see: https://github.com/catppuccin/gnome-terminal

    curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for Bat
    # see: https://github.com/catppuccin/bat

    git clone https://github.com/catppuccin/bat ~/.config/bat/catppuccin

    cd ~/.config/bat/catppuccin || exit 1

    mkdir -p "$(bat --config-dir)/themes"

    cp *.tmTheme "$(bat --config-dir)/themes"

    bat cache --build

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for lazygit
    # see: https://github.com/catppuccin/lazygit

    git clone https://github.com/catppuccin/lazygit ~/.config/lazygit/catppuccin

    cd ~/.config/lazygit/catppuccin || exit 1

    local config_dir="$(lazygit --config-dir)"

    lazygit --use-config-file="${config_dir}/config.yml,macchiato-blue.yml"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Catppuccin for starship
    # see: https://github.com/catppuccin/starship

    cp starship.toml ~/.config/starship.toml

}

main

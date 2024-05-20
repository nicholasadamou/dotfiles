#!/bin/bash

source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

if brew info alfred &>/dev/null; then
	# install alfred packages
	sudo_npm_install "awm"
	sudo_npm_install "alfred-fkill"
	sudo_npm_install "@bchatard/alfred-jetbrains"
	sudo_npm_install "alfred-npms"
fi

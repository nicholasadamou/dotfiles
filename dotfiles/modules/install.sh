#!/bin/bash

# GitHub user/repo & branch value of your set-me-up blueprint (e.g.: dotbrains/set-me-up-blueprint/master).
# Set this value when the installer should additionally obtain your blueprint.
export SMU_BLUEPRINT=${SMU_BLUEPRINT:-"nicholasadamou/dotfiles"}
export SMU_BLUEPRINT_BRANCH=${SMU_BLUEPRINT_BRANCH:-"main"}

# A set of ignored paths that 'git' will ignore
# syntax: '<path>|<path>'
# Note: <path> is relative to '$HOME/set-me-up'
export SMU_IGNORED_PATHS="${SMU_IGNORED_PATHS:-""}"

bash <(curl -s -L https://raw.githubusercontent.com/dotbrains/set-me-up-installer/main/install.sh)

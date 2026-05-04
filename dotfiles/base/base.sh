#!/bin/bash

# shellcheck source=/dev/null

declare current_dir &&
    current_dir="$(dirname "${BASH_SOURCE[0]}")" &&
    cd "${current_dir}" &&
    source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

readonly SMU_PATH="$HOME/set-me-up"

# Get the absolute path of the dotfiles directory.
# This is only for aesthetic reasons to have an absolute symlink path instead of a relative one
# <path-to-smu>/dotfiles/somedotfile vs <path-to-smu>/dotfiles/base/../somedotfile
readonly dotfiles="${SMU_PATH}/dotfiles"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_fish_local() {

    declare -r FILE_PATH="$HOME/.fish.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [[ ! -e "$FILE_PATH" ]] || [[ -z "$FILE_PATH" ]]; then
        touch "$FILE_PATH"
    fi

}

change_default_shell_to_fish() {

    local PATH_TO_FISH=""
    local current_shell=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Get the path of `fish` which was installed through `Homebrew`.

    PATH_TO_FISH="$(brew --prefix)/bin/fish"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Add the path of the `fish` version installed through `Homebrew`
    # to the list of login shells from the `/etc/shells` file.
    #
    # This needs to be done because applications use this file to
    # determine whether a shell is valid (e.g.: `chsh` consults the
    # `/etc/shells` to determine whether an unprivileged user may
    # change the login shell for their own account).
    #
    # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

    if ! grep -Fxq "$PATH_TO_FISH" /etc/shells; then
        printf '%s\n' "$PATH_TO_FISH" | sudo tee -a /etc/shells &>/dev/null
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Set latest version of `fish` as the default shell
    if is_macos && cmd_exists "dscl"; then
        current_shell="$(dscl . -read /Users/"${USER}"/ UserShell | cut -d ' ' -f2)"
    elif cmd_exists "getent"; then
        current_shell="$(getent passwd "${USER}" | cut -d ':' -f7)"
    else
        current_shell="${SHELL:-}"
    fi

    if [[ "$current_shell" != "${PATH_TO_FISH}" ]]; then
        chsh -s "$PATH_TO_FISH" &>/dev/null
    fi

}

install_fisher() {

    if ! is_fisher_installed; then
        curl -Lo "$HOME"/.config/fish/functions/fisher.fish --create-dirs --silent https://git.io/fisher
    fi

}

install_fisher_packages() {

    if [ -f "$HOME/.config/fish/fish_plugins" ]; then
        cat <"$HOME/.config/fish/fish_plugins" | while read -r PACKAGE; do
            fisher_install "$PACKAGE"
        done
    fi

    fisher_update

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute_for_platform() {
    local platform="$1"
    local module="$2"
    local script=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    case "$platform" in
    debian | macos | arch | universal) ;;
    *)
        printf "Platform '%s' is not supported\n" "$platform" >&2
        return 1
        ;;
    esac

    if [[ "$module" == "preferences" ]]; then
        script="$dotfiles/modules/preferences/preferences.sh"
    elif [[ "$platform" == "universal" ]]; then
        # Handle subpaths like "ai/chatgpt"
        local module_name="${module##*/}"
        script="$dotfiles/modules/universal/$module/$module_name.sh"
    else
        # Handle subpaths like "terminal/terminator" or "browsers/chrome"
        local module_name="${module##*/}"  # Get last component (e.g., "terminator" from "terminal/terminator")
        script="$dotfiles/modules/$platform/$module/$module_name/$module_name.sh"
    fi

    if [[ ! -f "$script" ]]; then
        printf "Module '%s' is not available for platform '%s' (expected: %s)\n" "$module" "$platform" "$script" >&2
        return 1
    fi

    bash "$script"
}

if is_debian; then
    platform="debian"
elif is_macos; then
    platform="macos"
elif is_arch_linux; then
    platform="arch"
else
    platform="universal"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    # Run the base `set-me-up` script

    execute_for_platform "universal" "base"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if is_debian; then
        apt_install_from_file "packages"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Configure `fish` shell

    create_fish_local

    change_default_shell_to_fish

    install_fisher

    install_fisher_packages

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute_for_platform "$platform" "fonts/fira-code"
    execute_for_platform "$platform" "fonts/jetbrains-mono"

}

main

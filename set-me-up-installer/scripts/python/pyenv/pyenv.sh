#!/bin/bash

# shellcheck source=/dev/null

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" && \
    source "$HOME/set-me-up/.dotfiles/utilities/utilities.sh"

LOCAL_BASH_CONFIG_FILE="${HOME}/.bash.local"
LOCAL_FISH_CONFIG_FILE="${HOME}/.fish.local"

declare -r PYENV_DIRECTORY="$HOME/.pyenv"
declare -r PYENV_INSTALLER_URL="https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# If needed, add the necessary configs in the
# local shell configuration files.
add_pyenv_configs() {

    # bash

    declare -r BASH_CONFIGS="
# PyEnv - Simple Python version management.
export PYENV_ROOT=\"$PYENV_DIRECTORY\"
export PATH=\"\$PYENV_ROOT/bin:\$PATH\"
export PATH=\"\$PYENV_ROOT/shims:\$PATH\"
export PATH=\"$HOME/.local/bin:\$PATH\"
export PATH=\"$HOME/Library/Python/2.7/bin:\$PATH\"
export PATH=\"$HOME/Library/Python/3.7/bin:\$PATH\"
eval \"\$(pyenv init -)\""

    if [[ ! -e "$LOCAL_BASH_CONFIG_FILE" ]] || ! grep -q "$(<<<"$BASH_CONFIGS" tr '\n' '\01')" < <(less "$LOCAL_BASH_CONFIG_FILE" | tr '\n' '\01'); then
        printf '%s\n' "$BASH_CONFIGS" >> "$LOCAL_BASH_CONFIG_FILE" \
                && . "$LOCAL_BASH_CONFIG_FILE"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # fish

    declare -r FISH_CONFIGS="
# PyEnv - Simple Python version management.
set -gx PYENV_ROOT $PYENV_DIRECTORY
set -gx PATH \$PATH \$PYENV_ROOT/bin
set -gx PATH \$PATH \$PYENV_ROOT/shims
set -gx PATH \$PATH $HOME/.local/bin
set -gx PATH \$PATH $HOME/Library/Python/2.7/bin
set -gx PATH \$PATH $HOME/Library/Python/3.7/bin"

    if [[ ! -e "$LOCAL_FISH_CONFIG_FILE" ]] || ! grep -q "$(<<<"$FISH_CONFIGS" tr '\n' '\01')" < <(less "$LOCAL_FISH_CONFIG_FILE" | tr '\n' '\01'); then
        printf '%s\n' "$FISH_CONFIGS" >> "$LOCAL_FISH_CONFIG_FILE"
    fi

}

install_pyenv() {

    # Install `pyenv` and add the necessary
    # configs in the local shell config files.

    curl -sL ${PYENV_INSTALLER_URL} | bash && add_pyenv_configs

}

update_pyenv() {

    . "$LOCAL_BASH_CONFIG_FILE" \
            && pyenv update

}

install_pyenv_plugin() {

    # `pyenv-install-latest` is deprecated.
    # see: https://github.com/momo-lab/pyenv-install-latest/commit/ecfec34c488c3cd9040ee2fa3020befcfe318b3a
    # pyenv_install "https://github.com/momo-lab/pyenv-install-latest.git"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # **env-latest
    # This **env(pyenv, rbenv, nodenv, goenv, phpenv, luaenv) plugin replaces 
    # the version specified in the argument with the latest version.
    # see: https://github.com/momo-lab/xxenv-latest

    git clone https://github.com/momo-lab/xxenv-latest.git "$(pyenv root)"/plugins/xxenv-latest

}

# install_latest_stable_python() {

#     # Install the latest stable version of Python
#     # (this will also set it as the default).

#     # Determine which version is the LTS version of Python
#     # see: https://stackoverflow.com/a/33423958/5290011

#     # Determine the current version of Python installed
#     # see: https://stackoverflow.com/a/30261215/5290011

#     local latest_version
#     local current_version

#     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#     # Check if `pyenv` is installed

#     if ! cmd_exists "pyenv"; then
#         return 1
#     fi

#     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#     latest_version="$(
#         . "$LOCAL_BASH_CONFIG_FILE" \
#         && pyenv install --list | \
#         grep -v -E '(anaconda|activepython|miniconda|miniforge|micropython|graal|ironpython|jython|nogil|pypy|stackless|pyston)-[0-9]' | grep -v -E '([a-zA-Z])' | \
#         tail -1 | \
#         tr -d '[:space:]'
#     )"

#     current_version="$(
#         python -V 2>&1 | cut -d " " -f2
#     )"

#     # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#     if [[ ! -d "$PYENV_DIRECTORY/versions/$latest_version" ]] && [[ "$current_version" != "$latest_version" ]]; then
#         . "$LOCAL_BASH_CONFIG_FILE" \
# 			&& pyenv install "$latest_version" \
# 			&& pyenv global "$latest_version"
#     fi

# }

install_latest_stable_python() {

    # Install the latest stable version of Python
    # (this will also set it as the default)

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if `pyenv` is installed

    if ! cmd_exists "pyenv"; then
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check that **env-latest is installed
    if -d "$PYENV_DIRECTORY"/plugins/xxenv-latest; then
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    pyenv latest install && \
        pyenv latest global

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    brew_bundle_install -f "brewfile"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    if ! cmd_exists "pyenv"; then
        install_pyenv
    else
        update_pyenv
    fi

    install_pyenv_plugin

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_latest_stable_python

}

main

#!/bin/bash

# shellcheck source=/dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

source_bash_files() {

    declare -r -a FILES_TO_SOURCE=(
        "bash_aliases"
        "bash_autocomplete"
        "bash_exports"
        "bash_functions"
        "bash_options"
        # "bash_prompt" Note: Using starship prompt instead (see: https://starship.rs).
        "inputrc"
        "keybindings"
    )

    local file=""
    local i=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in ${!FILES_TO_SOURCE[*]}; do

        file="$HOME/.config/bash/bash/${FILES_TO_SOURCE[$i]}"

        [[ -r "$file" ]] &&
            . "$file"

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

source_bash_files
unset -f source_bash_files

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check to see if the Mac needs Rosetta installed by testing the processor
processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Apple")

if [[ -n $processor ]]; then

    # 'brew' configurations
    eval "$(/opt/homebrew/bin/brew shellenv)"

else

    # 'brew' configurations
    eval "$(/usr/local/bin/brew shellenv)"

fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# load 'bash-sensible' configs.
# see: https://github.com/mrzool/bash-sensible

if [[ -d "$HOME"/.config/bash-sensible ]]; then
    . "$HOME"/.config/bash-sensible/sensible.bash
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# load 'fzf' configs.
# see: https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# load 'z.lua' configs.
# see: https://github.com/skywind3000/z.lua#install

if [[ -d "$HOME"/.z.lua ]]; then
    eval "$(lua "$HOME"/.z.lua/z.lua --init bash)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# load starship prompt
# see: https://starship.rs

eval "$(starship init bash)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# load nord theme
# see: https://github.com/lemnos/theme.sh
if command -v theme &>/dev/null; then
    theme nord
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# start tmux on start up of bash
# see: https://unix.stackexchange.com/a/260248

#if test -z "$TMUX"; then
#  session_num=$(
#    tmux list-sessions |
#    grep -v attached |
#    grep -oE '^\d+:' |
#    grep -oE '^\d+' |
#    head -1
#  )
#  if test "$session_num"; then
#    exec tmux attach -t "$session_num"
#  else
#    exec tmux
#  fi
#fi

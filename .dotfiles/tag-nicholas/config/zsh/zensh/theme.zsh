# Nord for fzf
# see: https://github.com/ianchesal/nord-fzf

if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Nord for Bat

if command -v bat &>/dev/null; then
    export BAT_THEME='Nord'
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Nord dircolors
# see: https://github.com/coltondick/zsh-dircolors-nord
source "zsh-dircolors-nord/zsh-dircolors-nord.zsh"

# fish variables

# NOTE: There is probably a sexier nicer way to do this, but until I figure that out I am manually unset PATH
set -gx PATH

# Sets necessary PATH defaults
set -gx PATH $PATH /usr/local/bin /usr/bin /bin /sbin /usr/sbin /usr/local/sbin /sbin $HOME/.fig/bin $HOME/.local/bin $HOME/.local/bin/tmux-session $HOME/.local/bin/etcher-cli /home/linuxbrew/.linuxbrew/bin /snap/bin $HOME/"set-me-up" $HOME/"set-me-up"/"set-me-up-installer"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Catppuccin for fzf (Macchiato)
# see: https://github.com/catppuccin/fzf
# set -Ux FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS "\
# 	--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
# 	--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
# 	--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Catppuccin for Bat (Macchiato)
# see: https://github.com/catppuccin/bat
# set BAT_THEME "Catppuccin-macchiato"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Nord for fzf
# see: https://github.com/ianchesal/nord-fzf
set -Ux FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS '
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# Nord for Bat
set BAT_THEME "Nord"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby configurations
# Adds "GEMS_PATH" to "$PATH"
# Fixes "I INSTALLED GEMS WITH --user-install AND THEIR COMMANDS ARE NOT AVAILABLE"
# see: https://guides.rubygems.org/faqs/#user-install
if type -q gem
	if test -d (gem environment gemdir)/bin
		set -gx PATH $PATH (gem environment gemdir)/bin
	end
end

# Dotfiles directory
set DOTFILES $HOME/"set-me-up"

# Theme
# set tacklebox_theme entropy

# Which modules would you like to load? (modules can be found in ~/.tackle/modules/*)
# Custom modules may be added to ~/.tacklebox/modules/
# Example format: set tacklebox_modules virtualfish virtualhooks

# Which plugins would you like to enable? (plugins can be found in ~/.tackle/plugins/*)
# Custom plugins may be added to ~/.tacklebox/plugins/
# Example format: set tacklebox_plugins python extract

# Change spacefish char
# see: https://spacefish.matchai.me/docs/Options.html#char
set SPACEFISH_CHAR_SYMBOL "\$"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure Neovim as default editor

set EDITOR "nvim"
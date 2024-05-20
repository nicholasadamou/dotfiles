# load aliases
source "$HOME/.config/fish/aliases/aliases.fish"

# load fish variables
source "$HOME/.config/fish/variables/variables.fish"

# load key bindings
source "$HOME/.config/fish/keybindings/keybindings.fish"

# load local fish configurations
source "$HOME/.fish.local"

# load 'brew' configurations

# see: https://docs.brew.sh/Installation
if test (uname) = "Darwin" # Check if OS is macOS
    if test -f /opt/homebrew/bin/brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
    end
    
    if test -f /usr/local/bin/brew
        eval "$(/usr/local/bin/brew shellenv)"
    end
end

# see: https://docs.brew.sh/Homebrew-on-Linux
if test (uname) = "Linux" # Check if OS is Linux
    if test -d /home/linuxbrew/.linuxbrew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    end
end

# bootstrap installation of fisher
# see: https://github.com/jorgebucaran/fisher#bootstrap-installation
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# load 'thefuck' configurations
# see: https://github.com/nvbn/thefuck/wiki/Shell-aliases#fish
if type -q thefuck
    thefuck --alias | source
end

# load 'zoxide' configurations
# see: https://github.com/ajeetdsouza/zoxide
# if type -q zoxide
#     zoxide init fish | source
# end

# load starship prompt
# see: https://starship.rs
if type -q starship
	starship init fish | source
end

# Clear system messages (system copyright notice, the date
# and time of the last login, the message of the day, etc.).

clear

# start tmux upon executing fish
# see: https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332743061
# if status is-interactive
# and not set -q TMUX
#    exec tmux
# end


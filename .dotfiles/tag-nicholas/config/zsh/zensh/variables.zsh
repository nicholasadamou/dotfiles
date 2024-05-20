# Sets necessary PATH defaults
DEFAULT_PATHS=(
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/sbin"
    "/usr/sbin"
    "/usr/local/sbin"
    "$HOME/.local/bin"
    "$HOME/set-me-up"
    "$HOME/set-me-up/set-me-up-installer"
)

# Add each default path to PATH
for path in "${DEFAULT_PATHS[@]}"; do
    if [ -d "$path" ]; then
        export PATH="$PATH:$path"
    fi
done

# Check if we are on Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    LINUX_PATHS=(
        "/home/linuxbrew/.linuxbrew/bin"
        "/snap/bin"
    )

    # Add each Linux-specific path to PATH
    for path in "${LINUX_PATHS[@]}"; do
        if [ -d "$path" ]; then
            export PATH="$PATH:$path"
        fi
    done
fi

# Ruby configurations
# Adds "GEMS_PATH" to "$PATH"
# Fixes "I INSTALLED GEMS WITH --user-install AND THEIR COMMANDS ARE NOT AVAILABLE"
# see: https://guides.rubygems.org/faqs/#user-install

if command -v gem &>/dev/null; then
    if [ -d "$(gem environment gemdir)/bin" ]; then
        export PATH="$(gem environment gemdir)/bin:$PATH"
    fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Dotfiles directory
export DOTFILES=$HOME/"set-me-up"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure Neovim as default editor
export EDITOR="nvim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Prefer US English and use UTF-8 encoding.

export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make Python use UTF-8 encoding for output to stdin/stdout/stderr.

export PYTHONIOENCODING="UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't clear the screen after quitting a `man` page.

export MANPAGER="less -X"

#!/bin/bash

source "$HOME/set-me-up/dotfiles/utilities/utilities.sh"

ask_for_sudo

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Restart spotlight
killall mds >/dev/null 2>&1

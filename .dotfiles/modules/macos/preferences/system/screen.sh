#!/bin/bash

# Customize Screenshot Settings in macOS:

# Change the Default Save Location for Screenshots to the Downloads Folder
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
# This command sets the default location where new screenshots are saved.
# `location` is the key that specifies the save directory for screenshots.
# `-string "${HOME}/Downloads"` sets this location to the Downloads folder in the current user's home directory.

# Set the Default Screenshot Format to PNG
defaults write com.apple.screencapture type -string "png"
# Changes the file format for new screenshots.
# `type` is the key that determines the format of the screenshot.
# `-string "png"` sets the format to PNG. Other options include BMP, GIF, JPG, PDF, and TIFF.

# Disable the Drop Shadow in Screenshots
defaults write com.apple.screencapture disable-shadow -bool true
# Removes the shadow effect that macOS typically adds to screenshots.
# `disable-shadow` is the key for enabling or disabling the shadow.
# `-bool true` disables the shadow, resulting in screenshots without the additional border effect.

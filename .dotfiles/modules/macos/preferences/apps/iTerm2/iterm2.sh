#!/bin/bash

# Disable the Quit Confirmation Prompt in iTerm2:
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
# This command changes a setting in iTerm2, a terminal emulator for macOS.
# `com.googlecode.iterm2` specifies the domain for the iTerm2 application.
# `PromptOnQuit` is the key that controls whether iTerm2 shows a confirmation prompt when attempting to quit the application.
# `-bool false` sets this key to false, meaning iTerm2 will not ask for confirmation when the user tries to quit the application, allowing for immediate closure of the program.
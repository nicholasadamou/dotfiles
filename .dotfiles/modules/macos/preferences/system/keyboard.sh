#!/bin/bash

# Enhance Keyboard Behavior and Disable Auto-Correct in macOS:

# Disable Press-and-Hold for Keys in Favor of Key Repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# This command turns off the press-and-hold feature for keys, which otherwise allows holding down a key to access accented characters or alternate characters. Setting this to false enables the traditional key repeat behavior, where holding down a key repeats the character.

# Set Fast Keyboard Repeat Rate and Decrease the Delay Before Repetition Starts
defaults write NSGlobalDomain InitialKeyRepeat -int 20
defaults write NSGlobalDomain KeyRepeat -int 1
# These commands speed up the keyboard's key repeat rate and reduce the initial delay before a key starts repeating when held down.
# `InitialKeyRepeat -int 20` sets the initial delay before a key starts repeating. A lower number means a shorter delay. The value 20 is relatively fast.
# `KeyRepeat -int 1` sets how quickly keys repeat once they start. A lower number means faster repetition. The value 1 is the fastest setting available.

# Disable Auto-Correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disables the automatic spelling correction feature in macOS. This can be particularly useful for users who frequently type technical terms, code, or use languages not well-supported by auto-correct.

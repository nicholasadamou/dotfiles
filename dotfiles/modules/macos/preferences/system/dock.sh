#!/bin/bash

# Customize Dock Appearance and Behavior in macOS:

# Set the Icon Size of Dock Items
defaults write com.apple.dock tilesize -int 30
# This command sets the size of the icons in the Dock.
# `com.apple.dock` is the domain associated with the macOS Dock.
# `tilesize` is the key for the size of the Dock icons.
# `-int 30` sets the icon size to 30 pixels, which adjusts how large or small the icons will appear in the Dock.

# Speed Up Mission Control Animations
defaults write com.apple.dock expose-animation-duration -float 0.15
# This command adjusts the speed of the Mission Control animations.
# `expose-animation-duration` is the key that controls the animation duration for Mission Control.
# `-float 0.15` sets the animation duration to 0.15 seconds, speeding up the transition effect when entering and exiting Mission Control.

# Make Dock Icons of Hidden Applications Translucent
defaults write com.apple.dock showhidden -bool true
# This command changes the appearance of icons in the Dock for hidden applications.
# `showhidden` is the key that controls the visibility of hidden application icons.
# `-bool true` makes the icons of applications that are hidden (minimized or not in the current workspace) translucent. This provides a visual cue to distinguish between active and hidden applications.

# Enable the 'reduce transparency' option. Save GPU cycles.
# defaults write com.apple.universalaccess reduceTransparency -bool true
# The above causes:
# 2021-11-13 16:29:36.657 defaults[52336:117358] Could not write domain com.apple.universalaccess; exiting

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Bottom right screen corner → Mission Control
#defaults write com.apple.dock wvous-br-corner -int 2
#defaults write com.apple.dock wvous-br-modifier -int 0

# Top right screen corner → Put display to sleep
# defaults write com.apple.dock wvous-tr-corner -int 10
# defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Desktop
# defaults write com.apple.dock wvous-bl-corner -int 4
# defaults write com.apple.dock wvous-bl-modifier -int 0

killall "Dock" &> /dev/null

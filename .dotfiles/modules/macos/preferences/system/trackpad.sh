#!/bin/bash

# Configure Trackpad Preferences for Haptic Feedback and Right-Click Behavior:

# Set Trackpad Haptic Feedback to Light and Silent Clicking
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0
# These commands adjust the haptic feedback settings of the MacBook's trackpad.
# `FirstClickThreshold -int 0` sets the threshold for the initial click to the lightest possible, requiring minimal pressure.
# `ActuationStrength -int 0` sets the actuation (click) strength to the lowest level, resulting in silent or very soft clicks.

# Map Bottom Right Corner of Trackpad to Right-Click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write NSGlobalDomain ContextMenuGesture -int 1
# These commands enable and configure a secondary (right) click when tapping the bottom right corner of the trackpad.
# `TrackpadRightClick -bool true` enables the right-click functionality on the trackpad.
# `TrackpadCornerSecondaryClick -int 2` maps the bottom right corner of the trackpad to function as a right-click.
# `ContextMenuGesture -int 1` enables the gesture for accessing context menus, commonly associated with right-clicking.

# Note: A system restart is required for these changes to take effect.

#!/bin/bash

# Disable Automatic Opening of Image Capture on Device Connection:
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# This command configures the behavior of the Image Capture application on macOS specific to the current host (i.e., the current machine).
# `defaults -currentHost write` is used to modify preferences for the current host/machine.
# `com.apple.ImageCapture` specifies the domain for the Image Capture application.
# `disableHotPlug` is the key that controls whether Image Capture opens automatically when a device (like a camera or iOS device) is connected.
# `-bool true` sets this key to true, meaning Image Capture will not automatically open when a device is plugged into the computer.

# Note: This change affects how macOS responds to connecting devices capable of importing photos or scans, and it is applied specifically to the machine you are currently using.

killall "Photos" &> /dev/null

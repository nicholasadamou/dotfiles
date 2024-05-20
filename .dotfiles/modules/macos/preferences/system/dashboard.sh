#!/bin/bash

# Disable the Dashboard Feature in macOS:

defaults write com.apple.dashboard mcx-disabled -bool true
# This command is used to disable the Dashboard feature in macOS.
# `com.apple.dashboard` specifies the domain for the Dashboard application.
# `mcx-disabled` is the key that controls the enabling or disabling of the Dashboard.
# `-bool true` sets this key to true, effectively disabling the Dashboard feature.
# Dashboard is a feature that provides access to mini applications known as widgets (like weather, calculator, etc.), and this setting turns it off.

# `killall Dashboard` doesn't actually do anything. To apply the
# changes for `Dashboard`, `killall Dock` is enough as `Dock` is
# `Dashboard`'s parent process.

killall "Dock" &> /dev/null

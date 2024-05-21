#!/bin/bash

# The following commands are used to modify preferences related to the App Store and Software Update services on macOS using the `defaults` command:

# 1. Enable Debug Menu in the App Store:
# defaults write com.apple.appstore ShowDebugMenu -bool true
# This command enables the Debug Menu in the macOS App Store application.
# `com.apple.appstore` specifies the domain for the App Store application.
# `ShowDebugMenu` is the key for enabling the Debug Menu.
# `-bool true` sets this key to true, making the Debug Menu visible in the App Store application.

# 2. Enable Automatic Updates for Apps:
defaults write com.apple.commerce AutoUpdate -bool true
# This command turns on automatic updates for apps downloaded from the App Store.
# `com.apple.commerce` is the domain associated with the App Store's commerce functions.
# `AutoUpdate` is the key for controlling automatic updates of apps.
# `-bool true` sets this feature to be enabled.

# 3. Enable Automatic Checking for Software Updates:
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# This command enables the system to automatically check for software updates.
# `com.apple.SoftwareUpdate` specifies the domain for the Software Update service.
# `AutomaticCheckEnabled` is the key for enabling the automatic checking for updates.
# `-bool true` turns this setting on.

# 4. Enable Automatic Download of Software Updates:
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# This command allows macOS to automatically download available software updates.
# `AutomaticDownload` is the key that controls the automatic download of updates.
# `-int 1` sets this feature to be enabled (integer value 1 represents true in this context).

# 5. Enable Automatic Installation of Critical Updates:
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
# This command enables the automatic installation of critical updates for macOS.
# `CriticalUpdateInstall` is the key for controlling the automatic installation of critical updates.
# `-int 1` enables this setting, allowing critical updates to be installed automatically.

# Note: These changes may affect the behavior of the App Store and Software Update services and might require a system restart to take full effect.

killall "App Store" &>/dev/null

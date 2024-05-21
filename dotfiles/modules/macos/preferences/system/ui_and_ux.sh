#!/bin/bash

declare -r DESKTOP_WALLPAPER_PATH="${PWD}/system/wallpapers/magma.jpg"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if brew info wallpaper &>/dev/null; then
    wallpaper set "$DESKTOP_WALLPAPER_PATH"
fi

# Customize System Preferences and Behaviors in macOS:

# Disable Smart Quotes for Better Coding Experience
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disables the automatic conversion of straight quotes to smart quotes, which can interfere with coding.

# Disable Smart Dashes for Better Coding Experience
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disables the automatic conversion of hyphens to en/em dashes, which is not desired in coding environments.

# Expand Save Panel by Default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Configures the save panel to be expanded by default, showing all options immediately when saving files.

# Expand Print Panel by Default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Ensures the print panel is expanded by default, providing immediate access to all print options.

# Save to Disk by Default Instead of iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Changes the default save location for new documents from iCloud to the local disk.

# Automatically Quit Printer App After Print Jobs Complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Configures the printing preferences to automatically close the printer application once printing is complete.

# Change the Mac's Host Name
model=$(system_profiler SPHardwareDataType | grep "Model Name" | awk -F": " '{print $2}') # Get Mac model information
HOST_NAME="Nicholas's $model"                                                             # E.g., 'Nicholas's MacBook Pro' or 'Nicholas's iMac'
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${HOST_NAME}" &&
    sudo scutil --set ComputerName "${HOST_NAME}" &&
    sudo scutil --set HostName "${HOST_NAME}" &&
    sudo scutil --set LocalHostName "${HOST_NAME}"
# Sets the system's network names for various protocols to $HOST_NAME.

sudo systemsetup -setrestartfreeze on
# Enables automatic restarting if the computer freezes.

# Customize System UI Server Preferences
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    sudo defaults write "${domain}" dontAutoLoad -array \
        '/System/Library/CoreServices/Menu Extras/TimeMachine.menu' \
        '/System/Library/CoreServices/Menu Extras/Volume.menu'
done &&
    sudo defaults write com.apple.systemuiserver menuExtras -array \
        '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' \
        '/System/Library/CoreServices/Menu Extras/AirPort.menu' \
        '/System/Library/CoreServices/Menu Extras/Battery.menu' \
        '/System/Library/CoreServices/Menu Extras/Clock.menu'
# Customizes the items in the menu bar. It removes TimeMachine and Volume menus and adds Bluetooth, Airport (Wi-Fi), Battery, and Clock menus. This loop goes through all the domain files for the system UI server in the user's preferences.

killall "SystemUIServer" &>/dev/null

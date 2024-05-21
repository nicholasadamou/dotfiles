#!/bin/bash

# Customize Finder Preferences and Views on macOS:

# Set Documents as the Default Location for New Finder Windows
defaults write com.apple.finder NewWindowTarget -string "PfDo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"
# Configures Finder to open new windows with the Desktop as the default view.
# `NewWindowTarget` - "PfDo" sets Documents as the target for new windows.
# `NewWindowTargetPath` specifies the path to the Desktop using an environment variable for the user's home directory.

# Show Icons for Various Drives on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Enables the display of icons for external hard drives, internal hard drives, mounted servers, and removable media on the desktop.

# (Commented Out) Finder: Show Hidden Files by Default
# defaults write com.apple.finder AppleShowAllFiles -bool true
# This commented command, if executed, would make Finder show all hidden files.

# Finder: Show All Filename Extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Ensures that file extensions are shown for all files in Finder.

# Finder: Show Status Bar
defaults write com.apple.finder ShowStatusBar -bool true
# Enables the status bar in Finder windows.

# Finder: Allow Text Selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Enables the ability to select and copy text while using Quick Look in Finder.

# Display Full POSIX Path as Finder Window Title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Configures Finder to show the full POSIX path (directory path) in the window title.

# Set Default Search Scope to Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Sets the default search scope in Finder to the current folder.

# Disable Warning When Changing a File Extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Turns off the warning that appears when changing a file's extension in Finder.

# Enable Spring Loading for Directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# Activates spring loading for directories in Finder, allowing users to drag items onto folders and have them spring open.

# Reduce Spring Loading Delay for Directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.1
# Sets the delay for spring-loaded folders to a short time (0.1 seconds), for quicker access.

# Avoid Creating .DS_Store Files on Network Volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Prevents Finder from creating .DS_Store files on network drives, which store custom attributes of a folder.

# Enable Snap-to-Grid for Icons
# The following commands use PlistBuddy to modify Finder's preferences file directly.
# They set icon arrangement to a grid layout on the desktop and in other icon views.
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set the Size of Icons
# These commands set the icon size to 64x64 pixels on the desktop and in other icon views.
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# Use Column View in All Finder Windows by Default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Sets Finder to use column view as the default for all windows.

# Show the ~/Library Folder
chflags nohidden ~/Library
# Unhides the user's Library folder, which is hidden by default in macOS.

killall "Finder" &>/dev/null

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
#
# https://github.com/alrra/dotfiles/commit/035dda057ddc6013ba21db3d2c30eeb51ba8f200

killall "cfprefsd" &>/dev/null

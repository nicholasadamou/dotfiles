#!/bin/bash

# Enable Swipe Navigation with Scroll Gesture in Chrome:
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool true
# This command enables the swipe navigation feature in Google Chrome on macOS. 
# `com.google.Chrome` specifies the domain for the Chrome application.
# `AppleEnableSwipeNavigateWithScrolls` is the key controlling swipe navigation with scroll gestures.
# `-bool true` enables this feature, allowing users to navigate (back and forward) in their browsing history using swipe gestures on a trackpad or magic mouse.

# Expand Print Dialog by Default in Chrome's Print Preview:
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
# This command sets the print dialog in Google Chrome to be expanded by default.
# `PMPrintingExpandedStateForPrint2` is the key that controls the state of the print dialog in Chrome's print preview.
# `-bool true` ensures that the print options are fully expanded when the print dialog is first opened.

# Disable Print Preview in Chrome:
defaults write com.google.Chrome DisablePrintPreview -bool true
# This command disables the print preview feature in Google Chrome.
# `DisablePrintPreview` is the key for enabling or disabling the built-in print preview feature in Chrome.
# `-bool true` disables the print preview, meaning that when printing, Chrome will directly use the standard print dialog of macOS instead of showing its own print preview.

killall "Google Chrome" &> /dev/null

#!/bin/bash

# This command modifies a preference for the Firefox web browser on macOS using the `defaults` command:

# Disable Swipe Navigation with Scroll Gesture in Firefox:
defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool false
# This command disables the swipe navigation feature in Mozilla Firefox that is typically triggered by scroll gestures (such as two-finger swipe) on a trackpad or a magic mouse.
# `org.mozilla.firefox` specifies the domain for the Firefox application.
# `AppleEnableSwipeNavigateWithScrolls` is the key that controls the swipe navigation feature in conjunction with scroll gestures.
# `-bool false` sets this feature to be disabled, preventing Firefox from interpreting horizontal scroll gestures as navigation commands (like going back or forward in browser history).

# Note: This change affects how gesture-based navigation is handled in Firefox on macOS and might require restarting Firefox for the changes to take effect.

killall "firefox" &> /dev/null

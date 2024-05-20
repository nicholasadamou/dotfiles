#!/bin/bash

declare current_dir && \
    current_dir="$(dirname "${BASH_SOURCE[0]}")" && \
    cd "${current_dir}" || exit

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure Various Settings for macOS Terminal:
defaults write com.apple.terminal FocusFollowsMouse -string true
# Enable Focus Follows Mouse in Terminal.
# This command allows the Terminal window to gain focus (become active) when the mouse cursor is moved over it, without needing to click.
# `FocusFollowsMouse` is the key for this setting.
# `-string true` enables this behavior.

defaults write com.apple.terminal SecureKeyboardEntry -bool true
# Enable Secure Keyboard Entry in Terminal.
# This command activates a security feature that prevents other applications from detecting and recording keystrokes used in the Terminal.
# `SecureKeyboardEntry` is the key for enabling this security feature.
# `-bool true` turns on Secure Keyboard Entry.

defaults write com.apple.Terminal ShowLineMarks -int 0
# Disable Line Marks in Terminal.
# This command turns off the display of line marks (like line wrapping indicators) in the Terminal application.
# `ShowLineMarks` is the key for controlling the visibility of line marks.
# `-int 0` sets this feature to be disabled.

defaults write com.apple.terminal StringEncodings -array 4
# Set Default String Encoding in Terminal to UTF-8.
# This command configures the Terminal application to use UTF-8 encoding for displaying and interpreting text.
# `StringEncodings` is the key that specifies the list of encodings used by Terminal.
# `-array 4` sets the encoding to UTF-8, as 4 is the numerical representation of UTF-8 encoding in macOS.

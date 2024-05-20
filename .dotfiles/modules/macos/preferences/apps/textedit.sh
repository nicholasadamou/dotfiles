#!/bin/bash

# Set Default Encoding for TextEdit and Switch to Plain Text Mode:
defaults write com.apple.TextEdit PlainTextEncoding -int 4 && \
		defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
# These commands set the default text encoding for the TextEdit application on macOS.
# `PlainTextEncoding` and `PlainTextEncodingForWrite` are the keys for reading and writing text files, respectively.
# `-int 4` sets the encoding to UTF-8 (Unicode). This is specified by the integer 4, which corresponds to UTF-8 encoding in macOS.

defaults write com.apple.TextEdit RichText 0
# This command configures TextEdit to use plain text mode by default.
# `RichText` is the key that determines whether TextEdit uses rich text format (RTF) or plain text (TXT).
# `0` sets TextEdit to open and save documents in plain text mode, disabling rich text format.

killall "TextEdit" &> /dev/null

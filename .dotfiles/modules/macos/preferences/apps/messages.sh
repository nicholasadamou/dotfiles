#!/bin/bash

# Configure Text Editing Settings in Messages App:

# Disable Smart Quotes in Messages App
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
# This command adjusts the text input settings in the Messages application on macOS.
# `com.apple.messageshelper.MessageController` specifies the domain for the Messages app's message controller.
# `SOInputLineSettings` with `-dict-add` adds to the settings dictionary.
# `"automaticQuoteSubstitutionEnabled" -bool false` disables the automatic conversion of straight quotes into smart quotes (curly quotes). This is particularly useful for messages containing code snippets where smart quotes can lead to errors.

# Disable Continuous Spell Checking in Messages App
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
# Modifies the same dictionary in the Messages application to alter spell checking behavior.
# `"continuousSpellCheckingEnabled" -bool false` turns off continuous spell checking in the input field of the Messages app. This can be useful when typing technical terms or code that are not recognized by the standard spell checker.

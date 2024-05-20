#!/bin/bash

# The following commands are used to modify global system preferences on macOS using the `defaults` command:

# 1. Set the System Language Preference:
defaults write -g AppleLanguages -array 'en_US'
# This command sets the primary language for the system and applications to English (United States). 
# `-g` specifies that the setting is global (applies to all applications).
# `AppleLanguages` is the key for the language setting.
# `-array 'en_US'` sets the value of this key to an array containing a single element 'en_US', representing English (United States).

# 2. Set the Measurement Units Preference:
defaults write -g AppleMeasurementUnits -string 'Inches'
# This command sets the default measurement units to Inches across the system.
# `AppleMeasurementUnits` is the key for setting measurement units.
# `-string 'Inches'` specifies the desired unit of measurement as a string, in this case, 'Inches'.

# 3. Disable Automatic Spelling Correction:
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# This command disables the automatic spelling correction feature in macOS.
# `NSAutomaticSpellingCorrectionEnabled` is the key that controls the automatic spelling correction feature.
# `-bool false` sets this feature to be disabled (false).

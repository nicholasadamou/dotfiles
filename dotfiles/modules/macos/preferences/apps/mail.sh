#!/bin/bash

# Change Format for Copying Email Addresses in Mail.app:
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
# This command configures how email addresses are copied from the Mail application on macOS.
# `com.apple.mail` specifies the domain for the Mail application.
# `AddressesIncludeNameOnPasteboard` is the key that controls the format of copied email addresses.
# `-bool false` sets this key to false, which means that when email addresses are copied, they will be copied as 'foo@example.com' only, without the associated contact name (e.g., 'Foo Bar <foo@example.com>'). This simplifies the process of copying and sharing email addresses by providing only the essential email information.

#!/bin/bash

# Modify Various Settings for Safari Browser:
defaults write com.apple.Safari UniversalSearchEnabled -bool false \
    && defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# Disable Universal Search and Suppress Search Suggestions in Safari.
# UniversalSearchEnabled - bool false: Disables the feature that integrates search suggestions, bookmarks, and browsing history in the Smart Search field.
# SuppressSearchSuggestions - bool true: Prevents Safari from showing search suggestions in the search and address bar.

defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
# Enable Do Not Track HTTP Header.
# Instructs Safari to send a 'Do Not Track' request to websites to express a preference not to be tracked.

defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Disable Automatic Opening of 'Safe' Downloads.
# Prevents Safari from automatically opening downloaded files deemed 'safe.'

defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
# Enable Backspace Key to Navigate Back in Safari.
# Allows the use of the backspace key (or delete key on some keyboards) to navigate to the previous page.

defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
		defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
		defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# Enable Safari's Developer Menu and Developer Extras.
# Activates various developer options in Safari, including the Developer menu in the menu bar.

defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
# Change 'Find on Page' to Match Text Anywhere in Words.
# Alters the behavior of the Find feature to match the searched text anywhere in words, not just at the beginning.

defaults write com.apple.Safari HomePage -string 'about:blank'
# Set Safari's Homepage to 'about:blank'.
# This sets a blank page as Safari's homepage.

defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# Enable Safari's Internal Debug Menu.
# Unlocks additional debugging options within Safari.

defaults write com.apple.Safari ShowFavoritesBar -bool false
# Hide the Favorites Bar in Safari.
# This removes the bar displaying favorite websites.

defaults write com.apple.Safari ShowSidebarInTopSites -bool false
# Disable Sidebar in the Top Sites View.
# Prevents the sidebar from appearing in the Top Sites view.

defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true \
    && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
# Enable Tab Key to Navigate Links in Web Pages.
# Allows using the Tab key to jump between links on a webpage.

defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Show the Full URL in Safari's Smart Search Field.
# Configures Safari to display the entire URL in the address bar.

defaults write com.apple.Safari ProxiesInBookmarksBar "()"
# Clear Proxies in Safari's Bookmarks Bar.
# Removes any proxy items that might be present in the bookmarks bar.

defaults write com.apple.Safari WebKitDeveloperExtras -bool true
# Globally Enable WebKit Developer Extras.
# Activates developer options across all WebKit-based applications.

defaults write com.apple.Safari AutoFillFromAddressBook -bool false \
    && defaults write com.apple.Safari AutoFillPasswords -bool false \
    && defaults write com.apple.Safari AutoFillCreditCardData -bool false \
    && defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
# Disable Various AutoFill Features in Safari.
# Turns off AutoFill for the address book, passwords, credit card data, and other forms.

defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Enable Continuous Spell Checking in Safari.
# Activates real-time spell checking in text fields within Safari.

defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
# Disable Automatic Spelling Correction in Safari.
# Prevents Safari from automatically correcting spelling in text fields.

defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
# Enable Fraudulent Website Warnings in Safari.
# Turns on warnings for potentially fraudulent or malicious websites.

defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false \
    && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
# Disable JavaScript from Opening Windows Automatically.
# Prevents JavaScript from opening new windows or tabs without user interaction.

defaults write com.apple.Safari WebKitJavaEnabled -bool false \
    && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
# Disable Java in Safari.
# Turns off Java support in Safari for security and performance reasons.

defaults write com.apple.Safari WebKitPluginsEnabled -bool false \
    && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
# Disable All Plugins in Safari.
# Prevents plugins (like Flash) from running in Safari, enhancing security and performance.

defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
# Enable Automatic Updates for Safari Extensions.
# Configures Safari to automatically update installed extensions.

killall "Safari" &> /dev/null

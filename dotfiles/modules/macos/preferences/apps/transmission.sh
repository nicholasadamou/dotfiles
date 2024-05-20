#!/bin/bash

# The following commands are used to modify preferences for the Transmission BitTorrent client on macOS using the `defaults` command:

# 1. Delete Original Torrent File After Adding:
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
# This command configures Transmission to automatically delete the original .torrent file after it is added to the client.
# `DeleteOriginalTorrent` is the key for this setting.
# `-bool true` enables this behavior.

# 2. Disable Prompt on Adding Downloads:
defaults write org.m0k.transmission DownloadAsk -bool false
# This command disables the confirmation dialog when adding new downloads.
# `DownloadAsk` is the key that controls the download confirmation prompt.
# `-bool false` turns off this prompt.

# 3. Disable Prompt on Opening Magnet Links:
defaults write org.m0k.transmission MagnetOpenAsk -bool false
# `defaults write org.m0k.transmission MagnetOpenAsk -bool false`
# This command disables the confirmation dialog when opening magnet links.
# `MagnetOpenAsk` is the key for controlling the magnet link confirmation.
# `-bool false` disables this confirmation dialog.

# 4. Enable Check for Removing Downloading Torrents:
defaults write org.m0k.transmission CheckRemoveDownloading -bool true
# This command enables a warning prompt when attempting to remove torrents that are currently downloading.
# `CheckRemoveDownloading` is the key for this setting.
# `-bool true` activates this warning prompt.

# 5. Set Download Location:
defaults write org.m0k.transmission DownloadChoice -string 'Constant' && \
		defaults write org.m0k.transmission DownloadFolder -string "$HOME/Downloads"
# These commands set a constant download location for all downloads in Transmission.
# `DownloadChoice` set to 'Constant' means the download location will be the same for all files.
# `DownloadFolder` specifies the path to the download directory, here set to the Downloads folder in the user's home directory.

# 6. Use and Set Incomplete Download Folder:
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true && \
		defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/torrents"
# These commands enable and set a specific folder for incomplete downloads.
# `UseIncompleteDownloadFolder` enables the use of a separate folder for incomplete files.
# `IncompleteDownloadFolder` sets the path to the folder for incomplete downloads, here within a 'torrents' subfolder in the Downloads directory.

# 7. Disable Donation Prompt:
defaults write org.m0k.transmission WarningDonate -bool false
# This command turns off the prompt asking for donations in Transmission.
# `WarningDonate` is the key for controlling the donation prompt.
# `-bool false` disables this prompt.

# 8. Disable Legal Warning on Startup:
defaults write org.m0k.transmission WarningLegal -bool false
# This command disables the legal warning displayed when Transmission starts.
# `WarningLegal` is the key for the startup legal warning.
# `-bool false` turns off this warning.

# 9. Enable Random Port Selection on Startup:
defaults write org.m0k.transmission RandomPort -bool true
# This command enables the use of a random port each time Transmission starts, which can help with connection issues.
# `RandomPort` is the key for randomizing the port.
# `-bool true` enables the selection of a random port on startup.

# Note: Changes made with these commands customize the behavior of the Transmission application and may require restarting the application to take effect.

killall "Transmission" &> /dev/null

#!/bin/bash

# Configure Initial Display Settings for Activity Monitor:
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# This command sets Activity Monitor to open its main window automatically upon launching the application.
# `com.apple.ActivityMonitor` specifies the domain for the Activity Monitor application.
# `OpenMainWindow` is the key that controls whether the main window is shown when the application starts.
# `-bool true` ensures that the main window of Activity Monitor is open by default when the application is launched.

defaults write com.apple.ActivityMonitor ShowCategory -int 0
# This command configures Activity Monitor to show all processes by default.
# `ShowCategory` is the key that determines which category of processes is displayed.
# `-int 0` sets the application to show all processes, regardless of user, system processes, or active processes. The integer 0 corresponds to the "All Processes" category in Activity Monitor.
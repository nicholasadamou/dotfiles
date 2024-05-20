#!/bin/bash

# Configure Default View Options for Apple Maps:
defaults write com.apple.Maps LastClosedWindowViewOptions '{
            localizeLabels = 1;   // show labels in English
            mapType = 11;         // show hybrid map
            trafficEnabled = 0;   // do not show traffic
		}'
# This command sets the default view options for the Apple Maps application on macOS.
# `com.apple.Maps` specifies the domain for the Apple Maps application.
# `LastClosedWindowViewOptions` is the key that stores the settings for the last closed window state in Apple Maps.

# Inside the dictionary:
# `localizeLabels = 1;` sets the map to display labels in English. A value of 1 enables label localization (show labels in the system's language, which is assumed to be English in this context).
# `mapType = 11;` sets the default map type to hybrid. The value 11 corresponds to the hybrid map view, which combines the standard map with satellite imagery.
# `trafficEnabled = 0;` disables the display of traffic information on the map. A value of 0 means that traffic data will not be shown.

# Note: This command customizes the initial state of the Apple Maps application, affecting how the map is presented when the application is opened.

killall "Maps" &> /dev/null

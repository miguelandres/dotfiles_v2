#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Use list view in all Finder windows by default
# Four-letter codes for view modes: Icon `icnv`, Column `clmv`, Gallery `glyv`, List "Nlsv"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Start Screen Saver
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Show Application Windows
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

dockutil --remove all --no-restart
dockutil --add "/Applications/Google Chrome.app" --no-restart
dockutil --add "/Applications/Safari.app" --no-restart
dockutil --add "/System/Applications/Messages.app" --no-restart
dockutil --add "/Applications/Dashlane.app" --no-restart
dockutil --add "/System/Applications/Facetime.app" --no-restart
dockutil --add "/System/Applications/Calendar.app" --no-restart
dockutil --add "/System/Applications/Contacts.app" --no-restart
dockutil --add "/System/Applications/App Store.app" --no-restart
dockutil --add "/System/Applications/System Preferences.app" --no-restart
dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --no-restart
dockutil --add "/Applications/Utilities/Adobe Creative Cloud/ACC/Creative Cloud.app" --no-restart
dockutil --add "/Applications/Adobe Photoshop 2022/Adobe Photoshop 2022.app" --no-restart
dockutil --add "/Applications/Adobe Illustrator 2022/Adobe Illustrator.app" --no-restart
dockutil --add "/Applications/OBS.app" --no-restart

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
  "Address Book" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Mail" \
  "Messages" \
  "Safari" \
  "SystemUIServer"; do
  killall "${app}" &>/dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

#! /bin/sh

# compositor
compton & 
# wallpaper
nitrogen --restore &
# systray applets
nm-applet &
blueman-applet &
# notification service
deadd-notification-center &
# key remappings
xmodmap -e "keycode 135 = Super_L" &
xmodmap -e "remove mod1 = Super_L" &
# emacs
emacs --fg-daemon &
# screen lock
# xautolock -time 5 -locker "i3lock-fancy -- \"maim\""
# systemd services
systemctl --user start home-victor-PiDAV.mount &
systemctl --user start spotifyd &

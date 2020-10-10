#! /bin/sh

# compositor
picom &
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
# xautolock -time 5 -locker "i3lock-fancy -- \"maim\"" &
xscreensaver &
# systemd services
systemctl --user start spotifyd &
# wallpaper
nitrogen --restore &
nextcloud &

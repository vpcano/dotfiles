#! /bin/sh

xscreensaver -no-splash &
compton --config /home/victor/.config/compton.conf & 
nitrogen --restore &
systemctl --user start spotifyd.service &
nm-applet &
blueman-applet &
deadd-notification-center &
xmodmap -e "keycode 135 = Super_L" &
xmodmap -e "remove mod1 = Super_L" &

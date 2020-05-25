#! /bin/bash 
compton --config /home/victor/.config/compton.conf & 
wal -i /usr/share/backgrounds/52258.jpg &
nm-applet &
blueman-applet &
deadd-notification-center &
xmodmap -e "keycode 135 = Super_L" &
xmodmap -e "remove mod1 = Super_L" &

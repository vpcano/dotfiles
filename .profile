#!/bin/sh
#========================================================================
#                               ____ _  __        _    __  _   ______
#          ____   _____ ____   / __/(_)/ /___    | |  / / (_) / ____/
#         / __ \ / ___// __ \ / /_ / // // _ \   | | / / / / / /     
#    _   / /_/ // /   / /_/ // __// // //  __/   | |/ / / / / /___   
#   (_) / .___//_/    \____//_/  /_//_/ \___/    |___/ /_/  \____/   
#      /_/                                                                             
#
#	~/.profile file 
#	The Xsession script has been modified to search for xsession,
#	   xprofile, Xresources, Xkbmap, Xmodmap, and Xauthority in
#	   ~/.config/xconfig/ (set to $X_CONFIG_DIR) apart from $HOME
#	   This .profile is the only file that remains in $HOME
#	Other settings and autostarted programs related to DE/WM are
#	   started from the correspondant script (ej. for qtile: 
#	   ~/.config/qtile/autostart.sh)
#	
#	Víctor Pérez Cano
#	GitHub: https://github.com/vpcano 
#
#========================================================================


# DEFAULT APPS AND PROGRAMS
export TERM=st
export BROWSER=waterfox-current
export EDITOR=nvim
export FM=ranger

# OTHER VARIABLES
export PATH=$PATH:$HOME/.local/bin/
export SUDO_ASKPASS=$HOME/.local/bin/daskpass

# KEEP HOME DIR CLEAN
export LESSHISTFILE=$HOME/.local/share/less/.lesshst
export HISTFILE=$XDG_CONFIG_HOME/bash/bash_history
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/config
rm $HOME/.xsession-errors* >>/dev/null 2>&1	# This can be done since Xsession output has been redirected to ~/.config/xconfig/xsession-log

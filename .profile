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
export FM=lf

# OTHER VARIABLES
export PATH=$PATH:$HOME/.local/bin/
export SUDO_ASKPASS=$HOME/.local/bin/daskpass

# KEEP HOME DIR CLEAN
export ZDOTDIR=$XDG_CONFIG_HOME/shell/zsh
export POWERLEVEL9K_INSTALLATION_DIR=$ZDOTDIR/plugins/powerlevel10k
export LESSHISTFILE=$HOME/.local/share/less/.lesshst
export HISTFILE=$XDG_CONFIG_HOME/shell/histfile
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/config
rm $HOME/.xsession-errors* >>/dev/null 2>&1	# This can be done since Xsession output has been redirected to ~/.config/xconfig/xsession-log

# LF COLORS
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

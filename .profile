# vim: set ft=sh:
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


# KEEP HOME DIR CLEAN
[ -z $XDG_CONFIG_HOME ] && export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export POWERLEVEL9K_INSTALLATION_DIR=$ZDOTDIR/plugins/powerlevel10k

if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
	[[ ! $(hwinfo | grep DP-4) ]] && export GDK_DPI_SCALE=1.5
fi

# DEFAULT APPS AND PROGRAMS
if [[ $XDG_SESSION_TYPE == "tty" ]]; then
    export EDITOR="nvim"
    cp $ZDOTDIR/prompts/nounicode.zsh-theme $ZDOTDIR/prompt.zsh-theme	# Set nounicode prompt when using tty
else
    export TERM=kitty
    export BROWSER=google-chrome-stable
    export EDITOR=nvim
fi

# SSH AGENT (using gpg-agent via systemd user unit instead of usual ssh-agent)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# OTHER VARIABLES
export PATH=$PATH:$HOME/.local/bin/:$HOME/.dotnet/tools/

# Flutter
export FLUTTER_GIT_URL="git@github.com:/flutter/flutter.git"
export CHROME_EXECUTABLE="google-chrome-stable"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

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

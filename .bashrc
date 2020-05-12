#===========================================================
#       ____                __       _    __  _   ______
#      / __ ) ____ _ _____ / /_     | |  / / (_) / ____/
#     / __  |/ __ `// ___// __ \    | | / / / / / /     
#    / /_/ // /_/ /(__  )/ / / /    | |/ / / / / /___   
#   /_____/ \__,_//____//_/ /_/     |___/ /_/  \____/   
#
#	~/.bashrc file 
#	
#	Víctor Pérez Cano
#	GitHub: https://github.com/vpcano 
#
#===========================================================

EDITOR="vim"
export TERM="alacritty"

alias ls='exa -l'
alias la='ls -a'
alias grep='grep --color=auto'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

[[ $- != *i* ]] && return


##  CHANGE WINDOW TITLE  ##
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*|alacritty)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

##  COLOURFUL PS1  ##
#if [[ ${EUID} == 0 ]] ; then
#	PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
#else
#	PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
#fi

##  POWERLINE  ##
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh


##  EXTRACT COMMAND  ##
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

##  SWAP TWO FILENAMES  ##
swap() {
	local TMPFILE=tmp.$$

        [[ $# -ne 2 ]] && echo "swap: 2 arguments needed" && return 1
        [[ ! -e $1 ]] && echo "swap: $1 does not exist" && return 1
        [[ ! -e $2 ]] && echo "swap: $2 does not exist" && return 1

        mv "$1" $TMPFILE
        mv "$2" "$1"
        mv $TMPFILE "$2"
}

##  CHANGE DIRECTORY AND LIST  ##
function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls; }; }

neofetch



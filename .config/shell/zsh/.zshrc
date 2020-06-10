#==================================================
#    _____          __       _    __ _  ______
#   /__  /   _____ / /_     | |  / /(_)/ ____/
#     / /   / ___// __ \    | | / // // /     
#    / /__ (__  )/ / / /    | |/ // // /___   
#   /____//____//_/ /_/     |___//_/ \____/   
#
#	~/.zshrc file
#
#	Víctor Pérez Cano
#	GitHub: https://github.com/vpcano
#
#==================================================


##  SOME SETTINGS  ##
[[ $- != *i* ]] && return
# Colors
autoload -U colors && colors
# Completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# History
HISTSIZE=1000
SAVEHIST=1000

##  LEFT AND RIGHT PROMPTS  ##
function update-prompts {
  # if [[ $TERM == *"st"* ]] || [[ $TERM == *"alacritty"* ]]; then
	# Powerline themed prompt (requires special fonts)
  	RPS1="[$2$1%{$reset_color%}]-[%D{%H:%M}]"
	# source $ZDOTDIR/plugins/powerline.zsh-theme
  # else
	# Simple prompt (no unicode characters, useful for tty or ssh)
          # RPS1="[%D{%H:%M}]"
	PS1=" %{$fg_bold[red]%}[%{$fg_bold[yellow]%}${USER}%{$fg_bold[magenta]%}@%{$fg_bold[blue]%}%m%{$fg_bold[red]%}]%{$reset_color%}-%{$fg_bold[red]%}[%{$fg[cyan]%}%(4~|%-2~/…/%1~|%4~)%{$fg_bold[red]%}] $2=>%{$reset_color%} "
  # fi
}

##  VIM MODE  ##
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    	echo -ne '\e[1 q' 	# Change cursor shape for different vi modes.
	VIMODE_STRING="--NORMAL--"
	VIMODE_COLOR="%{$fg_bold[blue]%}"
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    	echo -ne '\e[5 q' 	# Change cursor shape for different vi modes.
	VIMODE_STRING="--INSERT--"
	VIMODE_COLOR="%{$fg_bold[green]%}"
  fi
  # Update prompts
  update-prompts $VIMODE_STRING $VIMODE_COLOR
  zle reset-prompt
  zle -R
}
function zle-line-init {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
    VIMODE_STRING="--INSERT--"
    VIMODE_COLOR="%{$fg_bold[green]%}"
    update-prompts $VIMODE_STRING $VIMODE_COLOR
    zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
precmd() { 
    VIMODE_STRING="--INSERT--"
    VIMODE_COLOR="%{$fg_bold[green]%}"
    update-prompts $VIMODE_STRING $VIMODE_COLOR
}

##  PLUGINS  ##
source $ZDOTDIR/plugins/git.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Colorls
source $(dirname $(gem which colorls))/tab_complete.sh

# Ctrl+Space to accept suggestion
bindkey '^ ' autosuggest-accept

##  ALIAS  ##
source $HOME/.aliasrc

##  SOME FUNCTIONS  ##
# Change dir and list
function cd() { builtin cd -- "$@" && { [ "$PS1" = "" ] || ls; }; }
# Change to the last directory before lf was closed
function lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
# Search with fzf and edit with $EDITOR
function efzf() {
	$EDITOR $(find -maxdepth 4 | fzf --header "Edit with "$EDITOR" "$@"")
}

##  AUTOSTART  ##
if ! [[ $TERM == *"xterm"* ]]; then 	# For not displaying vicfetch on vim terminal
	vicfetch
fi

###################################################
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
###################################################


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
# Colorls
source $(dirname $(gem which colorls))/tab_complete.sh


##  PLUGINS  ##
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/git.plugin.zsh


##  FUNCTIONS  ##
fpath=($fpath $ZDOTDIR/functions)
autoload cd
autoload lfcd
autoload select-prompt
function update-prompts() {}	# Sourcing prompt file will override this function. It is defined to avoid errors.


##  ALIAS  ##
source $HOME/.aliasrc


##  AUTOSTART  ##
if ! [[ $(neofetch | grep -m 1 Terminal) == *"vim"* || $(neofetch | grep -m 1 Terminal) == *"vscode"* ]]; then 	# For not displaying vicfetch on vim terminal
	vicfetch
fi
if ! [ -e $ZDOTDIR/prompt.zsh-theme ]; then
	select-prompt
fi


##  PROMPT ##
source $ZDOTDIR/prompt.zsh-theme


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

bindkey '^ ' autosuggest-accept 	# Ctrl+Space to accept suggestion

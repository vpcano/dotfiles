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

[[ $XDG_SESSION_TYPE == "tty" ]] && source $HOME/.profile

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

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'preview $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0


##  PLUGINS  ##
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/git.plugin.zsh
source $ZDOTDIR/plugins/sudo.plugin.zsh


##  FUNCTIONS  ##
fpath=($fpath $ZDOTDIR/functions)
autoload cd
autoload lfcd
autoload select-prompt
function update-prompts() {}	# Sourcing prompt file will override this function. It is defined to avoid errors.

##  ALIAS  ##
source $HOME/.aliasrc


##  AUTOSTART  ##
if [[ $VSC_SHELL_MESSAGE != "no" ]]; then
  echo ""
  pfetch
fi
if ! [ -e $ZDOTDIR/prompt.zsh-theme ]; then
	select-prompt
fi


##  PROMPT ##
if [[ $XDG_SESSION_TYPE == "tty" ]]; then
  source $ZDOTDIR/prompts/nounicode.zsh-theme
elif [[ $VSC_SHELL_PROMPT == "simple" ]]; then
  source $ZDOTDIR/prompts/single-lambda.zsh-theme
else
  source $ZDOTDIR/prompt.zsh-theme
fi


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

ffzf () {
    pipe=" | fzf"
    RBUFFER=${pipe}${RBUFFER}
}
zle -N ffzf

bindkey '^ ' autosuggest-accept 	# Ctrl+Space to accept suggestion
bindkey '^a' sudo-command-line
bindkey '^f' ffzf

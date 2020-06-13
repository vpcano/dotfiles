# vim: set ft=zsh:
unfunction update-prompts
function update-prompts {
  	RPS1="[$2$1%{$reset_color%}]-[%D{%H:%M}]"
	PS1=" %{$fg_bold[red]%}[%{$fg_bold[yellow]%}${USER}%{$fg_bold[magenta]%}@%{$fg_bold[blue]%}%m%{$fg_bold[red]%}]%{$reset_color%}-%{$fg_bold[red]%}[%{$fg[cyan]%}%(4~|%-2~/…/%1~|%4~)%{$fg_bold[red]%}] $2=>%{$reset_color%} "
}

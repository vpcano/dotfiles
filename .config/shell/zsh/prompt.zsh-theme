# vim: set ft=zsh:
unfunction update-prompts
dist=$(lsb_release -a | grep Description | cut -d ":" -f 2)
term=$(neofetch | grep -m 1 Terminal | cut -d ":" -f 2)
function update-prompts {
	case "$dist" in
		*"Manjaro"*) icon="%{$fg[green]%} ";;
		*"Arch"*) icon="%{$fg[blue]%} ";;
		*"Ubuntu"*) icon="%{$fg[yellow]%} ";;
		*"Debian"*) icon="%{$fg[magenta]%} ";;
		*"Fedora"*) icon="%{$fg[blue]%} ";;
		*"Raspbian"*) icon="%{$fg[magenta]%} ";;
		*) icon="%{$fg[yellow]%} ";;
	esac
	case "$term" in 
		*"vscode"*) icon="%{$fg[cyan]%}﬏ ";;
		*"vim"*) icon="%{$fg[green]%} ";;
	esac
	RPS1="[$2$1%{$reset_color%}]-[%{$fg[yellow]%} : $(cat /sys/class/power_supply/BAT0/capacity)%%%{$reset_color%}]-[ : %D{%H:%M}]"
	PS1=" $icon%{$fg_bold[red]%}[%{$fg_bold[yellow]%}${USER}%{$fg_bold[magenta]%}@%{$fg_bold[blue]%}%m%{$fg_bold[red]%}]%{$reset_color%}-%{$fg_bold[red]%}[%{$fg[cyan]%}ﱮ : %(4~|%-2~/…/%1~|%4~)%{$fg_bold[red]%}] $2=>%{$reset_color%} "
}

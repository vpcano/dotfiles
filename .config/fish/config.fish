#===========================================================
#      ______ _         __          _    __  _   ______
#     / ____/(_) _____ / /_        | |  / / (_) / ____/
#    / /_   / / / ___// __ \       | | / / / / / /     
#   / __/  / / (__  )/ / / /       | |/ / / / / /___   
#  /_/    /_/ /____//_/ /_/        |___/ /_/  \____/   
#	
#	~/.config/fish/config.fish file 
#	  
#	Víctor Pérez Cano
#	GitHub: https://github.com/vpcano 
#	  
#===========================================================

##  COLOR OPTIONS  ##
set -g theme_display_git yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stached_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_worktree_support yes
set -g theme_display_user ssh
set -g theme_display_hostname yes
set -g theme_date_timezone Europe/Madrid
set -g theme_date_format "+%d/%m-[%H:%M]"
set -g theme_display_date yes 
set -g theme_color_scheme base16-light
set -g fish_prompt_pwd_dir_lenght 0  

##  VARIABLES  ##
set PATH $PATH
set -x EDITOR "nvim"
set -x TERM "alacritty"

##  ALIAS  ##
alias ls="exa -l"
alias la="ls -a"
alias grep="grep --color=auto"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias valgrind="valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v"
alias vim="nvim"

##  FUNCTIONS  ##
function cd 
	builtin cd $argv  
	ls
end

function swap
	set --local argc (count $argv)
	
	if test $argc -ne 2  
		echo swap: 2 arguments needed
		return 1
	end

	mv $argv[1] temp.file
	mv $argv[2] $argv[1]
	mv temp.file $argv[2]
			
end

function ex
	if [ -f $argv ]
		switch $argv
			case '*.tar.bz2'
				tar xjf $argv
			case '*.tar.gz'
				tar xzf $argv
			case '*.bz2'
				bunzip2 $argv
			case '*.rar'
				unrar x $argv
			case '*.gz'
				gunzip $argv
			case '*.tar'
				tar xf $argv
			case '*.tbz2'
				tar xjf $argv
			case '*.tgz'
				tar xzf $argv
			case '*.zip'
				unzip $argv
			case '*.Z'
				uncompress $argv
			case '*.7z'
				7z x $argv
			case '*'
				echo Invalid format
		end
	end
end				

##  AUTOSTART  ##
$HOME/.local/bin/vicfetch

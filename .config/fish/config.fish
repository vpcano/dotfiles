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

##  ALIAS  ##
source $HOME/.aliasrc

##  INTEGRATION WITH RANGER  ##
function ranger-cd
    set dir (mktemp -t ranger_cd.XXX)
    ranger --choosedir=$dir
    cd (cat $dir) $argv
    rm $dir
    commandline -f repaint
end

##  FUNCTIONS  ##
function cd
	if builtin cd $argv
		ls
	end
end

##  AUTOSTART  ##
vicfetch

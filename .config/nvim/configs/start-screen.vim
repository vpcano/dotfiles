let half_width = winwidth(0)/2
let spaces = ' ' 
let i = 1

while i<(half_width-30)
	let spaces = spaces . ' ' 
	let i += 1
endwhile

let g:startify_session_dir = '~/.config/nvim/sessions'

let g:startify_lists = [
          \ { 'type': 'files',     'header': [spaces . '	⏲  RECENT FILES']            },
          \ { 'type': 'dir',       'header': [spaces . '	🖿  CURRENT DIRECTORY:  '. getcwd()] },
          \ { 'type': 'sessions',  'header': [spaces . '	🖿  SESSIONS']       },
          \ { 'type': 'bookmarks', 'header': [spaces . '	  BOOKMARKS']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/qtile/config.py' },
            \ { 'p': '~/.profile' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.config/shell/zsh/.zshrc' },
            \ { 'l': '~/.config/lf/lfrc' },
	    \ { 'a': '~/.config/alacritty/alacritty.yml' },
	    \ { 's': '~/Dev/st/config.def.h' },
            \ ]

let g:startify_session_autoload = 1

let g:startify_session_delete_buffers = 1

let g:startify_change_to_vcs_root = 1

let g:startify_fortune_use_unicode = 1

let g:startify_session_persistence = 1

let g:startify_enable_special = 0

let g:startify_files_number = 6

let g:startify_custom_header = [
	\ '',
        \ spaces . '        _   __                       _    __  _   ______   ',
	\ spaces . '       / | / /   __ (_)____ ___     | |  / / (_) / ____/   ',
	\ spaces . '      /  |/ / | / // // __ `__ \    | | / / / / / /        ', 
 	\ spaces . '     / /|  /| |/ // // / / / / /    | |/ / / / / /___      ', 
	\ spaces . '    /_/ |_/ |___//_//_/ /_/ /_/     |___/ /_/  \____/      ',
	\ spaces . '							       ',
	\ spaces . '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━',
        \]

let g:startify_padding_left = half_width - 20 

call which_key#register(',', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR

let g:which_key_map =  {}

let g:which_key_use_floating_win = 0

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Function

let g:which_key_map[','] = [ '<Plug>NERDCommenterToggle'  , 'Comment' ]
let g:which_key_map['/'] = [ '/'                          , 'Search text' ]
let g:which_key_map['h'] = [ '<C-W>s'                     , 'Split below']
let g:which_key_map['v'] = [ '<C-W>v'                     , 'Split right']
let g:which_key_map['i'] = [ '<C-i>'			  , 'Vertical Resize +5' ]
let g:which_key_map['o'] = [ '<C-o>'			  , 'Vertical Resize -5' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'Start screen' ]
let g:which_key_map['m'] = [ 'mm'			  , '🖿 Open Vifm' ]
let g:which_key_map['n'] = [ 'nn'			  , 'NERDTree' ]
let g:which_key_map['t'] = [ 'tt'			  , '💻Terminal' ]
let g:which_key_map['w'] = [ ':w'			  , '🖪 Save' ]
let g:which_key_map['q'] = [ ':wq'			  , '🖪 Save and exit' ]
let g:which_key_map['c'] = [ ':Git commit'		  , 'Git Commit' ]
let g:which_key_map['f'] = [ ':Git status'		  , 'Git Status' ]
let g:which_key_map['g'] = [ 'tg'			  , 'Lazy git']		

let g:which_key_map.s = {
      \ 'name' : '+🔍search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

let g:which_key_map.d = {
	\ 'name' : '+Debugging' ,
	\ '<F4>' : ['<F4>'        , 'Build']		,
	\ '<F5>' : ['<F5>'        , 'Debug']		,
	\ '<F6>' : ['<F6>'	  , 'Launch']		,
	\ '<F7>' : ['<F7>'	  , 'Valgrind']		,	
	\ }


let g:which_key_map.b = {
	\ 'name' : '+buffer' ,
      	\ '1' : ['b1'        , 'buffer 1']        ,
      	\ '2' : ['b2'        , 'buffer 2']        ,
      	\ 'd' : ['bd'        , 'delete-buffer']   ,
      	\ 'f' : ['bfirst'    , 'first-buffer']    ,
      	\ 'h' : ['Startify'  , 'home-buffer']     ,
      	\ 'l' : ['blast'     , 'last-buffer']     ,
      	\ 'n' : ['bnext'     , 'next-buffer']     ,
      	\ 'p' : ['bprevious' , 'previous-buffer'] ,
      	\ '?' : ['Buffers'   , 'fzf-buffer']      ,
      	\ }

let g:which_key_map.l = {
      	\ 'name' : '+lsp',
      	\ 'f' : ['spacevim#lang#util#Format()'          , 'formatting']       ,
      	\ 'r' : ['spacevim#lang#util#FindReferences()'  , 'references']       ,
      	\ 'R' : ['spacevim#lang#util#Rename()'          , 'rename']           ,
      	\ 's' : ['spacevim#lang#util#DocumentSymbol()'  , 'document-symbol']  ,
      	\ 'S' : ['spacevim#lang#util#WorkspaceSymbol()' , 'workspace-symbol'] ,
      	\ 'g' : {
        	\ 'name': '+goto',
        	\ 'd' : ['spacevim#lang#util#Definition()'     , 'definition']      ,
        	\ 't' : ['spacevim#lang#util#TypeDefinition()' , 'type-definition'] ,
        	\ 'i' : ['spacevim#lang#util#Implementation()' , 'implementation']  ,
    	    \ },
      	\ }

let g:which_key_map.G = {
	\ 'name' : '+Git',
	\ 'a' : [':Git add'				, 'Add']		,
	\ 's' : [':Git status'				, 'Status']		,
	\ 'c' : [':Git commit'				, 'Commit']		,
	\ 'p' : [':Git push'				, 'Push']		,
	\ 'f' : [':Git fetch'				, 'Fetch']		,
	\ 'P' : [':Git pull'				, 'Pull']		,
	\ 'd' : [':vertical Git diff'			, 'Diff']		,
      	\ 'g' : [':FloatermNew lazygit'                 , 'Lazy git']		,
	\ }

let g:which_key_map.W = {
	\ 'name' : '+Window',
	\ 'h' : [ '<C-W>s'				, 'Split below']	,
	\ 'v' : [ '<C-W>v'				, 'Split right']	,
	\ 'i' : [ '<C-i>'				, 'Vertical Resize +5' ],
	\ 'o' : [ '<C-o>'				, 'Vertical Resize -5' ],
	\ 'I' : [ ':resize +5'				, 'Horizontal Resize +5' ],
	\ 'O' : [ ':resize -5'				, 'Horizontal Resize -5' ],
	\ 'w' : [ ':w'					, '🖪 Save' ]		,
	\ 'q' : [ ':wq'					, '🖪 Save and exit' ]	,
	\ 'Q' : [ ':q!'					, 'Exit without saving' ],
	\ }

let g:which_key_map.V = {
	\ 'name' : '+🖿 Vifm',
	\ 'm' : [ 'mm'					, 'Open Vifm' ]		,
	\ 't' : [ 'mt'					, 'Open Vifm on new tab' ],
	\ 's' : [ 'ms'					, 'Open Vifm on vertical split' ],
	\ 'h' : [ 'mh'					, 'Open Vifm on horizintal split'],
	\ }

let g:which_key_map.a = {
	\ 'name' : '+★ Bookmarks',
	\ 'c' : [ ':e ~/.config/qtile/config.py'	, 'Open Qtile config.py' ]	,
	\ 'i' : [ ':e ~/.config/nvim/init.vim'		, 'Open Neovim init.vim' ]	,
	\ 'z' : [ ':e ~/.config/fish/config.fish'	, 'Open Fish config.fish' ]	,
	\ 'a' : [ ':e ~/.config/alacritty/alacritty.yml', 'Open Alacritty .yml' ]	,
	\ 'C' : [ ':vsplit ~/.config/qtile/config.py'	, 'Open Qtile config.py on vertical split' ]	,
	\ 'I' : [ ':vsplit ~/.config/nvim/init.vim'	, 'Open Neovim init.vim on vertical split' ]	,
	\ 'Z' : [ ':vsplit ~/.config/fish/config.fish'	, 'Open Fish config.fish on vertical split' ]	,
	\ 'A' : [ ':vsplit ~/.config/alacritty/alacritty.yml', 'Open Alacritty .yml on vertical split' ],
	\ }

let g:which_key_map.e = {
      \ 'name' : '+⏏ Run' ,
      \ 't' : ['tt'				        	, '💻Terminal (popup)'],
      \ 'f' : ['tf'       					, '💻Terminal (floating)'],
      \ 'g' : [':FloatermNew lazygit'                           , 'Lazy git'],
      \ 'w' : [':silent ! google-chrome-stable'			, '🌐Browser'],
      \ 'm' : [':FloatermNew neomutt'				, '📧 Mail (floating)'],
      \ 'M' : [':Mail'						, '📧 Mail (popup)'],
      \ 'c' : [':FloatermNew calcurse'			, '📅 Calendar (month)'],
      \ 'C' : [':Calendar'					, '📅 Calendar (week)'],
      \ 's' : [':FloatermNew spt'				, '🎵Spotify'],
      \ 'p' : [':FloatermNew python'                            , 'Python'],
      \ 'h' : [':FloatermNew htop'				, 'Htop'],
      \ 'G' : [':FloatermNew gtop'				, 'Gtop'],
      \ }

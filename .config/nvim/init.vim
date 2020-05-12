"==============================================================
"        _   __                       _    __  _   ______
"       / | / /   __ (_)____ ___     | |  / / (_) / ____/
"      /  |/ / | / // // __ `__ \    | | / / / / / /     
"     / /|  /| |/ // // / / / / /    | |/ / / / / /___   
"    /_/ |_/ |___//_//_/ /_/ /_/     |___/ /_/  \____/   
"
"	~/.config/nvim/init.vim file 
"	
"	Víctor Pérez Cano
"	GitHub: https://github.com/vpcano 
"
"==============================================================



"""""""""""""""""""""""""""""""""""""""""""""""""
""  PLUGINS (using Vundle)  
"""""""""""""""""""""""""""""""""""""""""""""""""
"Required
call plug#begin('~/.config/nvim/plugins')

"My plugins
Plug 'preservim/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdcommenter'
Plug 'vifm/vifm.vim'
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'morhetz/gruvbox', {'dir': '~/.config/nvim/themes/gruvbox'}
Plug 'dracula/vim', { 'dir': '~/.config/nvim/themes/dracula' }
Plug 'unblevable/quick-scope'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'

"Required
call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""
""  GENERAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""
set number
set splitbelow splitright
set path+=**
set wildmenu
set incsearch
set smarttab
set shell=sh
set noshowmode
set termguicolors
set mouse=a
filetype plugin on



""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=30



""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDCOMMENTER
""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 2
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDCreateDefaultMappings = 0



""""""""""""""""""""""""""""""""""""""""""""""""
""  VIM-MINIMAP
""""""""""""""""""""""""""""""""""""""""""""""""
let g:minimap_highlight='Visual'



""""""""""""""""""""""""""""""""""""""""""""""""
""  VIM-AIRLINE (POWERLINE)
""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_spacemacs'



""""""""""""""""""""""""""""""""""""""""""""""""
""  LINTING (DEOPLETE AND ALE) 
""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})



""""""""""""""""""""""""""""""""""""""""""""""""
""  VIM-RAINBOW
""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1



""""""""""""""""""""""""""""""""""""""""""""""""
""  COLORIZER
""""""""""""""""""""""""""""""""""""""""""""""""
lua require'colorizer'.setup()



""""""""""""""""""""""""""""""""""""""""""""""""
""  QUICKSCOPE
""""""""""""""""""""""""""""""""""""""""""""""""
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ff2094' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END



""""""""""""""""""""""""""""""""""""""""""""""""
""  STARTIFY
""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/configs/start-screen.vim



""""""""""""""""""""""""""""""""""""""""""""""""
""  THEME (gruvbox)
""""""""""""""""""""""""""""""""""""""""""""""""
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE



""""""""""""""""""""""""""""""""""""""""""""""""
""  KEYMAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""
imap ii <Esc>
map nn :NERDTreeToggle<CR>
map mm :Vifm<CR>
map ms :VsplitVifm<CR>
map mh :SplitVifm<CR>
map mt :TabVifm<CR>
map tt :botright 15split term://fish -C clear <bar> :set nonumber <bar> :startinsert <CR> 
map <C-i> :vertical resize +5<CR>
map <C-o> :vertical resize -5<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Space> <C-w>r



""""""""""""""""""""""""""""""""""""""""""""""""
""  AUTOSTART
""""""""""""""""""""""""""""""""""""""""""""""""
augroup autostart	
	autocmd!
	"autocmd VimEnter * :Minimap
	autocmd VimEnter *
	  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
	  \|   PlugInstall | q
	  \| endif
augroup END 

augroup cproject 
	autocmd!
"" TODO autocmd BufRead,BufNewFile *.c set makeprg=*COMMAND TO COMPILE (READ FROM CURRENT FILE)*
	autocmd BufRead,BufNewFile *.c :packadd termdebug
	autocmd BufRead,BufNewFile *.c nnoremap <F4> :w <bar> :make %:r<cr>
	autocmd BufRead,BufNewFile *.c nnoremap <F5> :Termdebug exec/%:r<cr>	
	autocmd BufRead,BufNewFile *.c nnoremap <F6> :botright 15split term://fish -C ./exec/%:r <bar> :set nonumber <bar> :startinsert <cr>	
	autocmd BufRead,BufNewFile *.c nnoremap <F7> :botright 15split term://fish -C valgrind ./exec/%:r <bar> :set nonumber <bar> :startinsert <cr>	
augroup END

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

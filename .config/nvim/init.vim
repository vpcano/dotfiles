" ==============================================================
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
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'morhetz/gruvbox', {'dir': '~/.config/nvim/themes/gruvbox'}
Plug 'dracula/vim', { 'dir': '~/.config/nvim/themes/dracula' }
Plug 'joshdick/onedark.vim', { 'dir': '~/.config/nvim/themes/onedark' }
Plug 'unblevable/quick-scope'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'Shougo/neocomplete.vim'
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"Required
call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""
""  GENERAL CONFIG
""""""""""""""""""""""""""""""""""""""""""""""""
set number relativenumber
set cursorline
set splitbelow splitright
set path+=**
set wildmenu
set incsearch
set smarttab
set shell=sh
set noshowmode
set termguicolors
syntax on
set mouse=a
filetype plugin on
set timeoutlen=350
let g:mapleader = ","



""""""""""""""""""""""""""""""""""""""""""""""""
""  COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""
command Mail botright split term://zsh -c mutt | :set nonumber | :set norelativenumber | :startinsert
command Calendar botright 15split term://zsh -c calcurse | :set nonumber | :set norelativenumber | :startinsert
command PopupTerm botright 15split term://zsh | :set nonumber | :set norelativenumber | :startinsert



""""""""""""""""""""""""""""""""""""""""""""""""
""  THEME 
""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox



""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=30
let g:NERDTreeHijackNetrw = 0
let g:lf_replace_netrw = 1



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
let g:airline_theme = 'base16'



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
""  VIM-WHICH-KEY
""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.config/nvim/configs/vim-which-key.vim



""""""""""""""""""""""""""""""""""""""""""""""""
""  FLOATERM
""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_gitcommit='floaterm'
let g:floaterm_shell='zsh'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_rootmarkers=['.project', '.git', '.hg', '.svn', '.root', '.gitignore']



""""""""""""""""""""""""""""""""""""""""""""""""
""  KEYMAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""
imap ii <Esc>
map <C-n> :NERDTreeToggle<CR>
map mm :Lf<CR>
map ms :VsplitLf<CR>
map mh :SplitLf<CR>
map mt :LfNewTab<CR>
map tt :PopupTerm <CR> 
map tf :FloatermSend clear <CR>
map tg :FloatermNew lazygit <CR>
map ; :Files<CR>
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
	autocmd BufRead,BufNewFile *.c nnoremap <F6> :botright 15split term://zsh -c ./exec/%:r && zsh<bar> :set nonumber <bar> :startinsert <cr>	
	autocmd BufRead,BufNewFile *.c nnoremap <F7> :botright 15split term://zsh -c valgrind ./exec/%:r && zsh<bar> :set nonumber <bar> :startinsert <cr>	
augroup END

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

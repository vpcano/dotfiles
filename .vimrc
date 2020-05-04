"===========================================================
"
"	\\        //	~/.vimrc file 
"	 \\      //	
"	  \\    //	Víctor Pérez Cano
"	   \\  //	  GitHub: https://github.com/vpcano 
"	    \\//
"	     --
" "===========================================================
set nocompatible
filetype off

""  PLUGINS (using Vundle)  ""
set rtp+=~/.vim/bundle/Vundle.vim	"required
call vundle#begin()			"required
Plugin 'VundleVim/Vundle.vim' 		"required

Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'preservim/nerdcommenter'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vifm/vifm.vim'
Plugin 'WolfgangMehner/c-support'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'frazrepo/vim-rainbow'
Plugin 'morhetz/gruvbox'
Plugin 'ap/vim-css-color'
Plugin 'chrisbra/Colorizer'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'tc50cal/vim-terminal'

call vundle#end()           		 "required
filetype plugin indent on   		 "required

set number

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark 

""""""""""""""""""""""""""""""""""""""""""""""""""
""  POWERLINE  
""""""""""""""""""""""""""""""""""""""""""""""""""
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set rtp+=/usr/share/powerline/bindings/vim
set laststatus=2 
set showtabline=2
set noshowmode
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""
""  VIM-RAINBOW
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDCOMMENTS
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 2
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDCreateDefaultMappings = 0

""""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDTREE  
""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

""""""""""""""""""""""""""""""""""""""""""""""""""
""  KEYS  
""""""""""""""""""""""""""""""""""""""""""""""""""
:imap ii <Esc>
map <C-t>t :TerminalTab bash<CR>
map <C-t>s :TerminalVSplit bash<CR>
map <C-t>h :TerminalSplit bash<CR>
map <C-m>m :Vifm<CR>
map <C-m>s :VsplitVifm<CR>
map <C-m>t :TabVifm<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Space> <C-w>r

""""""""""""""""""""""""""""""""""""""""""""""""""
""  OTHER STUFF  
""""""""""""""""""""""""""""""""""""""""""""""""""
let g:minimap_highlight='Visual'
set splitbelow splitright
set mouse=nicr
set path+=**
set wildmenu
set incsearch
set smarttab

""""""""""""""""""""""""""""""""""""""""""""""""""
""  OPEN MINIMAP ON START
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * :Minimap

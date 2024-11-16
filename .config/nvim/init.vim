"""""""""""""""""""""""""""""""""""""""""""""""""
""  PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""
"Required
call plug#begin('~/.config/nvim/plugins')

"My plugins
Plug 'preservim/nerdcommenter'
Plug 'vifm/vifm.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'unblevable/quick-scope'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot' 
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'morhetz/gruvbox', {'dir': '~/.config/nvim/themes/gruvbox'}
Plug 'dracula/vim', { 'dir': '~/.config/nvim/themes/dracula' }
Plug 'joshdick/onedark.vim', { 'dir': '~/.config/nvim/themes/onedark' }
Plug 'preservim/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'voldikss/vim-floaterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
Plug 'github/copilot.vim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jackMort/ChatGPT.nvim'

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
set tabstop=4
set shiftwidth=4
set expandtab
set shell=sh
set noshowmode
set termguicolors
syntax on
set mouse=a
filetype plugin on
set timeoutlen=400
let g:mapleader = ","



""""""""""""""""""""""""""""""""""""""""""""""""
""  COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""
command VsplitLf botright vsplit | :LfCurrentFile
command SplitLf botright split | :LfCurrentFile



""""""""""""""""""""""""""""""""""""""""""""""""
""  THEME 
""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
" hi Normal guibg=NONE ctermbg=NONE



""""""""""""""""""""""""""""""""""""""""""""""""
""  NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=25
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
""  VIM-AIRLINE (POWERLINE)
""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'



""""""""""""""""""""""""""""""""""""""""""""""""
""  LINTING 
""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'



""""""""""""""""""""""""""""""""""""""""""""""""
""  COC
""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> <C-j>  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <C-k>  :<C-u>CocPrev<CR>



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
map <C-I> :resize +5<CR>
map <C-O> :resize -5<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Space> <C-w>r



lua require("chatgpt").setup()
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

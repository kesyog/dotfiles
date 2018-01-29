"vim-plug plugin manager
call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jpo/vim-railscasts-theme'
Plug 'chazy/cscope_maps'
Plug 'erig0/cscope_dynamic'
call plug#end()

" More powerful backspace
set backspace=indent,eol,start

" Automatically refresh file if it changes externally
set autoread
au FocusGained,BufEnter * :checktime

" Show line numbers
set number

" Color scheme
syntax enable
colorscheme railscasts

filetype plugin indent on
" use spaces for tabstop
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Cscope
nmap <F12> <Plug>CscopeDBInit

" Map vim 'unnamed register' to system clipboard
set clipboard=unnamedplus


" Improved C syntax highlighting:
"https://www.vim.org/scripts/script.php?script_id=3064

"vim-plug plugin manager
call plug#begin()
Plug 'tpope/vim-fugitive'               " git things
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'     " enable focus events in tmux
Plug 'jpo/vim-railscasts-theme'
Plug 'chazy/cscope_maps'
call plug#end()

" More powerful backspace
set backspace=indent,eol,start

" Automatically refresh file if it changes externally
set autoread
au FocusGained,BufEnter * :checktime  " see https://github.com/tmux-plugins/vim-tmux-focus-events

" Switch tabs with H and L
nnoremap H gT
nnoremap L gt

" Map control-p to :FZF in normal mode
nmap <C-p> :FZF<CR>

set number
set ruler
set showcmd
set smartindent

" Statusline
set laststatus=2

" Search highlighting
set hlsearch

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

" Use jk as <Esc> key
:inoremap jk <Esc>

" Set timeout for mappings. Nice to have when using jk as <Esc>
set timeoutlen=750

" Create :Find and :Findc command to find using rg. Findc searches only c/c++ files
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" --type: Restrict to certain pre-defined type. Use rg --type-list to see available types
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!*cscope*" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Findc call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --type c --type cpp --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

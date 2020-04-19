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
Plug 'junegunn/vim-emoji'
Plug 'bkad/CamelCaseMotion'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'cespare/vim-toml'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-commentary' "comment/uncomment using gc(c)
call plug#end()

" More powerful backspace
set backspace=indent,eol,start

" Automatically refresh file if it changes externally
au FocusGained,BufEnter * :checktime  " see https://github.com/tmux-plugins/vim-tmux-focus-events

" Switch tabs with H and L
nnoremap H gT
nnoremap L gt

" Map control-p to :FZF in normal mode
nmap <C-p> :FZF<CR>

set number
set relativenumber
set smartindent

" Statusline
set laststatus=2

" Search highlighting
set hlsearch
set noincsearch

" Color scheme
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

" Map F5 key to trim trailing whitespace
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!*cscope*" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Rgc call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --type c --type cpp --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Automatically save the file notes when idle
autocmd CursorHold .notes :write

" Auto-complete emoji by pressing Ctrl-X Ctrl-U
set completefunc=emoji#complete
command! Emoji %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" Disable cscope loaded message on startup
set nocscopeverbose

" Highlight text past 100 characters
"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength ctermbg=darkred guibg=#8B0000
"  autocmd BufEnter * match OverLength /\%>100v.\+/
"augroup END
set colorcolumn=100

" Use clang-format for = formatting
autocmd FileType c,cpp setlocal equalprg=clang-format\ -style='file'

" Fold by indent
set foldmethod=indent
set nofoldenable

" Use leader as CamelCaseMotion plugin key
let g:camelcasemotion_key = '<leader>'

" Disable eol at end of file
set nofixendofline

" Tell vim-commentary plugin to comment using // for C and C++ files
autocmd FileType c,cpp setlocal commentstring=//\ %s

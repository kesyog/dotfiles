" Improved C syntax highlighting:
"https://www.vim.org/scripts/script.php?script_id=3064

"vim-plug plugin manager
call plug#begin()
Plug 'tpope/vim-fugitive'               " git things
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'     " enable focus events in tmux
Plug 'jpo/vim-railscasts-theme'
Plug 'junegunn/vim-emoji'
Plug 'bkad/CamelCaseMotion'
Plug 'HerringtonDarkholme/yats.vim' "Typescript support
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'cespare/vim-toml'
Plug 'kmARC/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-commentary' "comment/uncomment using gc(c)
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Intellisense auto-completion engine
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

" True color (24-bit) support
set termguicolors

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

" Add a shaded column at the 100-character mark
set colorcolumn=100
" Put that column at 72 characters for git commit messages
autocmd FileType gitcommit setlocal colorcolumn=72

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

"""""""""""""""""""""""
"coc.nvim configuration
"""""""""""""""""""""""
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation. Use cscope_maps key-bindings
nmap <silent> <C-\>g <Plug>(coc-definition)
nmap <silent> <C-\><C-\>g :call CocAction('jumpDefinition', 'tabe')<cr>
nmap <silent> <C-]>g :call CocAction('jumpDefinition', 'split')<cr>
nmap <silent> <C-]><C-]>g :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap <silent> <C-\>s :call CocAction('jumpReferences')<cr>
" Jump to header file
nmap <silent> <M-h> :CocCommand clangd.switchSourceHeader<cr>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Format whole buffer
nmap <leader><leader>f  <Plug>(coc-format)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Load machine-specific configuration
source $HOME/init_local.vim

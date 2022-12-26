" Improved C syntax highlighting:
"https://www.vim.org/scripts/script.php?script_id=3064

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"vim-plug plugin manager
call plug#begin()
Plug 'tpope/vim-fugitive'               " git things
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'     " enable focus events in tmux
Plug 'jpo/vim-railscasts-theme'
Plug 'bkad/CamelCaseMotion'
Plug 'HerringtonDarkholme/yats.vim' " Typescript support
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'cespare/vim-toml'
Plug 'kmARC/vim-fubitive' " Bitbucket integration
Plug 'tpope/vim-rhubarb' " GitHub integration
Plug 'aklt/plantuml-syntax'
Plug 'tpope/vim-commentary' " comment/uncomment using gc(c)
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense auto-completion engine
Plug 'bfredl/nvim-ipy' " Nvim<->Jupyter integration
Plug 'bfrg/vim-cpp-modern' " Better C/C++ syntax highlighting
Plug 'rust-lang/rust.vim'
Plug 'hashivim/vim-terraform'
Plug 'udalov/kotlin-vim'
Plug 'NoahTheDuke/vim-just'
call plug#end()

" Set pyx version
if has('python3')
  set pyx=3
elseif has('python')
  set pyx=2
endif

" Disable nvim-ipy default keybindings
let g:nvim_ipy_perform_mappings = 0
" Run line of code
" nmap <silent> <leader>rr <Plug>(IPy-Run)
" Run cell (block)
nmap <silent> <leader><space> <Plug>(IPy-RunCell)
" Run entire file
nmap <leader>ra <Plug>(IPy-RunAll)
" Don't echo inputs longer than one line
let g:ipy_truncate_input=1

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
" Trim trailing whitespace on save
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e

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
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!*cscope*" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" Search C files only
command! -bang -nargs=* Rgc call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --type c --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" Search header files only
command! -bang -nargs=* Rgh call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --type h --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
" Search C and C++ files
command! -bang -nargs=* Rgcpp call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --type c --type cpp --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Automatically save the file notes when idle
autocmd CursorHold .notes :write

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

"Configure 'bfrg/vim-cpp-modern' C/C++ syntax highlighting
" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

"""""""""""""""""""""""
"coc.nvim configuration
"""""""""""""""""""""""
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
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

" Keep some cscope functionality
" Jump to caller
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>

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
" Apply codeAction at the cursor
nmap <leader>a <Plug>(coc-codeaction-cursor)
" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)
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
" Use bold text to highlight dead code rather than the default
highlight link CocFadeOut CocBold
" inlay hint style
hi CocInlayHint ctermfg=12 guifg=#15aabf

" Disable rust plugin integratino with syntastic since we're using the
" rust-analyzer LSP
let g:syntastic_rust_checkers = []
" Autofmt with rustfmt on save
let g:rustfmt_autosave = 1

" Configure root directory patterns for vim-rooter
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn']

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <leader>z :ZoomToggle<CR>

" Load machine-specific configuration
source $HOME/init_local.vim

require('config.lazy')

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.fixendofline = false
-- search highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = false
-- use spaces for tabstop
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = 'r'
vim.opt.grepprg = 'rg --vimgrep --smart-case --follow'
-- Put a shaded column at the 100-character mark
vim.opt.colorcolumn = '100'
-- Always show the signcolumn. Otherwise it shifts the text when diagnostics appear
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 300
-- Or 72 characters for git commit messages
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.colorcolumn = '72'
  end
})
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
-- Tell vim-commentary plugin to comment using // for C and C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c,cpp',
  callback = function()
    vim.opt_local.commentstring = '// %s'
  end
})
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    if vim.fn.has('win32') == 1 or vim.fn.has('wsl') == 1 then
      vim.g.clipboard = {
        copy = {
          ['+'] = 'win32yank.exe -i --crlf',
          ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
          ['+'] = 'win32yank.exe -o --lf',
          ['*'] = 'win32yank.exe -o --lf',
        },
      }
    elseif vim.fn.has('unix') == 1 then
      if vim.fn.executable('xclip') == 1 then
        vim.g.clipboard = {
          copy = {
            ['+'] = 'xclip -selection clipboard',
            ['*'] = 'xclip -selection clipboard',
          },
          paste = {
            ['+'] = 'xclip -l 1 -selection clipboard -o',
            ['*'] = 'xclip -l 1 -selection clipboard -o',
          },
        }
      elseif vim.fn.executable('xsel') == 1 then
        vim.g.clipboard = {
          copy = {
            ['+'] = 'xsel --clipboard --input',
            ['*'] = 'xsel --clipboard --input',
          },
          paste = {
            ['+'] = 'xsel --clipboard --output',
            ['*'] = 'xsel --clipboard --output',
          },
        }
      end
    end

    vim.opt.clipboard = 'unnamedplus'
  end,
  desc = 'Lazy load clipboard',
})

-- Set timeout for mappings. Nice to have when using jk as <Esc>
vim.opt.timeoutlen = 750
-- Keymappings
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', 'H', 'gT', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', 'gt', { noremap = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-i>', function()
  builtin.find_files({no_ignore = true, no_ignore_parent = true})
end, {})
vim.keymap.set('n', '<C-q>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, {})
vim.api.nvim_create_user_command('Fd', builtin.find_files, {})
vim.api.nvim_create_user_command('Rg', function(opts)
    if opts.args == '' then
      builtin.live_grep()
    else
      builtin.grep_string({ search = opts.fargs[1] })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgc', function(opts)
    if opts.args == '' then
      builtin.live_grep({type_filter = 'c'})
    else
      builtin.grep_string({
        search = opts.fargs[1],
        additional_args = {'--type', 'c', '--ignore-case'},
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgcpp', function(opts)
    if opts.args == '' then
      builtin.live_grep({type_filter = 'cpp'})
    else
      builtin.grep_string({
        search = opts.fargs[1],
        additional_args = {'--type', 'cpp', '--ignore-case'},
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgh', function(opts)
    if opts.args == '' then
      builtin.live_grep({type_filter = 'h'})
    else
      builtin.grep_string({
        search = opts.fargs[1],
        additional_args = {'--type', 'h', '--ignore-case'},
      })
    end
  end,
{ nargs = '?' })

-- Map F5 key to trim trailing whitespace
vim.keymap.set('n', '<F5>', function()
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('nohl')
  end,
  { noremap = true }
)

-- LSP config
vim.lsp.inlay_hint.enable()
vim.keymap.set('n', '<C-\\>g', builtin.lsp_definitions)
vim.keymap.set('n', '<C-\\><C-\\>g', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', {})
vim.keymap.set('n', '<C-]>g', function()
  vim.cmd('split')
  vim.lsp.buf.definition()
end, {})
vim.keymap.set('n', '<C-]><C-]>g', function()
  vim.cmd('vsplit')
  vim.lsp.buf.definition()
end, {})
vim.keymap.set('n', '<C-\\>s', builtin.lsp_references)
-- Toggle inlay hints
vim.keymap.set('n', '<F6>', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
vim.keymap.set('x', '<localleader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<localleader><localleader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float)

-- Misc autocommands
-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'c,cpp,rust,md,py',
  callback = function()
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      buffer = 0,
      command = '%s/\\s\\+$//e'
    })
  end,
})
-- Format on save using LSP
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'c,cpp,rust',
  callback = function()
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      buffer = 0,
      callback = function() vim.lsp.buf.format({async = false}) end,
    })
  end,
})

vim.cmd('source $HOME/init_local.vim')

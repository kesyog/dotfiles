require('config.lazy')
require('plugin_setup')

-- Options
vim.o.background = "dark"
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
vim.g.loaded_ruby_provider = 0
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
vim.keymap.set('n', '<localleader>i', ':Inspect<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<localleader>z', ':MaximizerToggle<CR>', {silent = true, noremap = true})
vim.keymap.set('v', '<localleader>z', ':MaximizerToggle<CR>gv', {silent = true, noremap = true})
vim.keymap.set('i', '<localleader>z', '<C-o>:MaximizerToggle<CR>', {silent = true, noremap = true})

local fzf = require('fzf-lua')
local fzf_actions = require('fzf-lua.actions')
vim.keymap.set('n', '<F1>', fzf.help_tags, {})
vim.keymap.set('n', '<C-p>', function() fzf.files({ fd_opts = '--no-hidden' }) end, {})
vim.keymap.set('n', '<localleader><C-p>', function()
  fzf.files({ fd_opts = '--no-ignore-vcs --hidden' })
end, {})
vim.keymap.set('n', '<C-q>', fzf.buffers, {})
vim.keymap.set('n', '<leader>fc', fzf.commands, {})
vim.keymap.set('n', '<leader>ff', fzf.builtin, {})
vim.keymap.set({ 'v', 'n' }, '<localleader>qf', fzf.lsp_code_actions, {})
vim.keymap.set({ 'v', 'n' }, '<localleader>a', fzf.lsp_code_actions, {})
vim.keymap.set('n', '<leader>fd', fzf.diagnostics_document, {})
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end,
  { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end,
  { desc = "Previous todo comment" })

-- Map F5 key to trim trailing whitespace
vim.keymap.set('n', '<F5>', function()
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('nohl')
  end,
  { noremap = true }
)
vim.keymap.set('n', '<F4>', function() require("nvim-highlight-colors").toggle() end,
  { desc = "Toggle color highlighting" })

-- LSP config
vim.lsp.inlay_hint.enable()
-- Toggle inlay hints
vim.keymap.set('n', '<F6>', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
vim.keymap.set('x', '<localleader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<localleader><localleader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float)

-- User commands
local rg_default_args = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e'
vim.api.nvim_create_user_command('Rg', function(opts)
    if opts.args == '' then
      fzf.live_grep()
    else
      fzf.grep({ search = opts.fargs[1] })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgc', function(opts)
    if opts.args == '' then
      fzf.live_grep({
        rg_opts = '--type c ' .. rg_default_args,
      })
    else
      fzf.grep({
        search = opts.fargs[1],
        rg_opts = '--type c ' .. rg_default_args,
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgcpp', function(opts)
    if opts.args == '' then
      fzf.live_grep({
        rg_opts = '--type cpp ' .. rg_default_args,
      })
    else
      fzf.grep({
        search = opts.fargs[1],
        rg_opts = '--type cpp ' .. rg_default_args,
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgh', function(opts)
    if opts.args == '' then
      fzf.live_grep({
        rg_opts = '--type h ' .. rg_default_args,
      })
    else
      fzf.grep({
        search = opts.fargs[1],
        rg_opts = '--type h ' .. rg_default_args,
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgcmake', function(opts)
    if opts.args == '' then
      fzf.live_grep({
        rg_opts = '--type cmake ' .. rg_default_args,
      })
    else
      fzf.grep({
        search = opts.fargs[1],
        rg_opts = '--type cmake ' .. rg_default_args,
      })
    end
  end,
{ nargs = '?' })
vim.api.nvim_create_user_command('Rgcmaked', function(opts)
    if opts.args == '' then
      fzf.live_grep({
        rg_opts = '--type cmake ' .. rg_default_args,
      })
    else
      fzf.grep({
        search = "(" .. opts.fargs[1] .. " ",
        rg_opts = '--type cmake ' .. rg_default_args,
      })
    end
  end,
{ nargs = '?' })

vim.keymap.set('n', '<C-\\>g',
  function()
    fzf.lsp_definitions({ jump1 = true })
  end, {})
vim.keymap.set('n', '<C-\\><C-\\>g',
  function()
    fzf.lsp_definitions({
      jump1 = true,
      jump1_action = fzf_actions.file_tabedit,
    })
  end, {})
vim.keymap.set('n', '<C-]>g',
  function()
    fzf.lsp_definitions({
    jump1 = true,
    jump1_action = fzf_actions.file_split,
    })
  end, {})
vim.keymap.set('n', '<C-]><C-]>g',
  function()
    fzf.lsp_definitions({
    jump1 = true,
    jump1_action = fzf_actions.file_vsplit,
    })
  end, {})
vim.keymap.set('n', '<C-\\>s', fzf.lsp_references, {})


-- Misc autocommands
-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'c,cpp,rust,markdown,python,ld,cmake,lua',
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

require("nvim-highlight-colors").turnOff()
require('highlight')

local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    if not string.match(result, "module '" .. module .. "' not found") then
      print('Error loading module:' .. module .. '\nError: ' .. result)
    end
  end
  --return ok
end

-- Load machine-specific config, if it exists
safe_require('local')

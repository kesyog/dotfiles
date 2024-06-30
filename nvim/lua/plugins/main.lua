return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
  }, 
  { 
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = true,
  },
  {
      'askfiy/visual_studio_code',
      lazy = true,
  },
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme vscode]])
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
  },
  {
    'jpo/vim-railscasts-theme',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local cmd
      local root_dir
      if os.getenv('PW_PROJECT_ROOT') == nil then
        cmd = {'clangd', '--clang-tidy'}
      else
        cmd = {'clangd',
          '--compile-commands-dir=' .. os.getenv('PW_PROJECT_ROOT') .. '/.pw_ide/.stable',
          '--query-driver=' .. os.getenv('PW_WAC_CIPD_INSTALL_DIR') .. '/bin/*,' .. os.getenv('PW_PIGWEED_CIPD_INSTALL_DIR') .. '/bin/*',
          '--background-index',
          '--clang-tidy',
        }
        root_dir = function(filename, buf) return vim.fs.root(filename, {'.repo'}) end
      end
      require('lspconfig').clangd.setup{
        cmd = cmd,
        root_dir = root_dir,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
    end,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close
            },
          },
          path_display = { 
            'truncate',
          },
          layout_config = { width = 0.95 },
        }
      }
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      vim.keymap.set({ 'v', 'n' }, '<localleader>a', require('actions-preview').code_actions)
    end,
  },
  { 
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'c',
          'cmake',
          'cpp',
          'linkerscript',
          'lua',
          'python',
          'rust',
          'starlark',
          't32',
          'vimdoc',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { 
    'chrisgrieser/nvim-spider',
    config = function()
      vim.keymap.set({'n', 'o', 'x'}, '<localleader>w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
      vim.keymap.set({'n', 'o', 'x'}, '<localleader>e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
      vim.keymap.set({'n', 'o', 'x'}, '<localleader>b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-path',
    },
    config = function()
     local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'buffer' },
          { name = 'emoji' },
          { name = 'path' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<tab>'] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_next_item()
            else
              original()
            end
          end, {'i', 's'}),
          ['<S-tab>'] = cmp.mapping(function(original)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              original()
            end
          end, {'i', 's'}),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Esc>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
      }, {
          { name = 'buffer' },
      })

      -- Set up lspconfig.
      require('lspconfig').rust_analyzer.setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      }
    end
  },
  {'akinsho/bufferline.nvim', version = 'v4.6.1', dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup{
        options = {
          mode = 'tabs',
          buffer_close_icon = '',
        }
      }
    end
  }
}

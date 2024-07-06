return {
  {
    "EdenEast/nightfox.nvim",
    -- dev = true,
    lazy = false,
    priority = 1000,
    config = function()
      local palette = require('nightfox.palette').load()
      require('nightfox').setup({
        options = {
          styles = {
            keywords = 'italic',
            comments = 'italic',
          },
        },
        specs = {
          carbonfox = {
            builtin4 = palette.carbonfox.blue.dim
          },
          nightfox = {
            builtin4 = palette.nightfox.blue.dim
          },
          dayfox = {
            builtin4 = palette.dayfox.blue.dim
          },
          duskfox = {
            builtin4 = palette.duskfox.blue.dim
          },
          terafox = {
            builtin4 = palette.terafox.blue.dim
          },
          nordfox = {
            builtin4 = palette.nordfox.blue.dim
          },
        },
        groups = {
          nightfox = {
            ["@function.builtin"] = { fg = "builtin4" },
            ["@lsp.typemod.macro.defaultLibrary"] = { link = "PreProc" },
          },
        },
      })
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
  },
  { 'folke/neoconf.nvim', opts = {} },
  { 'neovim/nvim-lspconfig' },
  {
    'ibhagwan/fzf-lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require "fzf-lua.actions"
      require('fzf-lua').setup{
        winopts = {
          preview = {
            horizontal = "right:50%",
          },
        },
        actions = {
          files = {
            ["default"]     = actions.file_edit_or_qf,
            ["ctrl-x"]      = actions.file_split,
            ["ctrl-v"]      = actions.file_vsplit,
            ["ctrl-t"]      = actions.file_tabedit,
            ["alt-q"]       = actions.file_sel_to_qf,
            ["alt-l"]       = actions.file_sel_to_ll,

          },
          buffers = {
            ["default"]     = actions.buf_edit,
            ["ctrl-x"]      = actions.buf_split,
            ["ctrl-v"]      = actions.buf_vsplit,
            ["ctrl-t"]      = actions.buf_tabedit,
          },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'diff',
          'dockerfile',
          'git_config',
          'gitcommit',
          'gitignore',
          'go',
          'java',
          'jsonc', -- needed for neoconf.nvim
          'linkerscript',
          'lua',
          'proto',
          'python',
          'rust',
          'starlark',
          'swift',
          't32',
          'vimdoc',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = false },
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
        formatting = {
          format = require("nvim-highlight-colors").format
        },
      }, {
          { name = 'buffer' },
      })
    end
  },
  {
    'akinsho/bufferline.nvim', version = 'v4.6.1', dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'tabs',
        buffer_close_icon = '',
      }
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>gb', gitsigns.blame)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
  {'szw/vim-maximizer'},
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        after = ''
      }
    }
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = "background",
    },
  },
}

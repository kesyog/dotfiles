--- Use this file to set up plugins that must be set up in a particular order

--- Must be run after nvim_cmp and neoconf setup
local function lspconfig_setup()
  local cmd
  local root_dir = nil
  --- TODO: do better via project-specific configs
  if os.getenv('PW_PROJECT_ROOT') == nil then
    cmd = {'clangd', '--clang-tidy'}
  else
    cmd = {'clangd',
    '--compile-commands-dir=' .. os.getenv('PW_PROJECT_ROOT') .. '/.pw_ide/.stable',
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
  require('lspconfig').rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
  require("lspconfig").starpls.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }

  --- Workaround for Rust Analyzer cancelling requests
  --- https://github.com/neovim/neovim/issues/30985#issuecomment-2447329525
  for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
      local default_diagnostic_handler = vim.lsp.handlers[method]
      vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
              return
          end
          return default_diagnostic_handler(err, result, context, config)
      end
  end
end

lspconfig_setup()

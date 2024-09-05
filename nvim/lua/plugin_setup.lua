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
end

lspconfig_setup()

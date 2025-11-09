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
    root_dir = function(bufnr, on_dir)
      dir = vim.fs.root(bufnr, {'.repo'})
      if (dir ~= nil) then
        on_dir(dir)
      end
    end
  end
  vim.lsp.config('clangd', {
    cmd = cmd,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_dir = root_dir,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })
  vim.lsp.enable('clangd')
  vim.lsp.config('rust_analyzer', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
  vim.lsp.enable('rust_analyzer')
  vim.lsp.config('starpls', { capabilities =  require('cmp_nvim_lsp').default_capabilities() })
  vim.lsp.enable('starpls')
  vim.lsp.enable('ty')
end

lspconfig_setup()

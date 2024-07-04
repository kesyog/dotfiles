-- Style augments/overrides, independent of colorscheme
function kes_apply_style_override()
  vim.cmd('hi link @lsp.typemod.variable.readonly Constant') -- maybe only if not @lsp.typemod.variable.functionscope
  vim.cmd('hi @lsp.typemod.parameter.declaration gui=italic')
  vim.cmd('hi @lsp.typemod.selfKeyword.declaration gui=italic')
  vim.cmd('hi @lsp.typemod.property.declaration gui=italic')
  vim.cmd('hi LspInlayHint gui=italic')
end
vim.api.nvim_create_autocmd('ColorScheme', { callback = kes_apply_style_override })
kes_apply_style_override()

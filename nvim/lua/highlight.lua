-- Style augments/overrides
function kes_apply_style_override()
  vim.cmd('hi @lsp.typemod.property.declaration gui=italic')
  vim.cmd('hi LspInlayHint gui=italic')
end
vim.api.nvim_create_autocmd('ColorScheme', { callback = kes_apply_style_override })
kes_apply_style_override()

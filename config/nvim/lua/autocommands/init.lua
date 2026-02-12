vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.cmd [[hi link BlinkCmpMenuSelection PmenuSel]]
    vim.cmd [[hi link BlinkCmpScrollBarThumb PmenuThumb]]
    vim.cmd [[hi link NormalFloat FloatBorder]]
  end,
})

return {
  'stevearc/oil.nvim',
  opts = {
    skip_confirm_for_simple_edits = true,
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,
  opts = {
    confirmation = {
      border = 'rounded',
    },
  },
  keys = {
    {
      '<C-n>',
      function()
        if vim.bo.filetype == 'oil' then
          require('oil.actions').close.callback()
        else
          vim.cmd 'Oil'
        end
      end,
      desc = 'Toggling file explorer',
    },
  },
}

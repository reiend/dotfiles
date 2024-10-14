return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    require('ibl').setup {
      enabled = true,
      indent = {
        char = '│',
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = true,
      },
    }
  end,
}

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
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

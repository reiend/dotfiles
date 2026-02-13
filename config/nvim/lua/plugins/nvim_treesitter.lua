return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      vim.env.CC = 'gcc'
      require('nvim-treesitter').install {
        'c',
        'lua',
        'markdown',
        'query',
        'vim',
        'vimdoc',
        'zig',
        'c_sharp',
        'java',
      }
    end,
  },
}

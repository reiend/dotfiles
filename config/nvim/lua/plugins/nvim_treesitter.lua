return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      vim.env.CC = 'gcc'
      require('nvim-treesitter').install { 'c_sharp', 'java' }
    end,
  },
}

return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    -- 'hrsh7th/cmp-nvim-lsp',
    -- 'creativenull/efmls-configs-nvim',
  },
  config = function()
    require('mason').setup {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    }
    require('mason-lspconfig').setup()
  end,
}

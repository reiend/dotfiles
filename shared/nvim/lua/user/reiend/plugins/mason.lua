return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    -- 'hrsh7th/cmp-nvim-lsp',
    -- 'creativenull/efmls-configs-nvim',
  },
  config = function()
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require 'lspconfig'

    require('mason').setup()
    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {
          capabilities = capabilities,
        }

        lspconfig[server_name].setup(require('user.reiend.lsp.' .. server_name))
      end,
    }
  end,
}

require {
  'folke/neodev.nvim',
  config = function()
    require('neodev').setup {
      library = {
        -- when not enabled, neodev will not change any settings to
        -- the LSP server
        -- these settings will be used for your Neovim config directory
        enabled = true,

        -- runtime path
        runtime = true,

        -- full signature, docs and completion of vim.api, vim.treesitter,
        -- vim.lsp and others
        types = true,

        -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as
        -- a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        plugins = { 'nvim-dap-ui' },
      },

      -- configures jsonls to provide completion for project specific
      -- .luarc.json files
      setup_jsonls = true,

      -- for your Neovim config directory, the config.library settings
      -- will be used as is
      -- for plugin directories (root_dirs having a /lua directory),
      -- config.library.plugins will be disabled
      -- for any other directory, config.library.enabled will be set to false

      -- override = function(_root_dir, _options) end,

      -- With lspconfig, Neodev will automatically setup your
      -- lua-language-server

      -- If you disable this, then you have to set
      -- {before_init=require("neodev.lsp").before_init}

      -- in your lsp start options
      lspconfig = true,

      -- much faster, but needs a recent built of lua-language-server
      -- needs lua-language-server >= 3.6.0
      pathStrict = true,
    }
  end
}

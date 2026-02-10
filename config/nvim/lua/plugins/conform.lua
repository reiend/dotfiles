return {
  'stevearc/conform.nvim',
  config = function()
    local plugin = require 'conform'

    local format_config = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    }

    plugin.setup {
      formatters_by_ft = {
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        nix = { 'nixfmt' },
        lua = { 'stylua' },
        cs = { 'csharpier' },
      },
      -- format_on_save = format_config,
    }

    vim.keymap.set('n', '<space>f', function()
      plugin.format(format_config)
    end)
  end,
}

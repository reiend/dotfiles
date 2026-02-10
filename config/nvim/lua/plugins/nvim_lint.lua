return {
  'mfussenegger/nvim-lint',
  config = function()
    local plugin = require 'lint'

    plugin.linters.clangtidy.args = {
      '-p',
      'build',
    }

    plugin.linters_by_ft = {
      lua = { 'luacheck' },
      c = { 'clangtidy' },
      cpp = { 'clangtidy' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}

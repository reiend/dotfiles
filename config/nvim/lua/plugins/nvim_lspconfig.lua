return {
  'neovim/nvim-lspconfig',
  dependencies = {
    require 'plugins.mason',
    require 'plugins.blink',
  },
  config = function()
    local lsp_format = function()
      vim.lsp.buf.format { async = true }
    end

    local toggle_quickfix = function()
      if vim.bo.filetype == 'qf' then
        vim.cmd [[cclose]]
      else
        vim.cmd [[copen]]
      end
    end

    vim.diagnostic.config {
      virtual_text = false,
      float = {
        focusable = true,
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<C-f>', toggle_quickfix)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f<CR>', lsp_format, opts)
      end,
    })

    local mason_lspconfig = require 'mason-lspconfig'
    local blink = require 'blink.cmp'

    mason_lspconfig.setup {
      ensure_installed = { 'lua_ls' },
      automatic_enable = false,
    }

    for _, name in ipairs(mason_lspconfig.get_installed_servers()) do
      vim.lsp.config(name, {
        capabilities = vim.tbl_deep_extend(
          'force',
          {},
          blink.get_lsp_capabilities()
        ),
      })

      vim.lsp.enable(name)
    end
  end,
}

return {
  'neovim/nvim-lspconfig',
  lazy = true,
  config = function()
    local lsp_format = function()
      vim.lsp.buf.format { async = true }
    end

    local toggle_quickfix = function()
      local bufs = vim.api.nvim_list_bufs()
      local has_quickfix = #vim.fn.getqflist() > 0

      local has_buf_quickfix = function(buf)
        return vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix'
      end

      for _, buf in pairs(bufs) do
        if has_quickfix and has_buf_quickfix(buf) then
          vim.api.nvim_buf_delete(buf, { force = false, unload = false })
          return
        end
      end

      vim.diagnostic.setqflist()
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
        vim.keymap.set('n', '<space>qf', toggle_quickfix)
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
  end,
}

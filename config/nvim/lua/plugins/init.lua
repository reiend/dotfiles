local M = {}

M.manager = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

M.setup = function()
  local plugin_path = 'plugins.'

  require('lazy').setup {
    install = { colorscheme = { 'catppuccin' } },
    checker = { enabled = false },
    spec = {
      require(plugin_path .. 'treesitter'),
      require(plugin_path .. 'catppuccin'),
      require(plugin_path .. 'transparent'),
      require(plugin_path .. 'telescope'),
      require(plugin_path .. 'lualine'),
      require(plugin_path .. 'oil'),
      require(plugin_path .. 'oil_git'),
      require(plugin_path .. 'oil_lsp_diagnostics'),
      require(plugin_path .. 'blink'),
      require(plugin_path .. 'nvim_lspconfig'),
      require(plugin_path .. 'mason'),
      require(plugin_path .. 'roslyn'),
      require(plugin_path .. 'fidget'),
      require(plugin_path .. 'conform'),
      require(plugin_path .. 'gitsigns'),
      require(plugin_path .. 'indent_blankline'),
      require(plugin_path .. 'nvim_lint'),
      require(plugin_path .. 'nvim_dap_ui'),
    },
  }
end

M.manager()
M.setup()

local M = {}

M.manager = function()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)
end

M.setup = function()
  local plugin_path = 'user.reiend.plugins.'

  require('lazy').setup {
    install = { colorscheme = { 'catppuccin' } },
    checker = { enabled = false },
    spec = {
      require(plugin_path .. 'telescope'),
      require(plugin_path .. 'catppuccin'),
      require(plugin_path .. 'nvim_tree'),
      require(plugin_path .. 'transparent'),
      require(plugin_path .. 'lualine'),
      require(plugin_path .. 'nvim_lspconfig'),
      -- require(plugin_path .. 'nvim_cmp'),
      require(plugin_path .. 'blink_cmp'),
      require(plugin_path .. 'mason'),
      require(plugin_path .. 'treesitter'),
      require(plugin_path .. 'gitsigns'),
      require(plugin_path .. 'fidget'),
      require(plugin_path .. 'nvim_lint'),
      require(plugin_path .. 'conform'),
      require(plugin_path .. 'nvim_dap_ui'),
      require(plugin_path .. 'lazydev'),
      require(plugin_path .. 'luvit_meta'),
      require(plugin_path .. 'indent_blankline'),

      -- require 'user.reiend.plugins.neodev',
      -- require(plugin_path .. 'comment'),
    },
  }
end

M.manager()
M.setup()

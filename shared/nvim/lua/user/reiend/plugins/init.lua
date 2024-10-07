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

require('lazy').setup {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    priority = 5000,
    config = function()
      require('telescope').setup()
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    priority = 1000,
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- optionally enable 24-bit colour
      -- vim.opt.termguicolors = true

      -- pass to setup along with your other options
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          root_folder_label = false,
        },
        filters = {
          dotfiles = true,
        },
      }

      vim.keymap.set(
        'n',
        '<C-n>',
        ':NvimTreeToggle<CR>',
        { desc = 'Toggling file explorer' }
      )
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 3000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {     -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,             -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = true,              -- Force no italic
        no_bold = true,                -- Force no bold
        no_underline = true,           -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' },     -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down
          -- (https://github.com/catppuccin/nvim#integrations)
        },
      }

      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    name = 'transparent',
    priority = 1000,
    config = function()
      require('transparent').setup { -- Optional, you don't have to run setup.
        groups = {                   -- table: default groups
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'StatusLine',
          'StatusLineNC',
          'EndOfBuffer',
          '',
        },
        extra_groups = {
          'NvimTreeNormal',
          'NvimTreeStatuslineNc',
        },                            -- table: additional groups that should be cleared
        exclude_groups = { 'Mason' }, -- table: groups you don't want to clear
      }

      require('transparent').clear_prefix 'nvim-tree'
      require('transparent').clear_prefix 'lua-lualine'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- 'WhoIsSethDaniel/lualine-lsp-progress.nvim'
    },
    priority = 1000,
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = ' ' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            'filename',
            -- 'lsp_progress'
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  require 'user.reiend.plugins.mason',
  require 'user.reiend.plugins.treesitter',
  require 'user.reiend.plugins.comment',
  require 'user.reiend.plugins.fidget',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   config = function()
  --     require('lint').linters_by_ft = {
  --       lua = { 'luacheck' }
  --     }
  --     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --       callback = function()
  --         require("lint").try_lint()
  --       end,
  --     })
  --   end
  -- }
}

return {
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
}

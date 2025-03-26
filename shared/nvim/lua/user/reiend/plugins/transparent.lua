return {
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
}

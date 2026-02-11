return {
  'xiyaowong/transparent.nvim',
  name = 'transparent',
  config = function()
    require('transparent').setup {
      groups = {
        'Normal',
        'NormalNC',
        'NormalFloat',
        'Pmenu',
        'FloatBorder',
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
      },
      extra_groups = {
        'BlinkCmpMenuBorder',
      },
      exclude_groups = {
        'CursorLine',
      },
    }
  end,
}

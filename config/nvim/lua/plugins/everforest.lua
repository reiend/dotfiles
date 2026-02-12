return {
  'neanias/everforest-nvim',
  config = function()
    require('everforest').setup {
      background = 'dark',
      transparent_background_level = 0,
      italics = false,
      disable_italic_comments = false,
      sign_column_background = 'none',
      ui_contrast = 'low',
      dim_inactive_windows = false,
      diagnostic_text_highlight = false,
      diagnostic_virtual_text = 'coloured',
      diagnostic_line_highlight = false,
      spell_foreground = false,
      show_eob = true,
      float_style = 'bright',
      inlay_hints_background = 'none',
      on_highlights = function(highlight_groups, palette)
        highlight_groups.DiagnosticUnderlineError =
          { fg = 'NONE', bg = 'NONE', sp = palette.red, undercurl = true }
        highlight_groups.DiagnosticUnderlineWarn =
          { fg = 'NONE', bg = 'NONE', sp = palette.yellow, undercurl = true }
        highlight_groups.DiagnosticUnderlineInfo =
          { fg = 'NONE', bg = 'NONE', sp = palette.blue, undercurl = true }
        highlight_groups.DiagnosticUnderlineHint =
          { fg = 'NONE', bg = 'NONE', sp = palette.purple, undercurl = true }
        highlight_groups.DiagnosticUnderlineOk =
          { fg = 'NONE', bg = 'NONE', sp = palette.green, undercurl = true }
        highlight_groups.Pmenu = { link = 'Normal' }
        highlight_groups.Float = { link = 'Normal' }
        highlight_groups.NormalFloat = { link = 'Normal' }
        highlight_groups.FloatBorder = { link = 'Normal' }
        highlight_groups.BlinkCmpDoc = { link = 'Normal' }
        highlight_groups.BlinkCmpDocBorder = { link = 'Normal' }
      end,
      colours_override = function(palette) end,
    }
  end,
}

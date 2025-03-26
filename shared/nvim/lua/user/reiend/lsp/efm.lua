local luacheck = require 'efmls-configs.linters.luacheck'
luacheck.debounce = 300
luacheck.prefix = 'luacheck'

return {
  init_options = {
    documentFormatting = true,
    completion = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
  },
  settings = {
    rootMarkers = { '.git/' },
    lintDebounce = '0.3s',
    languages = {
      lua = {
        luacheck,
        require 'efmls-configs.formatters.stylua',
      },
      -- cpp = {
      --   require 'efmls-configs.linters.clang_tidy',
      --   require 'efmls-configs.formatters.clang_format',
      -- },
      cpp = {
        {
          prefix = 'clang-tidy',
          lintCommand = 'clang-tidy ${INPUT} -p build',
          lintStdin = false,
          lintIgnoreExitCode = true,
          lintFormats = {
            '%f:%l:%c: %trror: %m',
            '%f:%l:%c: %tarning: %m',
            '%f:%l:%c: %tote: %m',
          },
          rootMarkers = { '.clang-tidy' },
        },
        {
          -- linter
          prefix = 'clang-format',
          formatCommand = 'clang-format ${INPUT}',
          formatCanRange = false,
          formatStdin = true,
          rootMarkers = {
            '.clang-format',
          },
        },
      },
    },
  },
}

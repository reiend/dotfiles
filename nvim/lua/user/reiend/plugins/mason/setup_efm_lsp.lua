return function(lsp_config)
  return function()
    local luacheck = require 'efmls-configs.linters.luacheck'
    luacheck.debounce = 5000
    luacheck.prefix = 'luacheck'

    lsp_config.efm.setup {
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
        languages = {
          lua = {
            luacheck,
            require 'efmls-configs.formatters.stylua',
          },
        },
      },
    }
  end
end


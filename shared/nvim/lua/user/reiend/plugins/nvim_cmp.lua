return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    })
  end,
  config = function()
    local cmp = require 'cmp'

    cmp.setup {
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to
        -- only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm { select = true },
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'buffer' },
      },
    }

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources {
        -- You can specify the `git` source if [you were installed it]
        -- (https://github.com/petertriho/cmp-git).
        { name = 'git' },
        { name = 'buffer' },
      },
    })

    -- Use buffer source for `/` and `?`
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':'
    -- (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })

    local kind_icons = {
      Text = ' ',
      Method = '󰆧 ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = '󰇽 ',
      Variable = '󰂡 ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = ' ',
      Property = '󰜢 ',
      Unit = ' ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = ' ',
      Folder = '󰉋',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = ' ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = '󰅲 ',
    }

    cmp.setup {
      formatting = {
        -- fields = { "kind", "abbr", "menu" }, -- order of columns
        -- format = require("tailwindcss-colorizer-cmp").formatter,
        format = function(entry, item)
          -- Kind icons
          -- This concatonates the icons with the name of the item kind
          item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)

          -- Source
          item.menu = ({
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
          })[entry.source.name]
          return item
        end,
      },
    }
  end
}

local path = 'user.reiend.plugins.mason'

local module = {
  setup_efm_lsp = require(path .. '.setup_efm_lsp'),
  setup_lua_lsp = require(path .. '.setup_lua_lsp'),
  setup_clangd_lsp = require(path .. '.setup_clangd_lsp'),
}

module.setup_cmp = function()
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

module.get_cmp_capabilities = function()
  return require('cmp_nvim_lsp').default_capabilities()
end

module.setup_mason = function()
  require('mason').setup()
end

module.setup_mason_lsp = function(lsp_config, capabilities)
  require('mason-lspconfig').setup {
    ensure_installed = { 'lua_ls' },
    handlers = {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        lsp_config[server_name].setup {
          capabilities = capabilities,
        }
      end,
      ['lua_ls'] = module.setup_lua_lsp(lsp_config),
      ['efm'] = module.setup_efm_lsp(lsp_config),
      ['clangd'] = module.setup_clangd_lsp(lsp_config),
    },
  }

  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the
  -- below functions
  vim.diagnostic.config {
    virtual_text = true,
    float = {
      header = false,
      border = 'rounded',
      focusable = true,
    },
  }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set(
        'n',
        '<space>wr',
        vim.lsp.buf.remove_workspace_folder,
        opts
      )
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
end

return {
  'williamboman/mason.nvim',
  priority = 5000,
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'creativenull/efmls-configs-nvim',
    'rcarriga/nvim-dap-ui',
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'folke/neodev.nvim',
  },
  config = function()
    require('neodev').setup {
      library = {
        -- when not enabled, neodev will not change any settings to
        -- the LSP server
        -- these settings will be used for your Neovim config directory
        enabled = true,

        -- runtime path
        runtime = true,

        -- full signature, docs and completion of vim.api, vim.treesitter,
        -- vim.lsp and others
        types = true,

        -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as
        -- a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        plugins = { 'nvim-dap-ui' },
      },

      -- configures jsonls to provide completion for project specific
      -- .luarc.json files
      setup_jsonls = true,

      -- for your Neovim config directory, the config.library settings
      -- will be used as is
      -- for plugin directories (root_dirs having a /lua directory),
      -- config.library.plugins will be disabled
      -- for any other directory, config.library.enabled will be set to false

      -- override = function(_root_dir, _options) end,

      -- With lspconfig, Neodev will automatically setup your
      -- lua-language-server

      -- If you disable this, then you have to set
      -- {before_init=require("neodev.lsp").before_init}

      -- in your lsp start options
      lspconfig = true,

      -- much faster, but needs a recent built of lua-language-server
      -- needs lua-language-server >= 3.6.0
      pathStrict = true,
    }

    local dap = require 'dap'
    dap.adapters.lldb = {
      type = 'executable',

      -- adjust as needed, must be absolute path
      command = 'lldb-vscode',
      name = 'lldb',
    }

    dap.configurations.cpp = {
      {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input(
            'Path to executable: ',
            vim.fn.getcwd() .. '/',
            'file'
          )
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change
        -- the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
      },
    }

    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end)
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end)
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end)
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end)
    vim.keymap.set('n', '<Leader>b', function()
      require('dap').toggle_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>B', function()
      require('dap').set_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>lp', function()
      require('dap').set_breakpoint(
        nil,
        nil,
        vim.fn.input 'Log point message: '
      )
    end)
    vim.keymap.set('n', '<Leader>dr', function()
      require('dap').repl.open()
    end)
    vim.keymap.set('n', '<Leader>dl', function()
      require('dap').run_last()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end)

    local dapui = require('dapui')

    dapui.setup();

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    module.setup_cmp()
    module.setup_mason()
    module.setup_mason_lsp(require 'lspconfig', module.get_cmp_capabilities())
  end,
}


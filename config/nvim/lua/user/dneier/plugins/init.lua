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
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup()
    end,
  },
  {
    'nvim-lua/plenary.nvim',
  },
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'ThePrimeagen/harpoon',
  },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local builtin = require 'telescope.builtin'

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      require('telescope').load_extension 'harpoon'
    end,
  },
  {
    'WhoIsSethDaniel/lualine-lsp-progress.nvim',
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
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
          lualine_c = { 'filename', 'lsp_progress' },
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
  {
    'neanias/everforest-nvim',
    config = function()
      require('everforest').setup {
        background = 'hard',
      }
      vim.cmd [[colorscheme everforest]]
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup { -- Optional, you don't have to run setup.
        groups = { -- table: default groups
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
          'CursorLineNr',
          'EndOfBuffer',
        },
        extra_groups = { 'NvimTreeNormal', 'NvimTreeEndOfBuffer' }, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        sort_by = 'case_sensitive',
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

      local keymap = require('user.dneier.utils').keymap
      keymap(
        'n',
        '<C-n>',
        ':NvimTreeToggle<CR>',
        { desc = 'Toggling file explorer' }
      )
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {}
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup {
          -- A list of parser names, or "all" (the five listed parsers should always be installed)
          ensure_installed = { 'lua', 'tsx', 'html', 'javascript' },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = false,

          -- List of parsers to ignore installing (or "all")
          ignore_install = {},

          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

          highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats =
                pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        }
      end, 0)
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook(),
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end,
  },
  {
    'themaxmarchuk/tailwindcss-colors.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    priority = 1,
    config = function()
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
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

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set(
            'n',
            '<space>wa',
            vim.lsp.buf.add_workspace_folder,
            opts
          )
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
          vim.keymap.set(
            { 'n', 'v' },
            '<space>ca',
            vim.lsp.buf.code_action,
            opts
          )
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
  },
  {
    'hrsh7th/cmp-buffer',
  },
  {
    'hrsh7th/cmp-path',
  },
  {
    'hrsh7th/cmp-cmdline',
  },
  {
    'hrsh7th/nvim-cmp',
  },
  {
    'rafamadriz/friendly-snippets',
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip',
  },
  -- {
  --   'roobert/tailwindcss-colorizer-cmp.nvim',
  --   config = function()
  --     require('tailwindcss-colorizer-cmp').setup {
  --       color_square_width = 2,
  --     }
  --   end,
  -- },
  {
    'hrsh7th/nvim-cmp',
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
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        }),
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      local kind_icons = {
        Text = '',
        Method = '',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = 'ﴯ',
        Interface = '',
        Module = '',
        Property = 'ﰠ',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
      }

      cmp.setup {
        formatting = {
          -- fields = { "kind", "abbr", "menu" }, -- order of columns
          -- format = require("tailwindcss-colorizer-cmp").formatter,
          format = function(entry, item)
            -- Kind icons
            item.kind = string.format('%s %s', kind_icons[item.kind], item.kind) -- This concatonates the icons with the name of the item kind

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

      -- Set up lspconfig.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

      local lsp_config = require 'lspconfig'
      local on_attach = function(client, bufnr)
        if client.name == 'tailwindcss' then
          require('tailwindcss-colors').buf_attach(bufnr)
        end
      end

      lsp_config.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lsp_config.tsserver.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
      }

      -- Default completion builtin in lsp, using cmp instead
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      lsp_config.html.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        init_options = {
          configurationSection = { 'html', 'css', 'javascript' },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          providerFormatter = true,
        },
      }

      local util = require('lspconfig').util
      lsp_config.cssls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss' },
        init_options = {
          providerFormatter = true,
        },
        root_dir = util.root_pattern('package.json', '.git'),
        settings = {
          css = {
            validate = true,
          },
          scss = {
            validate = true,
          },
        },
      }

      lsp_config.tailwindcss.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = {
          'aspnetcorerazor',
          'astro',
          'astro-markdown',
          'blade',
          'clojure',
          'django-html',
          'htmldjango',
          'edge',
          'eelixir',
          'elixir',
          'ejs',
          'erb',
          'eruby',
          'gohtml',
          'gohtmltmpl',
          'haml',
          'handlebars',
          'hbs',
          'html',
          'html-eex',
          'heex',
          'jade',
          'leaf',
          'liquid',
          'markdown',
          'mdx',
          'mustache',
          'njk',
          'nunjucks',
          'php',
          'razor',
          'slim',
          'twig',
          'css',
          'less',
          'postcss',
          'sass',
          'scss',
          'stylus',
          'sugarss',
          'javascript',
          'javascriptreact',
          'reason',
          'rescript',
          'typescript',
          'typescriptreact',
          'vue',
          'svelte',
        },
        init_options = {
          userLanguages = {
            eelixir = 'html-eex',
            eruby = 'erb',
          },
        },
        root_dir = util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.mjs',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.cjs',
          'postcss.config.mjs',
          'postcss.config.ts',
          'package.json',
          'node_modules',
          '.git'
        ),
        settings = {
          tailwindCSS = {
            classAttributes = {
              'class',
              'className',
              'class:list',
              'classList',
              'ngClass',
            },
            lint = {
              cssConflict = 'warning',
              invalidApply = 'error',
              invalidConfigPath = 'error',
              invalidScreen = 'error',
              invalidTailwindDirective = 'error',
              invalidVariant = 'error',
              recommendedVariantOrder = 'warning',
            },
            validate = true,
          },
        },
      }

      lsp_config.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        single_file_support = true,
      }

      -- lsp_config.pylyzer.setup {
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   cmd = { "pylyzer", "--server" },
      --   filetypes = { 'python' },
      --   single_file_support = true,
      --   settings = {
      --     python = {
      --       checkOnType = false,
      --       diagnostics = true,
      --       inlayHints = true,
      --       smartCompletion = true
      --     }
      --   }
      -- }
      --

      lsp_config.ruff_lsp.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'ruff-lsp' },
        filetypes = { 'python' },
        single_file_support = true,
      }

      lsp_config.intelephense.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'intelephense', '--stdio' },
        filetypes = { 'php' },
        root_dir = util.root_pattern('composer.json', '.git'),
      }

      lsp_config.solargraph.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'solargraph', 'stdio' },
        filetypes = { 'ruby' },
        root_dir = util.root_pattern('Gemfile', '.git'),
        init_options = {
          formatting = true,
        },
        settings = {
          {
            solargraph = {
              diagnostics = true,
              completion = true,
            },
          },
        },
      }

      lsp_config.nixd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        root_dir = util.root_pattern('.nixd.json', '.git', 'flake.nix'),
        single_file_support = true,
      }

      lsp_config.efm.setup {
        root_dir = util.root_pattern '.git',
        single_file_support = true,
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
          hover = true,
          documentSymbol = true,
          codeAction = true,
          completion = true,
        },
        cmd = { 'efm-langserver' },
        settings = {
          rootMarkers = { '.git/' },
          languages = {
            ruby = {
              {
                prefix = 'rubocop',
                lintCommand = 'rubocop --lint --format emacs --stdin ${INPUT}',
                lintStdin = true,
                lintFormats = { '%f:%l:%c: %t: %m' },
                rootMarkers = {},
              },
            },
            -- cpp = {
            --   {
            --       prefix = 'clang_tidy',
            --       lintCommand = 'clang-tidy ${INPUT}',
            --       lintStdin = false,
            --       lintIgnoreExitCode = true,
            --       lintFormats = {
            --         '%f:%l:%c: %trror: %m',
            --         '%f:%l:%c: %tarning: %m',
            --         '%f:%l:%c: %tote: %m',
            --       },
            --       rootMarkers = { '.clang-tidy' },
            --   },
            --   {
            --     -- linter
            --     prefix = 'clang_format',
            --     formatCommand = 'clang-format ${INPUT}',
            --     formatCanRange = false,
            --     formatStdin = false,
            --     rootMarkers = {
            --       '.clang-format',
            --     },
            --   },
            -- },
            javascriptreact = {
              {
                prefix = 'eslint_d',
                lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
                lintIgnoreExitCode = true,
                lintStdin = true,
                lintFormats = {
                  '%f(%l,%c): %tarning %m',
                  '%f(%l,%c): %rror %m',
                },
              },
              {
                -- linter
                prefix = 'prettier_d',
                formatCommand = 'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize} ${--use-tabs=!insertSpaces}',
                formatCanRange = true,
                formatStdin = true,
                rootMarkers = {
                  '.prettierrc',
                  '.prettierrc.json',
                  '.prettierrc.js',
                  '.prettierrc.yml',
                  '.prettierrc.yaml',
                  '.prettierrc.json5',
                  '.prettierrc.mjs',
                  '.prettierrc.cjs',
                  '.prettierrc.toml',
                },
              },
            },
            javascript = {
              {
                prefix = 'eslint_d',
                lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
                lintIgnoreExitCode = true,
                lintStdin = true,
                lintFormats = {
                  '%f(%l,%c): %tarning %m',
                  '%f(%l,%c): %rror %m',
                },
              },
              {
                -- linter
                prefix = 'prettier_d',
                formatCommand = 'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize} ${--use-tabs=!insertSpaces}',
                formatCanRange = true,
                formatStdin = true,
                rootMarkers = {
                  '.prettierrc',
                  '.prettierrc.json',
                  '.prettierrc.js',
                  '.prettierrc.yml',
                  '.prettierrc.yaml',
                  '.prettierrc.json5',
                  '.prettierrc.mjs',
                  '.prettierrc.cjs',
                  '.prettierrc.toml',
                },
              },
            },
            typescript = {
              {
                prefix = 'eslint_d',
                lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
                lintIgnoreExitCode = true,
                lintStdin = true,
                lintFormats = {
                  '%f(%l,%c): %tarning %m',
                  '%f(%l,%c): %rror %m',
                },
              },
              {
                -- linter
                prefix = 'prettier_d',
                formatCommand = 'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize} ${--use-tabs=!insertSpaces}',
                formatCanRange = true,
                formatStdin = true,
                rootMarkers = {
                  '.prettierrc',
                  '.prettierrc.json',
                  '.prettierrc.js',
                  '.prettierrc.yml',
                  '.prettierrc.yaml',
                  '.prettierrc.json5',
                  '.prettierrc.mjs',
                  '.prettierrc.cjs',
                  '.prettierrc.toml',
                },
              },
            },
            typescriptreact = {
              {
                prefix = 'eslint_d',
                lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
                lintIgnoreExitCode = true,
                lintStdin = true,
                lintFormats = {
                  '%f(%l,%c): %tarning %m',
                  '%f(%l,%c): %rror %m',
                },
              },
              {
                -- linter
                prefix = 'prettier_d',
                formatCommand = 'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize} ${--use-tabs=!insertSpaces}',
                formatCanRange = true,
                formatStdin = true,
                rootMarkers = {
                  '.prettierrc',
                  '.prettierrc.json',
                  '.prettierrc.js',
                  '.prettierrc.yml',
                  '.prettierrc.yaml',
                  '.prettierrc.json5',
                  '.prettierrc.mjs',
                  '.prettierrc.cjs',
                  '.prettierrc.toml',
                },
              },
            },
            lua = {
              {
                -- formatter
                prefix = 'stylua',
                formatCommand = 'stylua --color Never ${--range-start:charStart} ${--range-end:charEnd} -',
                formatCanRange = true,
                formatStdin = true,
                rootMarkers = {
                  'stylua.toml',
                  '.stylua.toml',
                },
              },
              {
                -- linter
                prefix = 'luacheck',
                lintCommand = 'luacheck --codes --no-color --quiet -',
                lintIgnoreExitCode = true,
                lintStdin = true,
                lintFormats = { '%.%#:%l:%c: (%t%n) %m' },
                rootMarkers = {
                  '.luacheckrc',
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup {
        indent = { char = '│' },
        whitespace = {
          remove_blankline_trail = false,
        },
        scope = { enabled = false },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    config = function()
      -- co — choose ours
      -- ct — choose theirs
      -- cb — choose both
      -- c0 — choose none
      -- ]x — move to previous conflict
      -- [x — move to next conflict
      -- If you would rather not use these then
      require('git-conflict').setup()
    end,
  },
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   config = function()
  --     require('colorizer').setup()
  --   end,
  -- },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function() end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {}
    end,
  },
}

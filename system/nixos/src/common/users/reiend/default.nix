{ pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  users = {
    users = {
      reiend = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
  };

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Lekton" ]; }) ];

  environment.systemPackages = with pkgs; [
    lua-language-server
    nil
    ripgrep
    nixfmt-rfc-style
  ];

  home-manager.users.reiend =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";

      programs = {
        git = {
          enable = true;
        };
        neovim = {
          enable = true;
          plugins = with pkgs.vimPlugins; [
            catppuccin-nvim
            (nvim-treesitter.withPlugins (p: [
              p.lua
              p.nix
            ]))
            nvim-lspconfig
            nvim-cmp
            cmp-nvim-lsp
            cmp-buffer
            cmp-cmdline
            cmp-path
            luasnip
            cmp_luasnip
            telescope-nvim
            lualine-nvim
            fidget-nvim
            gitsigns-nvim
            nvim-tree-lua
            transparent-nvim
            indent-blankline-nvim
            conform-nvim
            nvim-lint
          ];
          extraLuaConfig = ''
            local options = {
              fileencoding = 'utf-8',          -- type of encoded text written on a file.
              cot = { 'menuone', 'noselect' }, -- options for completion ins-completion.
              syntax = 'on',                   -- enabled syntax highlighting.
              number = true,                   -- show line numbers.
              cursorline = true,               -- highlight the current line number.
              ruler = true,                    -- cursoer position diagnostics.
              expandtab = true,                -- tab to spaces.
              shiftwidth = 2,                  -- spaces inserted for each indentation.
              tabstop = 2,                     -- n of spaces for a tab.
              showtabline = 0,                 -- no tab display.
              ignorecase = true,               -- ignore character casing.
              smartcase = true,                -- enabled smart casing.
              smartindent = true,              -- enabled smart indentation.
              wrap = false,                    -- one liner only, don't wrap.
              termguicolors = true,            -- enable 24-bit RBG color.
              backup = false,                  -- no file backup on edit.
              swapfile = false,                -- no swap file.
              undofile = true,                 -- saved undos even quit.
              splitbelow = true,               -- horizontal split go below.
              splitright = true,               -- vertical split go right.
              timeoutlen = 350,                -- time in milliseconds to wait for a mapped sequence to complete.
              updatetime = 100,                -- faster completion
              showmode = false,                -- dont display text mode
              relativenumber = true,
              laststatus = 3,
              scrolloff = 8,
              clipboard = 'unnamedplus',
              -- colorcolumn = "80"
            }

            -- use options
            for key2, value2 in pairs(options) do
              vim.opt[key2] = value2
            end

            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '

            local keymap = vim.keymap.set

            keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

            -- Remap for dealing with word wrap
            keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
            keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

            -- window navigation
            -- keymap('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
            -- keymap('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
            -- keymap('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
            -- keymap('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })

            -- rezing windows
            keymap('n', '<A-k>', ':resize +6<CR>', { desc = 'resize window bottom' })
            keymap('n', '<A-j>', ':resize -6<CR>', { desc = 'resize window top' })
            keymap(
              'n',
              '<A-l>',
              ':vertical resize -24<CR>',
              { desc = 'resize window left' }
            )
            keymap(
              'n',
              '<A-h>',
              ':vertical resize +24<CR>',
              { desc = 'resize window right' }
            )

            -- Navigate buffers
            keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Go to next buffer' })
            keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Go to previous buffer' })
            keymap('n', '<C-c>', ':bdelete!<CR>', { desc = 'Close active buffer' })

            -- Visual --
            -- indentation
            keymap('v', '<', '<gv', { desc = 'Left text indentation' })
            keymap('v', '>', '>gv', { desc = 'Right text indentation' })

            -- Visual Block --
            -- Move text up and down
            keymap('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move text top' })
            keymap('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move text bottom' })
            keymap('n', '<C-s>af', ':wa<CR>', { desc = 'Save all file' })
            keymap('n', '<C-s>f', ':w<CR>', { desc = 'Save file' })

            -- Hacks from thePrimeagen
            keymap('n', 'J', 'mzJ`z', { desc = 'Wrap line with cursor on start line' })

            keymap(
              'n',
              '<C-d>',
              '<C-d>zz',
              { desc = 'Move on file downwards with cursor centered' }
            )

            keymap(
              'n',
              '<C-u>',
              '<C-u>zz',
              { desc = 'Move on file upwards with cursor centered' }
            )

            keymap(
              'n',
              'n',
              'nzzzv',
              { desc = 'Move on searched word on file downwards with cursor centered' }
            )

            keymap(
              'n',
              'N',
              'Nzzzv',
              { desc = 'Move on searched word on file upwards with cursor centered' }
            )

            keymap(
              'n',
              '<leader>s',
              [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
              { desc = 'Multicursor replace word' }
            )

            -- setup catppuccin
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
                  indentscope_color = ' ',
                },
                -- For more plugins integrations please scroll down
                -- (https://github.com/catppuccin/nvim#integrations)
              },
            }

            vim.cmd.colorscheme 'catppuccin-mocha'


            -- setup cmp
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

            -- setup telescope
            require('telescope').setup()
            local builtin = require 'telescope.builtin'

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            -- setup lualine
            require('lualine').setup {
              options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = { left = '|', right = '|' },
                section_separators = { left = ' ', right = ' ' },
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

            -- setup fidget
            require("fidget").setup {
              progress = {
                display = {
                  render_limit = 1
                }
              },
              notification = {
                window = {
                  winblend = 0
                }
              }
            }

            -- setup gitsigns
            require('gitsigns').setup()

            -- setup nvim-tree
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

            -- setup transparent
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
                'EndOfBuffer'
              },
              extra_groups = {
                'NvimTreeNormal',
                'NvimTreeStatuslineNc',
              },                            -- table: additional groups that should be cleared
              exclude_groups = { 'Mason' }, -- table: groups you don't want to clear
            }
            require('transparent').clear_prefix 'nvim-tree'
            require('transparent').clear_prefix 'lua-lualine'

            -- setup indent-blank-line
            local highlight = {
              "CursorColumn",
              "Whitespace",
            }

            require("ibl").setup({
              enabled = true,
              indent = {
                char = "│",
              },
              scope = {
                enabled = true,
                show_start = false,
                show_end = true
              },
            })

            -- setup lsp
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                  runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim', 'string' },
                  },
                  workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file(' ', true),
                    checkThirdParty = false,
                  },
                  -- Do not send telemetry data containing a randomized but
                  -- unique identifier
                  telemetry = {
                    enable = false,
                  },
                }
              }
            }

            lspconfig.nil_ls.setup {
              capabilities = capabilities,
              cmd =  { 'nil' },
              filetypes = { 'nix' },
              root_dir = lspconfig.util.root_pattern("flake.nix", ".git"),
              single_file_support = true
            }

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the
            -- below functions
            vim.diagnostic.config {
              virtual_text = true,
              float = {
                -- header = false,
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
                -- vim.keymap.set('n', '<space>f', function()
                --   vim.lsp.buf.format { async = true }
                -- end, opts)
              end,
            })

            -- setup conform
            local plugin = require("conform");

            local format_config = {
              timeout_ms = 500,
              lsp_format = "fallback",
            }

            plugin.setup({
              formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                nix = { "nixfmt" }
              },
              format_on_save = format_config,
            })

            vim.keymap.set('n', '<space>f', function()
              plugin.format(format_config)
            end)

            -- setup nvim-lint
            require('lint').linters_by_ft = {
              lua = { 'luacheck' },
              c = { "clangtidy" },
              cpp = { "clangtidy" },
              javascript = { "eslint_d" },
              javascriptreact = { "eslint_d" },
              typescript = { "eslint_d" },
              typescriptreact = { "eslint_d" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
              callback = function()
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                require("lint").try_lint()
              end,
            })
          '';
        };
      };
    };
}

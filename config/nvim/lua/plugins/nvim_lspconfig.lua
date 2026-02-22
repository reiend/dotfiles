return {
  'neovim/nvim-lspconfig',
  dependencies = {
    require 'plugins.nvim_jdtls',
    require 'plugins.roslyn',
    require 'plugins.mason',
    require 'plugins.blink',
  },

  config = function()
    local lsp_format = function()
      vim.lsp.buf.format { async = true }
    end

    local toggle_quickfix = function()
      if vim.bo.filetype == 'qf' then
        vim.cmd [[cclose]]
      else
        vim.cmd [[copen]]
      end
    end

    vim.diagnostic.config {
      virtual_text = false,
      float = {
        focusable = true,
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '<C-f>', toggle_quickfix)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f<CR>', lsp_format, opts)
      end,
    })

    local blink_lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
    local servers = {}
    local is_win = function()
      local os = string.lower(vim.uv.os_uname().sysname)
      return string.find(os, 'win')
    end

    local setup_server = function(name)
      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        blink_lsp_capabilities,
        servers.capabilities or {}
      )

      servers[name] = {
        capabilities = capabilities,
      }

      if name == 'jdtls' then
        local nvim_jdtls_config = {}
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local root_dir = vim.fs.root(
          0,
          { 'gradlew', '.git', 'mvnw', 'build.gradle', 'pom.xml' }
        ) or vim.fn.getcwd()

        local set_nvim_jdtls_config = function(config)
          if is_win() then
            nvim_jdtls_config = vim.tbl_deep_extend('force', {}, {
              capabilities = {},
              name = 'jdtls',
              cmd = {
                vim.fn.expand '~/scoop/apps/openjdk/current/bin/java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.level=ALL',
                '-Xmx1G',
                '--add-modules=ALL-SYSTEM',
                '--add-opens',
                'java.base/java.util=ALL-UNNAMED',
                '--add-opens',
                'java.base/java.lang=ALL-UNNAMED',
                '-jar',
                vim.fn.expand(
                  (vim.fn.stdpath 'data')
                    .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
                ),

                '-configuration',
                vim.fn.expand(
                  (vim.fn.stdpath 'data') .. '/mason/packages/jdtls/config_win'
                ),
                '-data',
                vim.fn.expand(
                  (vim.fn.stdpath 'cache')
                    .. '/jdtls/workspace/'
                    .. project_name
                ),
              },
              root_dir = root_dir,
              settings = {
                java = {
                  configuration = {
                    updateBuildConfiguration = 'automatic',
                    runtimes = {
                      {
                        name = 'JavaSE-17',
                        path = vim.fn.expand '~/scoop/apps/openjdk17/current',
                      },
                      {
                        name = 'JavaSE-21',
                        path = vim.fn.expand '~/scoop/apps/openjdk21/current',
                      },
                      {
                        name = 'JavaSE-25',
                        path = vim.fn.expand '~/scoop/apps/openjdk/current',
                      },
                    },
                  },
                },
              },
              init_options = {
                bundles = vim.fn.expand(
                  (vim.fn.stdpath 'data')
                    .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
                ),
              },
            }, config)

            return
          end
        end

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'java',
          callback = function()
            set_nvim_jdtls_config { capabilities = capabilities }
            require('jdtls').start_or_attach(nvim_jdtls_config)
          end,
        })

        return
      end

      vim.lsp.config(name, servers[name])
      vim.lsp.enable(name)
    end

    for _, name in ipairs(require('mason-lspconfig').get_installed_servers()) do
      setup_server(name)
    end
  end,
}

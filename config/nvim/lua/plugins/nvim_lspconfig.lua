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
        local root_dir = vim.fs.root(
          0,
          { 'gradlew', '.git', 'mvnw', 'build.gradle', 'pom.xml' }
        ) or vim.fs.getcwd()

        local get_equinox_launcher_path = function()
          return vim.fn.expand(
            vim.fn.stdpath 'data'
              -- .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
              .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar'
          )
        end

        local get_config_path = function()
          local os = string.lower(vim.uv.os_uname().sysname)

          if string.find(os, 'win') then
            return vim.fn.expand(
              vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_win'
            )
          end

          return ''
        end

        local get_data_path = function()
          return vim.fn.expand((root_dir or '') .. '/.cache/jdtls/data')
        end

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'java',
          callback = function()
            require('jdtls').start_or_attach {
              capabilities = capabilities,
              name = 'jdtls',
              cmd = {
                'java',
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
                get_equinox_launcher_path(),
                '-configuration',
                get_config_path(),
                '-data',
                get_data_path(),
              },

              root_dir = root_dir,

              -- Here you can configure eclipse.jdt.ls specific settings
              -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
              -- for a list of options
              settings = {
                java = {},
              },

              -- This sets the `initializationOptions` sent to the language server
              -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
              -- you'll need to set the `bundles`
              --
              -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
              --
              -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
              init_options = {
                bundles = {},
              },
            }
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

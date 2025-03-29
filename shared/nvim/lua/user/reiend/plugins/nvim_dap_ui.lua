return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'

    dap.adapters.codelldb = {
      type = 'executable',
      command = 'codelldb',
      name = 'codelldb',
    }

    dap.configurations.cpp = {
      {
        name = 'codelldb',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      }
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
    vim.keymap.set('n', '<Leader>dbt', function()
      require('dap').toggle_breakpoint()
    end)

    vim.keymap.set('n', '<Leader>dbc', function()
      require('dap').clear_breakpoints()
    end)

    vim.keymap.set('n', '<Leader>db', function()
      require('dap').set_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>dbl', function()
      require('dap').set_breakpoint(
        nil,
        nil,
        vim.fn.input 'log: '
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

    vim.keymap.set('n', '<Leader>dc', function()
      dapui.close()
    end)

    vim.keymap.set('n', '<Leader>dc', function()
      dapui.close()
    end)

    vim.keymap.set('n', '<Leader>dt', function()
      dapui.toggle()
    end)

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
  end
}

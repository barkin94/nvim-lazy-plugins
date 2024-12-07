return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
    keys = {
      -- Debugging
      { "<F10>", desc = "Step Over", function() require("dap").step_over() end },
      { "<F11>", desc = "Step Into", function() require("dap").step_into() end },
      { "<F5>", desc = "Start/Continue Debugging", function () require("dap").continue() end  },
      { "<F9>", desc = "Toggle Breakpoint", function() require("dap").toggle_breakpoint() end },
      -- { "<leader>du", desc = "Toggle DAP UI", function() require("dapui").toggle() end },
    },
    config = function (_, opts)
      local dap, dapui, masondap, virtual_text = require("dap"), require("dapui"), require('mason-nvim-dap'), require("nvim-dap-virtual-text")

      virtual_text.setup()

      masondap.setup({
        handlers = {
          function(config)
            -- config.configurations.typescript = {
            --   {
            --     name = 'Launch',
            --     type = 'pwa-node',
            --     request = 'launch',
            --     program = '${file}',
            --     rootPath = '${workspaceFolder}',
            --     cwd = '${workspaceFolder}',
            --     sourceMaps = true,
            --     skipFiles = { '<node_internals>/**' },
            --     protocol = 'inspector',
            --     console = 'integratedTerminal',
            --   },
            -- }
            masondap.default_setup(config)
          end,
          typescript = function(config)
            print(vim.inspect(config))
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
          end,
        }
      })

      dapui.setup(opts)

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
  },
}


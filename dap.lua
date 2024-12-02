return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim", "nvim-neotest/nvim-nio" },
    keys = {
      -- Debugging
      { "<F10>", desc = "Step Over", function() require("dap").step_over() end },
      { "<F11>", desc = "Step Into", function() require("dap").step_into() end },
      { "<F5>", desc = "Start/Continue Debugging", function () require("dap").continue() end  },
      { "<F9>", desc = "Toggle Breakpoint", function() require("dap").toggle_breakpoint() end },
      -- { "<leader>du", desc = "Toggle DAP UI", function() require("dapui").toggle() end },
    },
    config = function (_, opts)
      local dap, dapui, masondap = require("dap"), require("dapui"), require('mason-nvim-dap')

      masondap.setup({
        handlers = {
          function(config)
            masondap.default_setup(config)
          end
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

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-neotest/neotest-go",
        ft = "go"
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({})
        },
      })
    end
  }

}


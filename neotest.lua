return {
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
    keys = {
      {
        "<leader>td",
        function()
          require("neotest").run.run({ suite = false, strategy = "dap" })
        end,
        desc = "Debug nearest test",
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

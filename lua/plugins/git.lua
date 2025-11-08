return {
  -- Inline Git signs & blame
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        current_line_blame = true, -- show git blame on current line
        current_line_blame_opts = { delay = 500 },
        watch_gitdir = { interval = 1000 },
        sign_priority = 6,
      })
    end,
  },

  -- Neogit UI
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = "Neogit", -- load only when Neogit is called
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    config = function()
      require("neogit").setup({
        integrations = {
          diffview = true, -- optional: integrate with diffview if you add it later
        },
      })
    end,
  },
}


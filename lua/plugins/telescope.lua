return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { { "nvim-lua/plenary.nvim", commit = "4f71c0c4a196ceb656c824a70792f3df3ce6bb6d" } },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "",
          sorting_strategy = "ascending",
        },
      })
    end,
  },
}


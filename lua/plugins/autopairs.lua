return {
  {
    "windwp/nvim-autopairs",
    commit = "c6139ca0d5ad7af129ea6c89cb4c56093f2c034a",
    event = "InsertEnter",
    dependencies = { { "hrsh7th/nvim-cmp", commit = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782" } },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        map_cr = true, -- auto add closing brace on Enter
      })

      -- Integrate with nvim-cmp
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}


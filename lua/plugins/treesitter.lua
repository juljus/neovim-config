return {
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.3",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "c" },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
}

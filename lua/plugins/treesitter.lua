return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",   -- automatically update parsers after install
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "c" },
                highlight = {
                    enable = true,  -- enable Treesitter-based syntax highlighting
                    additional_vim_regex_highlighting = false, -- disable default Vim regex highlighting
                },
                indent = {
                    enable = true,  -- smarter indentation based on syntax tree
                },
                incremental_selection = {
                    enable = true,
                },
            })
        end,
    },
}


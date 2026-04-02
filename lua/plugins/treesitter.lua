return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({})

            local ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "c" }
            local installed = require("nvim-treesitter").get_installed()
            local installed_set = {}
            for _, lang in ipairs(installed) do
                installed_set[lang] = true
            end

            local missing = {}
            for _, lang in ipairs(ensure_installed) do
                if not installed_set[lang] then
                    table.insert(missing, lang)
                end
            end

            if #missing > 0 then
                require("nvim-treesitter").install(missing)
            end
        end,
    },
}


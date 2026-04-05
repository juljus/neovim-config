return {
    {
        "nvim-lualine/lualine.nvim",
        commit = "7d131a8d3ba5016229e8a1d08bf8782acea98852",
        config = function()
            local colors = require("core.colors")
            require("lualine").setup({
                options = {
                    theme = colors.current_theme,      -- match your colorscheme
                    section_separators = { left = "", right = "" },
                    component_separators = { left = ":", right = ":" },
                    icons_enabled = false,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        {
                            "filename",
                            padding = { left = 1, right = 0 },
                            file_status = false
                        },
                        "progress"
                    },
                    lualine_c = { "diagnostics" },
                    lualine_x = { "lsp_status" },
                    lualine_y = { "filesize" },
                    lualine_z = {
                        {
                            "branch",
                            padding = { left = 1, right = 0 }
                        },
                        {
                            "diff",
                            colored = false
                        }
                    },
                },
            })
        end,
    },
}


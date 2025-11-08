return {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- lazy load on command
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "name",
                view = {
                    width = 30,
                    side = "left",
                },
                renderer = { icons = {
                        show = {
                            git = false,
                            folder = false,
                            file = false,
                            folder_arrow = false,
                        },
                    },
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
                diagnostics = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = false,
                    },
                },
            })
        end,
    },
}


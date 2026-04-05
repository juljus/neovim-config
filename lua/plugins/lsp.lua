return {
    {
        "neovim/nvim-lspconfig",
        tag = "v0.1.9",
        event = "BufEnter",
        dependencies = {
            { "williamboman/mason.nvim", tag = "v1.11.0" },
            { "williamboman/mason-lspconfig.nvim", tag = "v1.30.0" },
            { "hrsh7th/cmp-nvim-lsp", commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d" },
        },

        config = function()
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local mason_lsp = require("mason-lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            mason.setup()
            mason_lsp.setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "tsserver",
                    "clangd",
                    "bashls",
                },
            })

            mason_lsp.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },
}

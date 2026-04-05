return {
    {
        "hrsh7th/nvim-cmp",
        commit = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp", commit = "39e2eda76828d88b773cc27a3f61d2ad782c922d" },
            { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
            { "hrsh7th/cmp-path", commit = "1186cbde25c1518e43bbea73a2ac8f01a9bc26c8" },
            { "L3MON4D3/LuaSnip", tag = "v2.3.0" },
            { "saadparwaiz1/cmp_luasnip", commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843" },
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Optional: lazy load snippets (can leave minimal)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-Space>"] = cmp.mapping.complete(), -- manual trigger
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- optional: show source name in menu
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[SNIP]",
                            buffer = "[BUF]",
                            path = "[PATH]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                experimental = {
                    ghost_text = true, -- shows preview
                },
            })
        end,
    },
}

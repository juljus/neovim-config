return {
    {
        "L3MON4D3/LuaSnip",
        tag = "v2.3.0",
        event = "InsertEnter",
        dependencies = {
            { "rafamadriz/friendly-snippets", commit = "dcd4a586439a1c81357d5b9d26319ae218cc9479" },
        },
        config = function()
            local ls = require("luasnip")
            local s, t, i = ls.snippet, ls.text_node, ls.insert_node

            ls.add_snippets("c", {
                s("main", { t("int main(int argc, char **argv) {"), t({"", "\t"}), i(0), t({"", "    return 0;", "}"}) }),
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}

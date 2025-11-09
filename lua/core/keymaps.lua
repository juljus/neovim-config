-- TELESCOPE
vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Find files" })

-- COMMENT TOGGLING
vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

vim.keymap.set("v", "<leader>/", function()
    -- Exit visual mode, then toggle comment on selection
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- TERMINAL
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, desc = "Toggle terminal" })


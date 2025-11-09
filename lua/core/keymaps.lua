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

-- BUILD COMMANDS
vim.keymap.set("n", "<leader>cb", function()
    vim.cmd("w")  -- save file
    local file_dir = vim.fn.expand("%:h")
    local file_name = vim.fn.expand("%:t:r")
    local build_dir = file_dir .. "/build"
    local executable = build_dir .. "/" .. file_name
    local current_file = vim.fn.expand("%")
    
    -- open terminal
    vim.cmd("ToggleTerm")
    
    -- mkdir, build, run (stop if any fails)
    local cmd = "mkdir -p " .. build_dir .. " && gcc -Wall -Werror -Werror=vla -g " .. current_file .. " -o " .. executable .. " && " .. executable
    vim.cmd("TermExec cmd='" .. cmd .. "'")
end, { noremap = true, desc = "Build and run in terminal" })

-- TERMINAL
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, desc = "Toggle terminal" })


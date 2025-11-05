local M = {}

-- default theme
M.current_theme = "gruvbox"  -- change this to "tokyonight" or any installed theme

-- load the selected theme dynamically
function M.setup()
    if M.current_theme == "tokyonight" then
        vim.g.tokyonight_style = "storm"
        vim.cmd([[colorscheme tokyonight]])
    elseif M.current_theme == "gruvbox" then
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_invert_signs = 1
        vim.cmd([[colorscheme gruvbox]])
    end
end

return M


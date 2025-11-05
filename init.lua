-- Set leader keys as early as possible
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")

-- Load lazy.nvim (plugin manager)
require("core.lazy")

-- load colorscheme after plugins are available
require("core.colors").setup()

require("core.keymaps")


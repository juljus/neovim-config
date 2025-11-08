require("core.options")

-- Load lazy.nvim (plugin manager)
require("core.lazy")

-- load colorscheme after plugins are available
require("core.colors").setup()

require("core.keymaps")


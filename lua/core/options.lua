local opt = vim.opt

-- === Editor appearance ===
opt.number = true               -- show line numbers
opt.relativenumber = true       -- relative line numbers
opt.cursorline = true           -- highlight current line
opt.termguicolors = true        -- enable true color support
opt.scrolloff = 8               -- keep 8 lines visible above/below cursor
opt.signcolumn = "yes"          -- always show sign column (for LSP, git, etc.)

-- === Tabs and indentation ===
opt.expandtab = true            -- convert tabs to spaces
opt.shiftwidth = 4              -- indentation size for `>>` and `<<`
opt.tabstop = 4                 -- number of spaces a tab counts for
opt.softtabstop = 4             -- number of spaces for insert mode tab
opt.smartindent = true          -- smart autoindent

-- === Searching ===
opt.ignorecase = true           -- case-insensitive search
opt.smartcase = true            -- unless search has uppercase
opt.incsearch = true            -- show search results as you type
opt.hlsearch = true             -- highlight search matches

-- === Clipboard ===
opt.clipboard = "unnamedplus"   -- use system clipboard

-- === Splits ===
opt.splitright = true           -- new vertical splits to the right
opt.splitbelow = true           -- new horizontal splits below

-- === Misc ===
opt.backup = false              -- disable backup file creation
opt.swapfile = false            -- disable swapfile
opt.undofile = true             -- persistent undo
opt.wrap = false                -- no line wrapping
opt.timeoutlen = 300            -- faster completion timeout


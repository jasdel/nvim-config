local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs and indention
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

--termguicolors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- windows
opt.splitright = true
opt.splitbelow = true
opt.winborder = "rounded"

-- spelling
opt.spell = true
opt.spelllang = { "en_us" } -- or multiple languages like {"en", "sv"}

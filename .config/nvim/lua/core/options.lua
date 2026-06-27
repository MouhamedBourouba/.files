vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 250
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.scrolloff = 15
vim.g.c_syntax_for_h = 1  -- c not cpp for .h files
vim.opt.splitbelow = true -- Split below by default
-- vim.opt.splitright = true -- Split right by default
-- vim.opt.list = true       -- Show extra whitespace
vim.opt.cursorline = true -- Highlight current line
vim.opt.swapfile = false
vim.diagnostic.config { jump = { float = true } }

vim.opt.number = true
vim.opt.showtabline = 1
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.g.termguicolors = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " " }

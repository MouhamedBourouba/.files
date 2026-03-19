-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indents settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UX
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 250
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.scrolloff = 15

-- UI
-- vim.o.winborder = "rounded"
vim.opt.number = true
vim.opt.showtabline = 1
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.g.termguicolors = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.fillchars = { eob = " " }

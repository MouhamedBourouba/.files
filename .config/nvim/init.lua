vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.path:append("**")

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.showmode = false
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 150
-- view command output
vim.opt.inccommand = "split"
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 30
vim.opt.splitright = true

vim.g.netrw_banner = 0

-- run shell command and put it in quick fix list
vim.api.nvim_create_user_command("Rcmd", function(args)
  vim.api.nvim_command('cexpr system("' .. args.args .. '")')
end, { nargs = 1 })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-r>", "<cmd>wa<CR><cmd>make<CR>")
vim.keymap.set("n", "<C-x>", ":Rcmd ")

vim.keymap.set("n", "<C-t>", "gT")
vim.keymap.set("n", "^", "<C-^>")

vim.keymap.set("n", "<leader>mm", ":compiler gcc<CR>:set makeprg=make")
vim.keymap.set("n", "<leader>mg", ":compiler go<CR>:set makeprg=go\\ run ")
vim.keymap.set("n", "<leader>mj", "set makeprg=npm\\ run\\ dev")

vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")
vim.keymap.set("n", "[", "<cmd>cnext")
vim.keymap.set("n", "]", "<cmd>cNext")

vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d')

vim.keymap.set({ "v", "i", "n" }, "<S-Up>", "")
vim.keymap.set({ "v", "i", "n" }, "<S-Down>", "")

vim.keymap.set({ "v", "i", "n" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "v", "i", "n" }, "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<C-p>", "<cmd>ls<CR>:buffer ")
vim.keymap.set("n", "<C-^>", "<cmd>b#<CR>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-t>", "gT")

vim.keymap.set("n", "^", "<C-^>")

vim.keymap.set("n", "[[", "<cmd>cnext<CR>")
vim.keymap.set("n", "]]", "<cmd>cNext<CR>")

vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d')

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "v", "n" }, "L", "")
vim.keymap.set("n", ";", "")

vim.keymap.set({ "v", "i", "n" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "v", "i", "n" }, "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<C-p>", "<cmd>ls<CR>:buffer ")

vim.keymap.set("n", "<C-^>", "<cmd>b#<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "gw", "<C-w>")

vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set('n', '<C-c>', ':bw<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", ":wa<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

vim.keymap.set("n", "<leader>e", ":Ex<CR>")

vim.keymap.set("x", "R", ":s###g<left><left><left>")

-- Old remaps
-- vim.keymap.set("n", "<leader>;", "<cmd>wa<CR><cmd>make<CR>")
-- vim.keymap.set("n", "<leader>mm", ":compiler gcc<CR>:set makeprg=make")
-- vim.keymap.set("n", "<leader>mg", ":compiler go<CR>:set makeprg=go\\ run ")
-- vim.keymap.set("n", "<leader>mj", "set makeprg=npm\\ run\\ dev")
-- vim.keymap.set("n", "-", ":Ex<CR>")
-- vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")

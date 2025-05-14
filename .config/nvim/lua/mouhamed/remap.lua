-- run shell command and put it in quick fix list
vim.api.nvim_create_user_command("Rcmd", function(args)
  vim.api.nvim_command('cexpr system("' .. args.args .. '")')
end, { nargs = 1 })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>;", "<cmd>wa<CR><cmd>make<CR>")

vim.keymap.set("n", "<C-t>", "gT")
vim.keymap.set("n", "^", "<C-^>")

vim.keymap.set("n", "<leader>mm", ":compiler gcc<CR>:set makeprg=make")
vim.keymap.set("n", "<leader>mg", ":compiler go<CR>:set makeprg=go\\ run ")
vim.keymap.set("n", "<leader>mj", "set makeprg=npm\\ run\\ dev")

vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")
vim.keymap.set("n", "[[", "<cmd>cnext<CR>")
vim.keymap.set("n", "]]", "<cmd>cNext<CR>")

vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d')

vim.keymap.set({ "v", "i", "n" }, "<S-Up>", "")
vim.keymap.set({ "v", "i", "n" }, "<S-Down>", "")
vim.keymap.set({ "v", "n" }, "L", "")

vim.keymap.set({ "v", "i", "n" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "v", "i", "n" }, "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<C-p>", "<cmd>ls<CR>:buffer ")
vim.keymap.set("n", "<C-^>", "<cmd>b#<CR>")

vim.keymap.set("n", ";", "")

-- some times i hit w before realesing shift
vim.api.nvim_create_user_command("W", function()
  vim.api.nvim_command('wa')
end, { nargs = 0 })
vim.api.nvim_create_user_command("Wa", function()
  vim.api.nvim_command('wa')
end, { nargs = 0 })
vim.api.nvim_create_user_command("WA", function()
  vim.api.nvim_command('wa')
end, { nargs = 0 })
vim.api.nvim_create_user_command("Wq", function()
  vim.api.nvim_command('wq')
end, { nargs = 0 })
vim.api.nvim_create_user_command("WQ", function()
  vim.api.nvim_command('wq')
end, { nargs = 0 })

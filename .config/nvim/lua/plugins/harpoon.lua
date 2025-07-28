vim.pack.add {
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  }
}

local harpoon = require("harpoon")
harpoon.setup({
  settings = {
    sync_on_ui_close = true,
    save_on_toggle = true,
  }
})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "gh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-k>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-i>", function()
  harpoon:list():select(4)
end)
vim.keymap.set("n", "<C-o>", function()
  harpoon:list():select(5)
end)

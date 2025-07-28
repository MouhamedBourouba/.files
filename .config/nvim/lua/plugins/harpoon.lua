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
vim.keymap.set("n", "gj", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "gk", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "gl", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "g;", function()
  harpoon:list():select(4)
end)

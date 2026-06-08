vim.pack.add {
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/MouhamedBourouba/compile-mode.nvim",

  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  }
}

vim.keymap.set("n", "<C-g>", ":Git ")
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

require("zen-mode").setup({})

vim.keymap.set("n", "<leader>h", function()
  require("zen-mode").toggle({
    window = {
      width = 0.70,
    },
  })
end)

vim.keymap.set("n", "<leader>;", ":vertical 40 Recompile<CR>")
vim.keymap.set("n", "<leader>:", ":vertical 40 Compile<CR>")

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

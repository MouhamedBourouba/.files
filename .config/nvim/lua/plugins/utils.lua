vim.pack.add {
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/folke/flash.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/folke/zen-mode.nvim",
}

vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end)
vim.keymap.set("n", "<C-g>", ":Git ")

require("zen-mode").setup({})

vim.keymap.set("n", "<leader>h", function()
  require("zen-mode").toggle({
    window = {
      width = 0.70,
    },
  })
end)

vim.pack.add {
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/echasnovski/mini.statusline",
}

vim.cmd("colorscheme nightfox")
require("mini.statusline").setup()

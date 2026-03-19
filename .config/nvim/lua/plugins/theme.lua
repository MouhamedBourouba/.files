vim.pack.add {
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/echasnovski/mini.statusline",
}

vim.cmd("colorscheme carbonfox")
require("mini.statusline").setup()

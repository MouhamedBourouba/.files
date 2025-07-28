vim.pack.add { 
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/echasnovski/mini.statusline",
}


vim.cmd("colorscheme rose-pine-moon")
require("mini.statusline").setup()

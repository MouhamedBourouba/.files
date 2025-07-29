vim.pack.add {
  "https://github.com/projekt0n/github-nvim-theme",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/echasnovski/mini.statusline",
}


vim.cmd("colorscheme github_dark_high_contrast")
require("mini.statusline").setup()

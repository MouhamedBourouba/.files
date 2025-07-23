-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     config = function()
--       -- vim.cmd("colorscheme catppuccin-mocha")
--     end,
--   },
-- }
return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
  },
  {
    lazy = false,
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine-moon")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = true
      })
    end,
  },
  {
    "echasnovski/mini.statusline",
    opts = {},
  },
}

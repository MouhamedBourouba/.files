return {
  {
    "rebelot/kanagawa.nvim",
    config = function ()
      require("kanagawa").setup({
        compile = true
      })
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      -- vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
}

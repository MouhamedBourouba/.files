return {
  "stevearc/oil.nvim",
  config = function()
    require("oil").setup({})
    vim.keymap.set("n", "-", ":Oil<CR>")
  end,
  lazy = false,
}

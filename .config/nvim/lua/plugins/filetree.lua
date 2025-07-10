return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      require("oil").setup({})
      vim.keymap.set("n", "-", ":Oil<CR>")
    end,
    lazy = false,
  },
}

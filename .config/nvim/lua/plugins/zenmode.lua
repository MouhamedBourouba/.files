return {
  "folke/zen-mode.nvim",
  lazy = false,
  config = function()
    require("zen-mode").setup({})
    vim.keymap.set("n", "<leader>j", function()
      require("zen-mode").toggle({
        window = {
          width = 0.70,
        },
      })
    end)
  end,
}

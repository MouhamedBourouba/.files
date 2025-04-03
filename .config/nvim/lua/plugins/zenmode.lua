return {
  "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({})
    vim.keymap.set("n", "<leader>j", function()
      require("zen-mode").toggle({
        window = {
          width = 0.65,
        },
      })
    end)
  end,
}

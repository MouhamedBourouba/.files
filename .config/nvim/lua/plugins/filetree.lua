return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({})
      vim.keymap.set("n", "-", ":Oil<CR>")
    end,
    lazy = false,
  },
  {
    "https://github.com/nvim-neo-tree/neo-tree.nvim.git",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({})
      vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>")
    end,
  },
}

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    require("telescope").setup({})
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>gf", builtin.fd, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
    require("telescope").load_extension("ui-select")
  end,
}

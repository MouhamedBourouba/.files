vim.pack.add { "https://github.com/stevearc/oil.nvim.git" }

require("oil").setup({
  columns = {
    "permissions", "size", "mtime", "icon"
  },
  buf_options = {
    buflisted = true,
  },
  keymaps = {
    ["<CR>"] = "actions.select",
    ["<BS>"] = "actions.parent",
    ["Y"] = "actions.copy_entry_path",
    ["<C-z>"] = "actions.open_terminal",
    ["gi"] = ":! ",
  },
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".."
    end
  }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

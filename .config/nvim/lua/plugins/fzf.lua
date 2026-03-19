vim.pack.add {
  "https://github.com/ibhagwan/fzf-lua"
}

local fzf = require("fzf-lua")
fzf.register_ui_select()

fzf.setup {
  "hide",
  fzf_opts = { ["--cycle"] = true },
  files = {
    git_icons = false,
  },
  winopts = {
    row = 0.5,
    width = 0.8,
    height = 0.8,
    title_flags = false,
    preview = {
      horizontal = "right:50%",
      scrollbar = false,
    },
    backdrop = 100,
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
    builtin = {
      true,
      ["<esc>"] = "hide",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    }
  }
}

vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>k", fzf.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<leader>.", fzf.oldfiles, { desc = "Find old files" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Find string (livegrep)" })
vim.keymap.set("n", "<leader>g", fzf.git_status, { desc = "Find changed" })
vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>z", fzf.zoxide, { desc = "Find zoxide" })
vim.keymap.set("n", "<leader>sb", fzf.git_branches, { desc = "Find git branches" })
vim.keymap.set("n", "<leader>sc", fzf.git_commits, { desc = "Find commits" })

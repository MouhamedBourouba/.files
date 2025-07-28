vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
}

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "javascript",
    "go",
  },
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 50 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  auto_install = true,
})

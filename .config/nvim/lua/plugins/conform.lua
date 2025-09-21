vim.pack.add {
  "https://github.com/stevearc/conform.nvim",
}

require("conform").setup({
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    timeout_ms = 1000,
  },
  formatters_by_ft = {
    go = { "gofmt", "goimports" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    python = { "black", "isort" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    kotlin = { "ktlint" },
    dart = { "dart_format" },
  },
})

vim.keymap.set("n", "<leader>F", function()
  require("conform").format()
end)

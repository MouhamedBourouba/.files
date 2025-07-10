return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				kotlin = { "ktlint" },
				dart = { "dart_format" },
			},
		})
	end,
}

return {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
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

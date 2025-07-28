return {
	"nvim-telescope/telescope.nvim",
	version = false, -- latest
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim", -- native sorter (optional but recommended)
		build = "make",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				layout_config = {
					horizontal = { preview_width = 0.6 },
				},
				sorting_strategy = "ascending",
				prompt_prefix = "   ",
				selection_caret = " ",
				file_ignore_patterns = { "node_modules", ".git/", "venv" },
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					previewer = false,
				},
			},
		})

		-- Load extensions
		pcall(telescope.load_extension, "fzf")

		-- Keymaps (you can change these)
		local map = vim.keymap.set
		map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
		map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
		map("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
		map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
	end,
}

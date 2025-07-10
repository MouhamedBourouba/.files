-- return {
--   {
--     "rebelot/kanagawa.nvim",
--     config = function ()
--       require("kanagawa").setup({
--         compile = true
--       })
--       vim.cmd("colorscheme kanagawa")
--     end,
--   },
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     config = function()
--       -- vim.cmd("colorscheme catppuccin-mocha")
--     end,
--   },
-- }
return {
	{
		-- "projekt0n/github-nvim-theme",
		-- name = "github-theme",
		-- config = function()
		--   vim.cmd("colorscheme github_dark_default")
		-- end,
	},

	-- lua/plugins/rose-pine.lua
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine-moon")
		end,
		lazy = false,
	},

	{
		"echasnovski/mini.statusline",
		opts = {},
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
					"saadparwaiz1/cmp_luasnip",
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		config = function()
			-- Keymaps for LSP
			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }
				local map = vim.keymap.set
				local builtin = require("telescope.builtin")

				map("n", "K", vim.lsp.buf.hover, opts)

				map("n", "gd", vim.lsp.buf.definition, opts)
				map("n", "gr", builtin.lsp_references, opts)
				map("n", "gD", vim.lsp.buf.declaration, opts)
				map("n", "gi", builtin.lsp_implementations, opts)
				map("n", "gt", vim.lsp.buf.type_definition, opts)

				map("n", "<leader>ds", builtin.lsp_document_symbols, opts)
				map("n", "<leader>ws", builtin.lsp_workspace_symbols, opts)
				map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				map("n", "<leader>rn", vim.lsp.buf.rename, opts)
				map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				map("n", "<leader>e", builtin.diagnostics, opts)
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LSP Servers setup
			local servers = {
				"tailwindcss",
				"lua_ls",
				"gopls",
				"html",
				"cssls",
				"bashls",
				"jsonls",
				"ts_ls",
				"astro",
				"dartls",
			}

			for _, server in ipairs(servers) do
				require("lspconfig")[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			require("lspconfig").clangd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			})

			-- CMP setup
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}

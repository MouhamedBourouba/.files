return {
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v4.x",
      dependencies = {
        {
          "nvimtools/none-ls.nvim",
          config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
              sources = {
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.sqlfluffa,
              },
            })
          end,
        },
      },
      config = function()
        local lsp_zero = require("lsp-zero")
        ---@diagnostic disable-next-line: unused-local
        local lsp_attach = function(client, bufnr)
          local opts = { buffer = bufnr }
          local builtin = require("telescope.builtin")

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
          vim.keymap.set("n", "ds", builtin.lsp_document_symbols, opts)
          vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, opts)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", builtin.lsp_references, opts)
          vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

          vim.keymap.set("n", "<leader>e", builtin.diagnostics, opts)
        end

        lsp_zero.extend_lspconfig({
          sign_text = true,
          lsp_attach = lsp_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        local cmp = require("cmp")
        local ls = require("luasnip")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<TAB>"] = function(fallback)
              if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
          }),
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          snippet = {
            expand = function(args)
              ls.lsp_expand(args.body)
            end,
          },
        })

        require("lspconfig").tailwindcss.setup({})
        require("lspconfig").lua_ls.setup({})
        require("lspconfig").clangd.setup({})
        require("lspconfig").gopls.setup({})
        require("lspconfig").html.setup({})
        require("lspconfig").cssls.setup({})
        require("lspconfig").jsonls.setup({})
        require("lspconfig").ts_ls.setup({})
        require("lspconfig").dartls.setup({})
      end,
    },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
}

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/nvim-cmp" },
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets

          local ls = require("luasnip")
          local s = ls.snippet
          local t = ls.text_node
          local i = ls.insert_node

          ls.add_snippets("javascriptreact", {
            s("jd", {
              t({ "/**", " * " }),
              i(1),
              t({ "", " */" }),
            }),
          })
          ls.add_snippets("javascript", {
            s("jd", {
              t({ "/**", " * " }),
              i(1),
              t({ "", " */" }),
            }),
          })
        end,
      },
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
              null_ls.builtins.formatting.sqlfluff,
            },
          })
        end,
      },
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      -- Setup keymaps
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        local builtin = require("telescope.builtin")
        local map = vim.keymap.set

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gi", builtin.lsp_implementations, opts)
        map("n", "ds", builtin.lsp_document_symbols, opts)
        map("n", "<leader>ws", builtin.lsp_workspace_symbols, opts)
        map("n", "gt", vim.lsp.buf.type_definition, opts)
        map("n", "gr", builtin.lsp_references, opts)
        map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>F", vim.lsp.buf.format)
        map("n", "<leader>e", builtin.diagnostics, opts)
      end

      -- Extend LSP config
      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Setup nvim-cmp with LuaSnip
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Setup LSP servers
      local servers = {
        "tailwindcss",
        "lua_ls",
        "clangd",
        "gopls",
        "html",
        "cssls",
        "jsonls",
        "ts_ls",
        "dartls",
      }
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({})
      end
    end,
  },
}

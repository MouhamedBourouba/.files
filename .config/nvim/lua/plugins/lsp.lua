return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        local builtin = require("telescope.builtin")

        local keys = {
          ["K"] = vim.lsp.buf.hover,
          ["gd"] = vim.lsp.buf.definition,
          ["gr"] = builtin.lsp_references,
          ["gD"] = vim.lsp.buf.declaration,
          ["gi"] = builtin.lsp_implementations,
          ["gt"] = vim.lsp.buf.type_definition,
          ["<leader>ds"] = builtin.lsp_document_symbols,
          ["<leader>ws"] = builtin.lsp_workspace_symbols,
          ["<leader>rn"] = vim.lsp.buf.rename,
          ["<leader>ca"] = vim.lsp.buf.code_action,
          ["<leader>e"] = builtin.diagnostics,
          ["<C-k>"] = { vim.lsp.buf.signature_help, mode = "i" },
        }

        for lhs, rhs in pairs(keys) do
          local fn, mode = rhs, "n"
          if type(rhs) == "table" then fn, mode = rhs[1], rhs.mode end
          map(mode, lhs, fn, opts)
        end
      end

      local servers = {
        lua_ls = {},
        gopls = {},
        html = {},
        cssls = {},
        bashls = {},
        jsonls = {},
        ts_ls = {},
        astro = {},
        dartls = {},
        svelte = {},
        tailwindcss = {},
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      }

      for server, opts in pairs(servers) do
        opts.on_attach = on_attach
        opts.capabilities = capabilities
        lspconfig[server].setup(opts)
      end
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
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
          { name = "buffer" },
        }),
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}

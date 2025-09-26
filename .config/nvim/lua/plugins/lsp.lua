---@diagnostic disable: missing-fields
local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",

  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-path",

  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  -- "https://github.com/rafamadriz/friendly-snippets",

  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",

  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
}

local lspconfig = require("lspconfig")
local fzf = require("fzf-lua")
local cmp = require("cmp")
local types = require("cmp.types")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require("luasnip")

fzf.setup {
  "hide",
  fzf_opts = { ["--cycle"] = true },
  files = {
    git_icons = false,
  },
  winopts = {
    row = 0.5,
    width = 0.8,
    height = 0.8,
    title_flags = false,
    preview = {
      horizontal = "right:50%",
      scrollbar = false,
    },
    backdrop = 100,
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
    builtin = {
      true,
      ["<esc>"] = "hide",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    }
  }
}

fzf.register_ui_select()

function on_attach()
  vim.keymap.set("n", "<leader>j", fzf.lsp_document_symbols, { desc = "Find lsp symbols (jump)" })
  vim.keymap.set("n", "<leader>J", fzf.lsp_live_workspace_symbols, { desc = "Find lsp workspace symbols (Jump)" })
  vim.keymap.set("n", "<leader>I", fzf.lsp_document_diagnostics, { desc = "Find diagnostics" })
  vim.keymap.set("n", "<leader>i", fzf.lsp_workspace_diagnostics, { desc = "Find workspace diagnostics" })
  vim.keymap.set("n", "gd", fzf.lsp_definitions)
  vim.keymap.set("n", "gr", fzf.lsp_references)
  vim.keymap.set("n", "go", fzf.lsp_code_actions)
  vim.keymap.set("n", "gi", fzf.lsp_implementations, { desc = "lsp implementations" })
  vim.keymap.set("n", "gy", fzf.lsp_typedefs, { desc = "lsp type definitions" })
  vim.keymap.set("n", "grn", vim.lsp.buf.rename)
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)
end

local servers = {
  lua_ls         = {},
  gopls          = {},
  fsautocomplete = {},
  html           = {},
  cssls          = {},
  bashls         = {},
  jsonls         = {},
  pyright        = {},
  ts_ls          = {},
  astro          = {},
  dartls         = {},
  svelte         = {},
  dockerls       = {},
  -- golangci_lint_ls = {},
  tailwindcss    = {
    filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" }
  },
  clangd         = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  },
}

for server, config in pairs(servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end

local compare = cmp.config.compare
local opts = {
  performance = {
    debounce = 0,
    throttle = 0,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "",
        luasnip = "",
        nvim_lua = "",
        latex_symbolc = "",
      })[entry.source.name]
      return vim_item
    end,
    expandable_indicator = false,
    fields = { "abbr", "kind", "menu" },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-j>"] = {
      i = cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
    },
    ["<C-k>"] = {
      i = cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
    },
    ["<C-space>"] = function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end,
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  matching = {
    disallow_partial_fuzzy_matching = false,
  },
  sorting = {
    comparators = {
      compare.offset,
      compare.exact,
      compare.kind,
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
}

opts.window.completion.scrolloff = 5
cmp.setup(opts)

-- Snippet
require("luasnip").config.setup { history = true }
-- require("luasnip.loaders.from_vscode").lazy_load()
-- annoying as fuck
-- vim.keymap.set({ "n", "i" }, "<Tab>", function() require("luasnip").jump(1) end)
-- vim.keymap.set({ "n", "i" }, "<S-Tab>", function() require("luasnip").jump(-1) end)

-- Auto pairs
require("nvim-autopairs").setup {}
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
})

vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>k", fzf.help_tags, { desc = "Find help tags" })
vim.keymap.set("n", "<leader>.", fzf.oldfiles, { desc = "Find old files" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Find string (livegrep)" })
vim.keymap.set("n", "<leader>g", fzf.git_status, { desc = "Find changed" })
vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>z", fzf.zoxide, { desc = "Find zoxide" })
vim.keymap.set("n", "<leader>sb", fzf.git_branches, { desc = "Find git branches" })
vim.keymap.set("n", "<leader>sc", fzf.git_commits, { desc = "Find commits" })

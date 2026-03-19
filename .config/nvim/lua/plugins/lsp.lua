vim.pack.add {
  -- lsp
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/saghen/blink.cmp",

  -- snippets
  "https://github.com/rafamadriz/friendly-snippets",

  -- autopairs
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/windwp/nvim-ts-autotag",

  -- icons
  "https://github.com/nvim-tree/nvim-web-devicons",
}

local cmp = require("blink.cmp")
local fzf = require("fzf-lua")
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Blink cmp
cmp.setup({
  signature = {
    enabled = true,
  },
  completion = {
    documentation = {
      auto_show = true
    },
  },
  keymap = {
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },

    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
})

-- Lsp's
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    local map = vim.keymap.set
    local opts = { silent = true }

    map("n", "gd", fzf.lsp_definitions, opts)
    map("n", "grn", vim.lsp.buf.rename, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>j", fzf.lsp_document_symbols, opts)
    map("n", "<leader>J", fzf.lsp_live_workspace_symbols, opts)
    map("n", "<leader>i", fzf.lsp_document_diagnostics, opts)
    map("n", "<leader>I", fzf.lsp_workspace_diagnostics, opts)
    map("n", "gd", fzf.lsp_definitions, opts)
    map("n", "go", fzf.lsp_code_actions, opts)
    map("n", "gi", fzf.lsp_implementations, opts)
    map("n", "gy", fzf.lsp_typedefs, opts)

    -- diagnostic mappings
    map("n", "<Leader>cD", function()
      local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
      if ok then
        for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          diag.populate_workspace_diagnostics(cur_client, 0)
        end
        vim.notify("INFO: Diagnostic populated")
      end
    end)

    map("n", "<Leader>cdq", vim.diagnostic.setloclist)
    map("n", "<Leader>cdn", function() vim.diagnostic.jump({ count = 1, float = true }) end)
    map("n", "<Leader>cdp", function() vim.diagnostic.jump({ count = -1, float = true }) end)
    map("n", "<Leader>v", function()
      vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end)
  end,
})

vim.lsp.config("golangci_lint_ls", {
  cmd = { 'golangci-lint-langserver' },
  root_markers = { '.git', 'go.mod' },
  init_options = {
    command = {
      'golangci-lint', 'run', '--output.json.path', 'stdout', '--show-stats=false', '--issues-exit-code=1'
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "gopls",
  "fsautocomplete",
  "html",
  "cssls",
  "bashls",
  "jsonls",
  "pyright",
  "omnisharp",
  "ts_ls",
  "eslint",
  "astro",
  "dartls",
  "svelte",
  "dockerls",
  "intelephense",
  "tailwindcss",
  "clangd",
})

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})


-- autopairs
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
})

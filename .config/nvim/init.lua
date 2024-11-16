---@diagnostic disable: undefined-global

-- neovide
vim.opt.guifont = { "Iosevka Nerd Font", ":h3.85" }

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "mg979/vim-visual-multi"
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },

          c = { "clang-format" },
          cpp = { "clang-format" },
          h = { "clang-format" },

          go = { "gofmt" },

          javascript = { "prettier", stop_after_first = true },
        },
      })
    end
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
      vim.keymap.set('n', '<C-f>', require("fzf-lua").git_files)
      vim.keymap.set('n', '<C-*>', require("fzf-lua").files)
      vim.keymap.set('n', '<C-o>', require("fzf-lua").buffers)
    end
  },
  {
    {
      "ellisonleao/gruvbox.nvim",
      -- config = function()
      --   vim.cmd("colorscheme gruvbox")
      -- end
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        vim.cmd("colorscheme catppuccin")
      end
    }
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = { width = .75 }
      })
      vim.keymap.set('n', '<C-z>', '<cmd>Zen<CR>')
    end
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        indent = {
          enable = true
        },
        highlight = {
          enable = true, }
      })
    end
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup();
      vim.keymap.set("n", "-", "<cmd>Oil<CR>")
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<C-g>", ":Git ")
    end
  },
  -- LSP STUFF
  {
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    {
      'L3MON4D3/LuaSnip',
      dependencies = { "rafamadriz/friendly-snippets" },
    },
  }
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.showmode = false
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 150
-- view command output
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20
vim.opt.splitright = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-b>', '<cmd>wa<CR><cmd>make<CR>')

vim.keymap.set({ 'n', 'v', 'i' }, '<C-j>', '<C-d>zz')
vim.keymap.set({ 'n', 'v', 'i' }, '<C-k>', '<C-u>zz')

-- registers
vim.keymap.set({ 'n', 'v' }, '<C-ù>', '"_')
vim.keymap.set({ 'n', 'v' }, '<C-s>', '"+')

vim.keymap.set({ 'v', 'i', 'n' }, '<S-Up>', '')
vim.keymap.set({ 'v', 'i', 'n' }, '<S-Down>', "")
vim.keymap.set({ "n", "v" }, '<C-p>', '<cmd>ls<CR>:buffer ')

--LSP
local lsp_zero = require('lsp-zero')
---@diagnostic disable-next-line: unused-local
local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  local fzf = require("fzf-lua")

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)
  vim.keymap.set('n', 'ds', fzf.lsp_document_symbols, opts)
  vim.keymap.set('n', 'ws', fzf.lsp_workspace_symbols, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
  vim.keymap.set({ "n", "i" }, '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<leader>cn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<leader>ca', fzf.lsp_code_actions, opts)

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, opts)
  vim.keymap.set('n', '<leader>e', fzf.lsp_document_diagnostics, opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format({ details = true })
local ls = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  },
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

-- vim.keymap.set('i', '<Tab>', [[luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>']],
--   { expr = true, silent = true })
-- vim.keymap.set('s', '<Tab>', [[<cmd>lua require('luasnip').jump(1)<CR>]], { silent = true })
--
-- vim.keymap.set('i', '<S-Tab>', [[luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>']],
--   { expr = true, silent = true })
-- vim.keymap.set('s', '<S-Tab>', [[<cmd>lua require('luasnip').jump(-1)<CR>]], { silent = true })

require('lspconfig').lua_ls.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').ts_ls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').html.setup({})
require('lspconfig').cssls.setup({})

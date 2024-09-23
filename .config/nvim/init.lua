---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
      vim.keymap.set('n', '<C-p>', require("fzf-lua").files)
      vim.keymap.set('n', '<C-o>', require("fzf-lua").buffers)
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = { width = .75 }
      })
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
    'stevearc/conform.nvim',
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    config = function ()
      require("oil").setup();
      vim.keymap.set("n", "-", "<cmd>Oil<CR>")
    end
  },
  -- LSP STUFF
  {
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
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
vim.opt.updatetime = 250
-- view command output
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>z', '<cmd>Zen<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<C-b>', '<cmd>wa<CR><cmd>make<CR>')
vim.keymap.set('i', '<C-d>', '<cmd>normal "lyy"lp<CR>')
vim.keymap.set('n', '<C-a>', 'ggvG')
vim.keymap.set('n', '<C-Down>', '<C-d>zz')
vim.keymap.set('n', '<C-Up>', '<C-u>zz')
vim.keymap.set('n', '<C-w>', '<cmd>wa<CR>')

-- registers
vim.keymap.set('n', '<C-m>', '"_')
vim.keymap.set({'n', 'v'}, '<C-s>', '"+')

vim.keymap.set({'v','i','n'}, '<S-Up>', '')
vim.keymap.set({'v','i','n'}, '<S-Down>', "")

--LSP
local lsp_zero = require('lsp-zero')

---@diagnostic disable-next-line: unused-local
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}
  local fzf = require("fzf-lua")

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', fzf.lsp_definitions, opts)
  vim.keymap.set('n', 'gD', fzf.lsp_declarations, opts)
  vim.keymap.set('n', 'gi', fzf.lsp_implementations, opts)
  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', fzf.lsp_references, opts)
  vim.keymap.set({"n", "i"}, '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<leader>ca', fzf.lsp_code_actions, opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format({details = true})
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }),
})
require('lspconfig').lua_ls.setup({})
require('lspconfig').clangd.setup({})

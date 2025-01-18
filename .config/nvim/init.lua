---@diagnostic disable: undefined-global
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
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 150
-- view command output
vim.opt.inccommand = "split"
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 30
vim.opt.splitright = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- run shell command and put it in quick fix list
vim.api.nvim_create_user_command("Rcmd", function(args)
  vim.api.nvim_command('cexpr system("' .. args.args .. '")')
end, { nargs = 1 })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-r>", "<cmd>wa<CR><cmd>make<CR>")
vim.keymap.set("n", "<C-x>", ":Rcmd ")

vim.keymap.set("n", "<C-t>", "gT")

vim.keymap.set("n", "<leader>mm", ":compiler gcc<CR>:set makeprg=make")
vim.keymap.set("n", "<leader>mg", ":compiler go<CR>:set makeprg=go\\ run ")
vim.keymap.set("n", "<leader>mj", "set makeprg=npm\\ run\\ dev")

vim.keymap.set("n", "<leader>q", "<cmd>copen<CR>")
vim.keymap.set("n", "[", "<cmd>cnext")
vim.keymap.set("n", "]", "<cmd>cNext")

vim.keymap.set({ "n", "v", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d')

vim.keymap.set({ "v", "i", "n" }, "<S-Up>", "")
vim.keymap.set({ "v", "i", "n" }, "<S-Down>", "")

vim.keymap.set({ "v", "i", "n" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "v", "i", "n" }, "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<C-p>", "<cmd>ls<CR>:buffer ")
vim.keymap.set("n", "<C-^>", "<cmd>b#<CR>")

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
    "mg979/vim-visual-multi",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("telescope").setup({})
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>gf", builtin.fd, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "javascript",
          "go",
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<C-g>", ":Git ")
    end,
  },
  {
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
  },
})

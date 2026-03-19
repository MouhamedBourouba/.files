vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
}

require("nvim-treesitter").install({
  "c", "lua", "vim", "vimdoc", "query",
  "markdown", "markdown_inline", "javascript", "go",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if not pcall(vim.treesitter.language.inspect, vim.bo[ev.buf].filetype) then
      return
    end
    local max_filesize = 50 * 1024
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
    if ok and stats and stats.size > max_filesize then return end
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

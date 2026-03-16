-- some times i hit w before realesing shift
vim.api.nvim_create_user_command("W", function()
  vim.api.nvim_command("wa")
end, { nargs = 0 })
vim.api.nvim_create_user_command("Wa", function()
  vim.api.nvim_command("wa")
end, { nargs = 0 })
vim.api.nvim_create_user_command("WA", function()
  vim.api.nvim_command("wa")
end, { nargs = 0 })
vim.api.nvim_create_user_command("Wq", function()
  vim.api.nvim_command("wq")
end, { nargs = 0 })
vim.api.nvim_create_user_command("WQ", function()
  vim.api.nvim_command("wq")
end, { nargs = 0 })

-- run shell command and put it in quick fix list
vim.api.nvim_create_user_command("Rcmd", function(args)
  vim.api.nvim_command('cexpr system("' .. args.args .. '")')
end, { nargs = 1 })

-- sync cwd with oil.nim
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "oil://*",
  callback = function()
    local ok, oil = pcall(require, "oil")
    if not ok then return end

    -- save previous window-local cwd
    vim.w._prev_lcwd = vim.fn.getcwd(-1, 0)

    -- set cwd to Oil dir (window-local)
    vim.cmd.lcd(oil.get_current_dir())
  end,
})
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "oil://*",
  callback = function()
    if vim.w._prev_lcwd then
      vim.cmd.lcd(vim.w._prev_lcwd)
      vim.w._prev_lcwd = nil
    end
  end,
})

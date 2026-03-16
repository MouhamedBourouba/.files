-- prevent color flickring by loading the theme as the first thing
require("plugins.theme")

require("core.options")
require("core.autocommands")
require("core.keymaps")

local function load_file(path)
  local co = coroutine.running()
  vim.defer_fn(function()
    loadfile(path)()
    coroutine.resume(co)
  end, 2)
  coroutine.yield()
end

coroutine.wrap(function()
  local groups = {
    vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true),
    vim.api.nvim_get_runtime_file("lua/languages/*.lua", true)
  }

  for _, files in ipairs(groups) do
    for _, path in ipairs(files) do
      load_file(path)
    end
  end
end)()

-- New UI message box i dont want to use it now but may come in handy later
-- require("vim._extui").enable {}

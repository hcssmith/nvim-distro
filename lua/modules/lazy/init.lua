local M = {}
M.Plugins = {}

M.keymap = {
  normal = {
    {"<leader>lu",function() require('lazy').update() end}
  }
}

function M:Init()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

function M:RegisterModule(module)
  table.insert(self.Plugins, module)
end

function M:Run(opts)
  opts = opts
  require('lazy').setup(self.Plugins)
end

return M

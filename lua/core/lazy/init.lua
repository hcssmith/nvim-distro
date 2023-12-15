local M = {}

M.keymap = {
  normal = {
    {"<leader>lu",function() require('lazy').update() end}
  }
}

-- Ensure lazy is installed to the latest stable release.
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

--- Run lazy with an optional opts table.
---@param opts table
function M:Run(opts)
  require('lazy').setup('plugins', opts)
end

return M

local lazy = require('modules.lazy')


M = {}

M.EnabledModules = {}
M.Opts = {}
M.Keymaps = {}



function M:Load(module_location)
  module = require(tostring(module_location))
  if module.lazy ~= nil then
    lazy:RegisterModule(module.lazy)
  end
  if module.settings ~= nil then
    table.insert(self.EnabledModules, module.settings)
  end
  if module.keymap ~= nil then
    table.insert(self.Keymaps, module.keymap)
  end
end

function M:SetKeymaps(keymap_tbl, bufnr)
  local modes = {
    { "insert","i"},
    { "normal","n"},
    { "visual","v"}
  }
  for _, v in ipairs(modes) do
    if keymap_tbl[v[1]] ~= nil then
      for _, km in ipairs(keymap_tbl[v[1]]) do
        local opts = km[3]
        if opts == nil and bufnr ~= nil then
          opts = {
            buffer = bufnr
          }
        end
        vim.keymap.set(v[2], km[1], km[2], opts)
      end
    end
  end
end

function M:ApplySettings()
  for _, settings_function in ipairs(self.EnabledModules) do
    if settings_function ~= nil then
      settings_function()
    end
  end
  for _, keymap in ipairs(self.Keymaps) do
    if keymap ~= nil then
      self.SetKeymaps(self, keymap)
    end
  end
end



return M

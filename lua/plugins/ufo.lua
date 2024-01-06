---@type LazyPluginSpec
return {
  'kevinhwang91/nvim-ufo',
  --cond = NotWindows,
  dependencies = {
    'kevinhwang91/promise-async'
  },
  event = 'LspAttach',
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end },
    { 'zM', function() require('ufo').closeAllFolds() end }
  },
  opts = {},
  init = function(_)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end
}

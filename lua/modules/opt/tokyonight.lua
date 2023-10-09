M = {}

M.lazy = {
  'folke/tokyonight.nvim',
  config = function() require('tokyonight').setup({
    style = 'storm'
  }) end}

return M

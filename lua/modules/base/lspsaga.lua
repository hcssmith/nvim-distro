M = {}

local loader = require('modules.base.loader')


M.lazy = {
    'nvimdev/lspsaga.nvim',
    --cond = NotWindows,
    config = function()
        require('lspsaga').setup({
            symbol_in_winbar = {
              enable = false
            }
        })
    end,
  }

return M

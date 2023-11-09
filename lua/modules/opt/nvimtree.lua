M = {}

M.lazy = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      view = {
        adaptive_size = true
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    },
    lazy = true,
    keys = {
      {'<leader>e', function ()
        local api = require('nvim-tree.api')
        api.tree.toggle()
      end, desc = 'Toggle nvim-tree'}
    },
    config = function (_, opts)
      require("nvim-tree").setup(opts)
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', {bg='none'})
    end
  }

return M

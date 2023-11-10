M = {}

M.lazy = {
  'sidebar-nvim/sidebar.nvim',
  keys = {
    {'<leader>e', function ()
      local api = require('sidebar-nvim')
      api.toggle()
    end}
  },
  opts = {
    sections = {
      "git",
      "files",
      "todos",
      "buffers"
    },
  }
}

return M

return {
  'sidebar-nvim/sidebar.nvim',
  enabled = false,
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

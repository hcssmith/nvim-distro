M = {}


M.keymap = {
    normal = {
      {'<leader>e', function ()
	      local api = require('sidebar-nvim')
        api.toggle()
      end}
    }
}

M.lazy = {
    'sidebar-nvim/sidebar.nvim',
    config = function() require("sidebar-nvim").setup({
      sections = {
        "git",
        "files",
        "todos",
        "buffers"
      },
    }) end
  }

return M

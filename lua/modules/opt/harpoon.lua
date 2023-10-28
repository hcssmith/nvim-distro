
M = {}

M.keymap = {
  normal = {
    {'<leader>hl', require("harpoon.ui").toggle_quick_menu() },
    {'<leader>hm', require("harpoon.mark").add_file() },
    {'<leader>h1', require("harpoon.ui").nav_file(1) },
    {'<leader>h2', require("harpoon.ui").nav_file(2) },
    {'<leader>h3', require("harpoon.ui").nav_file(3) }
  }
}

M.lazy = {
  'ThePrimeagen/harpoon',
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
  },
  config = function () require('harpoon').setup({}) end
}

return M

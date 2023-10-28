
M = {}

M.keymap = {
  normal = {
    {'<leader>hl', function () require("harpoon.ui").toggle_quick_menu() end },
    {'<leader>hm', function () require("harpoon.mark").add_file() end},
    {'<leader>h1', function () require("harpoon.ui").nav_file(1) end},
    {'<leader>h2', function () require("harpoon.ui").nav_file(2) end},
    {'<leader>h3', function () require("harpoon.ui").nav_file(3) end}
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

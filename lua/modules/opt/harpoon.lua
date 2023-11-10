
M = {}


M.lazy = {
  'ThePrimeagen/harpoon',
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
  },
  keys = {
    {'<leader>hl', function () require("harpoon.ui").toggle_quick_menu() end },
    {'<leader>hm', function () require("harpoon.mark").add_file() end},
    {'<leader>h1', function () require("harpoon.ui").nav_file(1) end},
    {'<leader>h2', function () require("harpoon.ui").nav_file(2) end},
    {'<leader>h3', function () require("harpoon.ui").nav_file(3) end},
    {'<leader>h4', function () require("harpoon.ui").nav_file(4) end},
    {'<leader>h5', function () require("harpoon.ui").nav_file(5) end},
    {'<leader>h6', function () require("harpoon.ui").nav_file(6) end},
    {'<leader>h7', function () require("harpoon.ui").nav_file(7) end},
    {'<leader>h8', function () require("harpoon.ui").nav_file(8) end},
    {'<leader>h9', function () require("harpoon.ui").nav_file(9) end}
  },
  config = true,
}

return M

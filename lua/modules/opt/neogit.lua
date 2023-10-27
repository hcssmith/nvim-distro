
M = {}

M.Keymaps = {
  normal = {
    {"<leader>ng", function () require('neogit').open() end}
  }
}

M.lazy = {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  config = function ()
    require("neogit").setup({

    })
  end
}
return M

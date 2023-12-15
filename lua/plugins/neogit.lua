---@type LazyPluginSpec
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  keys = {
    {"<leader>ng", function () require('neogit').open() end}
  },
  lazy = true,
  config = function ()
    require("neogit").setup({

    })
  end
}

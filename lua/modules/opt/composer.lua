M = {}

M.keymap = {
    normal = {
      {"<leader>m", function() require('NeoComposer.telescope.macros').show_macros() end}
    }
  }
M.lazy = {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  config = function ()
    require("NeoComposer").setup({})
    require('telescope').load_extension('macros')
  end
}

return M

return  {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  lazy = true,
  keys = {
      {"<leader>m", function() require('NeoComposer.telescope.macros').show_macros() end}
  },
  config = true,
}

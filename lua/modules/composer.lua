return  {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  cond = NotWindows,
  lazy = true,
  keys = {
      {"<leader>m", function() require('NeoComposer.telescope.macros').show_macros() end}
  },
  config = true,
}

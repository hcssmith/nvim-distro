return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts  = {
    options = {
      theme = require('core').Opts.Theme,
      icons_enabled = true,
    },
    sections = {
      lualine_a = {
        { 'require("NeoComposer.ui").status_recording()' },
        'mode'
      },
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {
        {
          'filename',
          cond = require('core.util.functions').LspInactive
        },
        {
          'require("lspsaga.symbol.winbar").get_bar()',
          cond = require('core.util.functions').LspActive
        },
        "require'lsp-status'.status()",
      },
    }
  },
  dependencies = {
    'nvim-lua/lsp-status.nvim',
  }
}

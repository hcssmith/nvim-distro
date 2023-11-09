M = {}

local loader = require('modules.base.loader')
local lsp = require('modules.base.lsp')

M.lazy = {
    'nvim-lualine/lualine.nvim',
    config = function() require'lualine'.setup{
      options = {
        theme = loader.Opts.Theme,
        icons_enabled = true,
      },
      sections = {
        lualine_a = {
          { require('NeoComposer.ui').status_recording },
          'mode'
          },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            cond = lsp.LspInactive
          },
          {
            'require("lspsaga.symbol.winbar").get_bar()',
            cond = lsp.LspActive
          },
          "require'lsp-status'.status()",
          },
      }
    } end,
    dependencies = {
      'nvim-lua/lsp-status.nvim'
    }
  }

return M

require('core.util.env')
M = {}

local loader = require('modules.base.loader')

M.lazy = {
    'nvim-treesitter/nvim-treesitter',
    cond = HasCCompiler,
    build = ":TSUpdate",
    config = function () require'nvim-treesitter.configs'.setup({
      ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "odin", "markdown", "markdown_inline" },
      modules = {},
      ignore_install = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {
          "make"
        },
      },
    }) end
  }

return M

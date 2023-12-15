---@type LazyPluginSpec
return {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  keys = {
      {"<leader>pd", function () require('lspsaga.definition'):init(1, 1) end},
      {"<leader>ca", function () require('lspsaga.codeaction'):code_action() end},
      {"<leader>o", function () require('lspsaga.symbol'):outline() end},
      {"K", function () require('lspsaga.hover'):render_hover_doc() end}
  },
  opts = {
    symbol_in_winbar = {
      enable = false
    }
  }
}

---@type LazyPluginSpec
return {
  'williamboman/mason-lspconfig.nvim',
  opts = function()
    local lsp_zero = require('lsp-zero')
    return {
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function(_)
          require('lspconfig').lua_ls.setup({
            settings = {
              Lua = {
                hint = {
                  enable = true,
                  arrayIndex = 'Enable',
                  paramName = 'All',
                  paramType = true,
                  semicolon = 'All',
                  setType = true,
                }
              }
            }
          })
        end
      }
    }
  end
}

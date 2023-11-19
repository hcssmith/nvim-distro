return {
  'williamboman/mason-lspconfig.nvim',
  opts = function()
    local lsp_zero = require('lsp-zero')
    return {
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      }
    }
  end
}

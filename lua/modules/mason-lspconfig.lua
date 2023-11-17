return {
  'williamboman/mason-lspconfig.nvim',
  opts = function ()
    local lsp_zero = require('lsp-zero')
    return {
      handlers = {
        lsp_zero.default_setup
      }
    }
    end
}

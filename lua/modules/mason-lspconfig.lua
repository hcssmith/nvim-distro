return {
  'williamboman/mason-lspconfig.nvim',
  opts = function()
    local lsp_zero = require('lsp-zero')
    return {
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function(_)
          require('lspconfig').lua_ls.setup({
            on_attach = function(client, bufnr)
              vim.api.nvim_create_augroup("lsp_augroup", { clear = true })

              vim.api.nvim_create_autocmd("InsertEnter", {
                buffer = bufnr,
                callback = function()
                  vim.api.nvim_set_hl(0, 'LspInlayHint', {fg='#ffffff'})
                  vim.g.inlay_hints_visible = true
                  vim.lsp.inlay_hint.enable(bufnr, true)
                end,
                group = "lsp_augroup",
              })
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = bufnr,
                callback = function()
                  vim.g.inlay_hints_visible = true
                  vim.lsp.inlay_hint.enable(bufnr, false)
                end,
                group = "lsp_augroup",
              })
            end,
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

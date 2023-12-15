---@type LazyPluginSpec
return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  lazy = true,
  config = function (_, _)
    local lsp_group = vim.api.nvim_create_augroup('LspUserAutoCmd', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Auto run lsp format on save if a lsp client with the correct capabilitiy is connected',
      group = lsp_group,
      ---@param ev AutoCmdEvent
      callback = function (ev)
        local clients = vim.lsp.get_clients({
          bufnr = ev.buf
        })
        for _, client in pairs(clients) do
          if client.attached_buffers[ev.buf] == true and client.server_capabilities.documentFormattingProvider then
            vim.lsp.buf.format()
            return
          end
        end
      end
    })
  end,
  keys = {
    { "gd",          vim.lsp.buf.definition },
    { "<leader>vws", vim.lsp.buf.workspace_symbol },
    { "<leader>vd",  vim.diagnostic.open_float },
    { "[d",          vim.diagnostic.goto_next },
    { "]d",          vim.diagnostic.goto_prev },
    { "<leader>vca", vim.lsp.buf.code_action },
    { "<leader>vrr", vim.lsp.buf.references },
    { "<leader>vrn", vim.lsp.buf.rename },
    { "<leader>vf",  vim.lsp.buf.format },
  },
  dependencies = {
    { 'folke/neodev.nvim' },
    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig' }
  }
}

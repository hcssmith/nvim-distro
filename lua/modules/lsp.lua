return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  lazy = true,
  config = false,
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

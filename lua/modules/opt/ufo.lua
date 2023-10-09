M = {}

M.keymap = {
  normal = {
    {'zR', function () require('ufo').openAllFolds() end},
    {'zM', function () require('ufo').closeAllFolds() end}
  }
}

function M:settings()
  vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
      capabilities = capabilities
      -- you can add other fields for setting up lsp server in this table
    })
  end
  require('ufo').setup()
end

M.lazy = {
  'kevinhwang91/nvim-ufo',
  --cond = NotWindows,
  dependencies = {
    'kevinhwang91/promise-async'
  }
}

return M

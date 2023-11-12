M = {}

function LspActive()
  local lsp_clients = vim.lsp.get_clients({bufnr=0})
  if #lsp_clients > 0 then
    return true
  else
    return false
  end
end

function LspInactive()
  return not LspActive()
end

return M

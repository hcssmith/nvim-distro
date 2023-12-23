---@type LazyPluginSpec
return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  lazy = true,
  init = function(_)
    local ns = vim.api.nvim_create_namespace('LspUserHighlights')
    vim.api.nvim_set_hl(ns, 'LspInlayHint', { fg = '#ffffff' })
  end,
  config = function(_, _)
    local lsp_group = vim.api.nvim_create_augroup('LspUserAutoCmd', {})

    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Auto run lsp format on save if a lsp client with the correct capabilitiy is connected',
      group = lsp_group,
      ---@param ev AutoCmdEvent
      callback = function(ev)
        local clients = vim.lsp.get_clients({
          bufnr = ev.buf
        })
        for _, client in pairs(clients) do
          if client.attached_buffers[ev.buf] == true and client.server_capabilities.documentFormattingProvider then
            local view = vim.fn.winsaveview()
            vim.lsp.buf.format()
            vim.diagnostic.enable(ev.buf)
            ---Issue with multiple functions same name, problem with LSP?
            ---@diagnostic disable-next-line param-type-mismatch
            vim.fn.winrestview(view)
          end
        end
      end
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
      desc = 'Enable Inlay hints if a LSP with the capability is attached.',
      group = lsp_group,
      ---@param ev AutoCmdEvent
      callback = function(ev)
        local clients = vim.lsp.get_clients({
          bufnr = ev.buf
        })
        for _, client in pairs(clients) do
          if client.attached_buffers[ev.buf] == true and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(ev.buf, true)
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      desc = 'Disable inlay hints if enabled once leaving insert mode.',
      group = lsp_group,
      ---@param ev AutoCmdEvent
      callback = function(ev)
        if vim.lsp.inlay_hint.is_enabled(ev.buf) then
          vim.lsp.inlay_hint.enable(ev.buf, false)
        end
      end,
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

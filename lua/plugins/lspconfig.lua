---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  init = function(self)
    local lsp_group = vim.api.nvim_create_augroup('LspUserAutoCmd', {})
    local lsp_inlay_hint_ns = vim.api.nvim_create_namespace('vim_lsp_inlayhint')

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'Setup Lsp keybindings on buffer when LSP is attached',
      group = lsp_group,
      ---@param ev AutoCmdEvent
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>vf", vim.lsp.buf.format, opts)
      end
    })

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
            vim.api.nvim_set_hl(lsp_inlay_hint_ns, 'LspInlayHint', { fg = '#ffffff' })
            vim.api.nvim_set_hl_ns(lsp_inlay_hint_ns)
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
  dependencies = {
    {
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
      'folke/neodev.nvim',
    },
  },
  opts = function(_, _)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    return {
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities
          })
        end,
        lua_ls = function(server_name)
          require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
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
  end,
  config = function(_, opts)
    require('mason').setup({})
    require('mason-lspconfig').setup(opts)
  end
}

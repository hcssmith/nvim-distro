---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
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
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>vf", vim.lsp.buf.format, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>vqf', vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<leader>pd", function() require('lspsaga.definition'):init(1, 1) end, opts)
        vim.keymap.set("n", "<leader>ca", function() require('lspsaga.codeaction'):code_action() end, opts)
        vim.keymap.set("n", "<leader>o", function() require('lspsaga.symbol'):outline() end, opts)
        vim.keymap.set("n", "K", function() require('lspsaga.hover'):render_hover_doc() end, opts)
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
      'nvimdev/lspsaga.nvim',
      {
        'ray-x/lsp_signature.nvim',
        opts = {}
      }
    },
  },
  opts = function(_, _)
    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    local function default_on_attach(_, bufnr)
      require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
          border = "rounded"
        }
      }, bufnr)
    end
    return {
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = default_capabilities,
            on_attach = default_on_attach
          })
        end,
        lua_ls = function(_)
          require('lspconfig').lua_ls.setup({
            capabilities = default_capabilities,
            on_attach = default_on_attach,
            settings = {
              Lua = {
                hint = {
                  enable = true,
                  arrayIndex = 'Enable',
                  paramName = 'All',
                  paramType = true,
                  semicolon = 'Disable',
                  setType = true,
                },
                completion = {
                  callSnippet = "Replace"
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
    require("neodev").setup({})
    require('mason-lspconfig').setup(opts)
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false
      }
    })
  end
}

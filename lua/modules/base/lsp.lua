M = {}

local loader = require('modules.base.loader')

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



function M:settings()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")

  lsp.ensure_installed({
    'lua_ls',
  })

  local cmp = require('cmp')
  local cmp_select = {behavior = cmp.SelectBehavior.Select}
  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  })


  lsp.setup_nvim_cmp({
    mapping = cmp_mappings
  })

  lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
      }
  })

  local lsp_opts = {remap = false}
  local keymaps = {
    normal = {
      {"gd", vim.lsp.buf.definition,lsp_opts},
      {"<leader>vws", vim.lsp.buf.workspace_symbol, lsp_opts},
      {"<leader>vd", vim.diagnostic.open_float, lsp_opts},
      {"[d", vim.diagnostic.goto_next, lsp_opts},
      {"]d", vim.diagnostic.goto_prev, lsp_opts},
      {"<leader>vca", vim.lsp.buf.code_action, lsp_opts},
      {"<leader>vrr", vim.lsp.buf.references, lsp_opts},
      {"<leader>vrn", vim.lsp.buf.rename, lsp_opts},
      {"<leader>pd", function () require('lspsaga.definition'):init(1, 1) end, lsp_opts},
      {"<leader>ca", function () require('lspsaga.codeaction'):code_action() end, lsp_opts},
      {"<leader>o", function () require('lspsaga.symbol'):outline() end, lsp_opts},
      {"K", function () require('lspsaga.hover'):render_hover_doc() end, lsp_opts}
    },
    insert = {
      {"<C-h>", vim.lsp.buf.signature_help, lsp_opts}
    }
  }

  lsp.on_attach(function(client, bufnr)
    loader.SetKeymaps(loader, keymaps, bufnr)
    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end
  end)

  lsp.setup()

  vim.diagnostic.config({
      virtual_text = true,
  })

  local lspconfig = require('lspconfig')

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        },
        workspace = {
          checkThirdParty = false,
        },
      }
    }
  })

end

M.lazy = {
    'VonHeikemen/lsp-zero.nvim',
    --cond = NotWindows,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      {'folke/neodev.nvim',opts = {}}
    }
  }

return M

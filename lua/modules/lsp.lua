return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
    --cond = NotWindows,
    keys = {
      {"gd", vim.lsp.buf.definition},
      {"<leader>vws", vim.lsp.buf.workspace_symbol},
      {"<leader>vd", vim.diagnostic.open_float},
      {"[d", vim.diagnostic.goto_next},
      {"]d", vim.diagnostic.goto_prev},
      {"<leader>vca", vim.lsp.buf.code_action},
      {"<leader>vrr", vim.lsp.buf.references},
      {"<leader>vrn", vim.lsp.buf.rename},
    },
    dependencies = {
      {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
      },
      {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
          {'L3MON4D3/LuaSnip'},
        },
        config = function()
          -- Here is where you configure the autocompletion settings.
          local lsp_zero = require('lsp-zero')
          lsp_zero.extend_cmp()

          -- And you can configure cmp even more, if you want to.
          local cmp = require('cmp')
          local cmp_action = lsp_zero.cmp_action()

          cmp.setup({
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
              ['<CR>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace
              }),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-f>'] = cmp_action.luasnip_jump_forward(),
              ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            })
          })
        end
      },
      {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
          {'hrsh7th/cmp-nvim-lsp'},
          {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
          -- This is where all the LSP shenanigans will live
          local lsp_zero = require('lsp-zero')
          lsp_zero.extend_lspconfig()

          lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
          end)

          require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
              lsp_zero.default_setup,
              lua_ls = function()
                local lua_opts = lsp_zero.nvim_lua_ls({
                  settings = {
                    Lua = {
                      workspace = {
                        checkThirdParty = false,
                      },
                    },
                  }
                })
                require('lspconfig').lua_ls.setup(lua_opts)
              end,
            }
          })
        end
      },
      {'folke/neodev.nvim',opts = {}}
    }
  }

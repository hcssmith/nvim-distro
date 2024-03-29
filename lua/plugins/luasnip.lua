---@type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  build = 'make install_jsregexp',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { "rafamadriz/friendly-snippets" },
  keys = {
    {
      '<C-j>',
      function()
        print('Next Item')
        local ls = require('luasnip')
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end,
      mode = { 'i', 's' }
    },
    {
      '<C-k>',
      function()
        local ls = require('luasnip')
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      mode = { 'i', 's' }
    },
    {
      '<C-c>',
      function()
        local ls = require('luasnip')
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      mode = { 's', 'i' }
    },
  },
  opts = function()
    local types = require("luasnip.util.types")
    return {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "", "@class" } },
            hl_mode = "combine"
          },
          passive = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          visited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          unvisited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          }
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "󰦨", "@class" } },
            hl_mode = "combine"
          },
          passive = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          visited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          unvisited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          }
        },
        [types.functionNode] = {
          active = {
            virt_text = { { "󰊕", "@class" } },
            hl_mode = "combine"
          },
          passive = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          visited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          },
          unvisited = {
            virt_text = { { "", "@comment" } },
            hl_mode = "combine"
          }
        },
      },
    }
  end,
  config = function(_, opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    if Test == true then
      require("luasnip.loaders.from_lua").load({ paths = CustomBaseDir .. '/snippets' })
    else
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath('config') .. '/snippets' })
    end
    require("luasnip").setup(opts)
  end,
}

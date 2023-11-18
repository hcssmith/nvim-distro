return {
  "L3MON4D3/LuaSnip",
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  dependencies = { "rafamadriz/friendly-snippets" },
  keys = {
    {
      '<Tab>',
      function()
        local ls = require('luasnip')
        if ls.jumpable(1) then
          ls.jump(1)
        else
          local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
          vim.api.nvim_feedkeys(key, 'n', false)
        end
      end,
      mode = {'i', 's'}
    },
    {
      '<S-Tab>',
      function()
        local ls = require('luasnip')
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      mode = {'i', 's'}
    },
    {
      '<C-k>',
      function()
        local ls = require('luasnip')
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      mode = {'s', 'i'}
    }
  },
  config = function(_, _)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Ensure snippets load when in worktree TODO: find a better solution than
    -- this
    if Test == true then
      require("luasnip.loaders.from_lua").load({ paths = CustomBaseDir .. '/snippets' })
    end
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath('config') .. '/snippets' })
    require('luasnip').config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true
    })
  end
}

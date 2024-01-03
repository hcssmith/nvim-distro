---@type LazyPluginSpec
return {
  'folke/trouble.nvim',
  opts = {},
  keys = {
    {
      '<leader>tt', function() require('trouble').toggle() end
    },
    {
      '<M-n>',
      function()
        require('trouble').next({
          skip_groups = true,
          jump = true,
        })
      end,
      mode = {
        'n', 'i'
      }
    },
    {
      '<M-p>',
      function()
        require('trouble').previous({
          skip_groups = true,
          jump = true,
        })
      end,
      mode = {
        'n', 'i'
      }
    },
    {
      'gd', function() require("trouble").toggle("lsp_definitions") end
    },
    {
      '<leader>tl', function() require("trouble").toggle('workspace_diagnostics') end
    },
  }
}

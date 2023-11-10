return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      view = {
        adaptive_size = true
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    },
    lazy = true,
    keys = {
      {'<leader>e', function ()
        local api = require('nvim-tree.api')
        api.tree.toggle()
      end, desc = 'Toggle nvim-tree'}
    },
    init = function ()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      local augroup = vim.api.nvim_create_augroup('nvim_tree_cmds', {clear = true})
      vim.api.nvim_create_autocmd('BufEnter', {
        group = augroup,
        desc = 'Open NvimTree on Dir',
        callback = function(event)
          if vim.fn.isdirectory(vim.api.nvim_buf_get_name(event.buf)) ~= 0 then
            require('nvim-tree.api').tree.open()
          end
        end
      })
    end,
    config = function (_, opts)
      require("nvim-tree").setup(opts)
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', {bg='none'})
    end
  }

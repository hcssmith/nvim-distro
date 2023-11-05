M = {}


M.keymap = {
    normal = {
      {'<leader>e', function ()
	local api = require('nvim-tree.api')
        api.tree.toggle()
      end}
    }
}

function M.settings()
  --vim.highlight.create('NvimTreeNormal', {guibg='none'})
  vim.api.nvim_set_hl(0, 'NvimTreeNormal', {bg='none'})
end

M.lazy = {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function() require("nvim-tree").setup({
      view = {
        adaptive_size = true
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    }) end
  }

return M

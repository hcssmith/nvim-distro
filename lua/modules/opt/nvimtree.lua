M = {}

M.keymap = {
    normal = {
      {'<leader>e', ':NvimTreeFindFileToggle<CR>'}
    }
}

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

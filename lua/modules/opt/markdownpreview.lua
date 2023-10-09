M = {}

M.keymap = {
    normal = {
      {"<leader>pv", ":MarkdownPreviewToggle<CR>"}
    }
  }

M.lazy = {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  }

return M

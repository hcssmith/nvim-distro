M = {}

M.lazy = {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    lazy = 'VeryLazy',
    keys = {
      {"<leader>pv", ":MarkdownPreviewToggle<CR>"}
    }
  }

return M

---@type LazyPluginSpec
return {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    event = 'VeryLazy',
    keys = {
      {"<leader>pv", ":MarkdownPreviewToggle<CR>"}
    }
  }

M = {}

M.lazy = {
  'Mofiqul/dracula.nvim',
  config = function ()
    require('dracula').setup({
      italic_comment = true, -- default false
    })
  end
}

return M

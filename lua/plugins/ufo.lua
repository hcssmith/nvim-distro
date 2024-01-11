---@type LazyPluginSpec
return {
  'kevinhwang91/nvim-ufo',
  --cond = NotWindows,
  event = { 'BufEnter' },
  dependencies = {
    'kevinhwang91/promise-async',
    'nvim-treesitter/nvim-treesitter'
  },
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end },
    { 'zM', function() require('ufo').closeAllFolds() end }
  },
  opts = function(_, _)
    return {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          curWidth = chunkWidth + curWidth
          if targetWidth > curWidth + chunkWidth then
            chunk[2] = '@comment'
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. ('·'):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
        end
        table.insert(newVirtText, { suffix, '@comment' })
        local spacing = (width - sufWidth - curWidth)
        local pad = ('·'):rep(spacing)
        table.insert(newVirtText, {
          pad,
          '@comment'
        })
        return newVirtText
      end
    }
  end,
  init = function(_)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end
}

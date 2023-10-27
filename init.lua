local base_dir = "~/.config/nvim"

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:prepend(base_dir)
end

local mtl = {
  'modules.opt.dracula',
  'modules.opt.gitsigns',
  'modules.opt.gitworktree',
  'modules.opt.nvimtree',
  'modules.opt.vimtex',
  'modules.opt.ufo',
  'modules.opt.noice'
}

require('setup'):init(nil, mtl)

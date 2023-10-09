local base_dir = "~/Projects/distro"

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:prepend(base_dir)
end
local mtl = {
  'modules.opt.dracula',
  'modules.opt.gitsigns',
  'modules.opt.markdownpreview',
  'modules.opt.nvimtree',
  'modules.opt.vimtex',
  'modules.opt.ufo',
}

require('setup'):init(nil, mtl)

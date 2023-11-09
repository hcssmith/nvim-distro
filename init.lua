local base_dir = "~/.config/nvim"

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) and Test~=true then
  vim.opt.rtp:prepend(base_dir)
end

local mtl = {
  'modules.opt.dracula',
  'modules.opt.composer',
  'modules.opt.gitsigns',
  'modules.opt.gitworktree',
  'modules.opt.neogit',
  'modules.opt.nvimtree',
  'modules.opt.vimtex',
  'modules.opt.ufo',
  'modules.opt.noice',
  'modules.opt.harpoon'
}

require('setup'):init(nil, mtl)

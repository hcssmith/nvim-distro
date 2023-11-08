local base_dir = "~/.config/nvim"

--if Test ~= true then Test = false end

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) and Test==false then
  vim.opt.rtp:prepend(base_dir)
end

local mtl = {
  'modules.opt.dracula',
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

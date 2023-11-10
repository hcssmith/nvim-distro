local base_dir = "~/.config/nvim"

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) and Test~=true then
  vim.opt.rtp:prepend(base_dir)
end


require('setup'):init(nil)

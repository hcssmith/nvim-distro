require('core.util.env')
require('setup.vars')

local lazy = require('modules.lazy')
local loader = require('modules.base.loader')

local M = {}

local function general_settings(opts)
  vim.o.termguicolors = true
  vim.cmd.colorscheme(opts.Theme)

  vim.opt.nu = true
  vim.opt.relativenumber = true

  vim.opt.tabstop = opts.TabWidth
  vim.opt.softtabstop = opts.TabWidth
  vim.opt.shiftwidth = opts.TabWidth
  vim.opt.expandtab = true

  vim.opt.smartindent = true

  vim.opt.wrap = true
  vim.opt.textwidth = opts.TextWidth

  vim.opt.hlsearch = false
  vim.opt.incsearch = true

  vim.cmd.set("splitbelow")
  vim.cmd.set("splitright")

  vim.opt.swapfile = false
  vim.opt.backupdir = opts.Home .. "/.vim/backupdir"
  vim.opt.undodir = opts.Home .. "/.vim/undodir"
  vim.opt.undofile = true


  vim.opt.scrolloff = 4
  vim.opt.signcolumn = "yes"
  vim.opt.isfname:append("@-@")
end

local base_modules = {
  'modules.lazy',
  'modules.base',
  'modules.base.dashboard',
  'modules.base.lsp',
  'modules.base.lspsaga',
  'modules.base.lualine',
  'modules.base.telescope',
  'modules.base.treesitter',
  'modules.base.neorg',
}



function M:init(opts, modules_to_load)
  if opts == nil then opts = {} end

  setmetatable(opts, {__index = Vars})

  if opts.Home == nil then
    opts.Home = os.getenv(Home())
  end

  opts.OneDrive = os.getenv('OneDrive')

  loader.Opts = opts

  -- Set mapleader before anything else (required for Lazy)
  vim.g.mapleader = opts.MapLeader

  lazy:Init()

  for _, v in ipairs(base_modules) do
    loader:Load(v)
  end
  for _, v in ipairs(modules_to_load) do
    loader:Load(v)
  end

  lazy:Run(opts)

  general_settings(opts)
  
  loader:ApplySettings()

end



return M

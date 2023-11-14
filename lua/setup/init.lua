require('core.util.env')
require('setup.vars')

local lazy = require('core.lazy')
local global = require('core.global')

local M = {}

function M:init(opts)
  if opts == nil then opts = {} end

  Vars.__index = Vars

  setmetatable(opts, Vars)

  if opts.Home == nil then
    opts.Home = os.getenv(Home())
  end

  opts.OneDrive = os.getenv('OneDrive')

  global.Opts = opts

  -- Set mapleader before anything else (required for Lazy)
  vim.g.mapleader = opts.MapLeader

  lazy:Init()

  lazy:Run(opts)

end



return M

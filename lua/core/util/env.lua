---@return string
function Home()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "HOMEPATH"
  else
    return "HOME"
  end
end

---@return boolean
function HasCCompiler()
  local comilers = {"cc", "gcc", "cl", "zig", "clang"}
  for _, cmp in ipairs(comilers) do
    if vim.fn.executable(cmp) == 1 then return true end
  end
  return false
end

---@return string
function NotesDir()
  local global = require('core.global')
  local path = ""
  if global.Opts.OneDrive  == nil then
    path = global.Opts.Home .. global.Opts.NotesDir
  else
    path = global.Opts.OneDrive .. global.Opts.NotesDir
  end
  return path
end

---@return boolean
function NotWindows()
    if vim.loop.os_uname().sysname == "Windows_NT" then
      return false
    end
    return true
end


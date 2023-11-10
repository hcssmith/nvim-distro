
function Home()
  if vim.loop.os_uname().sysname == "Windows_NT" then
    return "HOMEPATH"
  else
    return "HOME"
  end
end

function HasCCompiler()
  local comilers = {"cc", "gcc", "cl", "zig", "clang"}
  for _, cmp in ipairs(comilers) do
    if vim.fn.executable(cmp) == 1 then return true end
  end
  return false
end

function NotesDir()
  local core = require('core')
  local path = ""
  if core.Opts.OneDrive  == nil then
    path = core.Opts.Home .. core.Opts.NotesDir
  else
    path = core.Opts.OneDrive .. core.Opts.NotesDir
  end
  return path
end



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


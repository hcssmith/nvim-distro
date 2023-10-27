
M = {}

M.keymap = {
    normal = {
      {'<leader>gwc', function () require('telescope').extensions.git_worktree.create_git_worktree() end},
      {'<leader>gwl', function () require('telescope').extensions.git_worktree.git_worktrees() end},
    }
  }

function M.settings()
  local Worktree = require("git-worktree")

  Worktree.on_tree_change(function(op, metadata)
    if op == Worktree.Operations.Switch then
      print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    elseif Worktree.Operations.Delete then
      print("Deleted worktree: " .. metadata.path)
    elseif Worktree.Operations.Create then
      print("Create new worktree " .. metadata.path .. " from " .. metadata.branch)
    end
  end)
end

M.lazy = {
    'ThePrimeagen/git-worktree.nvim',
    config = function () require('git-worktree').setup({

    }) end
}

return M

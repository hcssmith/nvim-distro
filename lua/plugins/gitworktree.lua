---@type LazyPluginSpec
return {
    'ThePrimeagen/git-worktree.nvim',
    keys = {
      {'<leader>gwc', function () require('telescope').extensions.git_worktree.create_git_worktree() end},
      {'<leader>gwl', function () require('telescope').extensions.git_worktree.git_worktrees() end},
    },
    lazy = true,
    config = true
  }

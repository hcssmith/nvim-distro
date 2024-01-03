---@type LazyPluginSpec
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      version = "^1.0.0"
    },
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = true,
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end },
    { '<leader>fb', function() require('telescope.builtin').buffers() end },
    { '<leader>gf', function() require('telescope.builtin').git_files() end },
    { '<leader>ps', function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end },
    { '<leader>vh', function() require('telescope.builtin').help_tags() end }
  },
  opts = function(self, opts)
    local trouble = require("trouble.providers.telescope")
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          n = {
            ["<C-t>"] = trouble.open_with_trouble
          },
          i = {
            ["<C-t>"] = trouble.open_with_trouble
          }
        },
      },
      pickers = {
        find_files = {
          mappings = {
            n = {
              ["cd"] = function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd(string.format("silent cd %s", dir))
              end,
            },
          }
        },
      }
    }
  end,
  config = function(_, opts)
    require('telescope').load_extension('live_grep_args')
    require("telescope").load_extension("git_worktree")
    require("telescope").load_extension("macros")
    require('telescope').setup(opts)
  end
}

M = {}

local loader = require('modules.base.loader')

M.keymap = {
    normal = {
      {'<leader>ff', function () require('telescope.builtin').find_files() end},
      {'<leader>fb', function () require('telescope.builtin').buffers() end},
      {'<leader>gf', function () require('telescope.builtin').git_files() end},
      {'<leader>ps', function () require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end },
      {'<leader>vh', function () require('telescope.builtin').help_tags() end}
    }
  }

M.lazy = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        version = "^1.0.0"
      }
    },
    config = function ()
      require('telescope').load_extension('live_grep_args')
      require("telescope").load_extension("git_worktree")
      require('telescope').setup({

      pickers = {
        find_files = {
          mappings = {
            n = {
              ["cd"] = function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                require("telescope.actions").close(prompt_bufnr)
                -- Depending on what you want put `cd`, `lcd`, `tcd`
                vim.cmd(string.format("silent cd %s", dir))
              end
            }
          }
        },
      }
    }) end
  }

return M

---@type LazyPluginSpec
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  cond = HasCCompiler,
  init = function(_)
    local augroup = vim.api.nvim_create_augroup("NeorgAutoCommands", {})

    vim.api.nvim_create_autocmd("BufReadPost", {
      desc = 'Collapse all folds when Lsp is attached',
      group = augroup,
      pattern = { '*.norg' },
      ---@param ev AutoCmdEvent
      callback = function(ev)
        require('ufo.main').attach(ev.buf)
        require('ufo').closeAllFolds()
      end
    })
  end,
  ft = 'norg',
  cmd = 'Neorg',
  opts = {
    load = {
      ["core.defaults"] = {},  -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.itero"] = {},
      ["core.promo"] = {},
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.remap_event('norg', 'n', keybinds.leader .. 'nd', 'core.qol.todo_items.todo.task_done')
            keybinds.remap_event('norg', 'n', keybinds.leader .. 'nc', 'core.qol.todo_items.todo.task_cycle')
            keybinds.remap_event('norg', 'n', keybinds.leader .. 'nh', 'core.qol.todo_items.todo.task_on_hold')
            keybinds.remap_event('norg', 'n', keybinds.leader .. 'nr', 'core.qol.todo_items.todo.task_recurring')
            keybinds.remap_event('norg', 'n', keybinds.leader .. 'lt', 'core.pivot.toggle-list-type')
          end
        }
      },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = NotesDir(),
          },
          default_workspace = "notes"
        },
      },
    },
  }
}

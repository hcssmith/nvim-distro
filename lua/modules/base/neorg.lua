require('core.util.env')

M = {}

local loader = require('modules.base.loader')

local function notes_dir()
  local path = ""
  if loader.Opts.OneDrive  == nil then
    path = loader.Opts.Home .. loader.Opts.NotesDir
  else
    path = loader.Opts.OneDrive .. loader.Opts.NotesDir
  end
  return path
end

M.lazy = {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = HasCCompiler,
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
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
                notes = notes_dir(),
              },
              default_workspace = "notes"
            },
          },
        },
      }
    end,
  }

return M

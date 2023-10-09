require('core.util.env')

M = {}

local loader = require('modules.base.loader')

local keymap = {
    normal = {
      {"<localleader>nd", ":Neorg keybind norg core.qol.todo_items.todo.task_done<CR>"},
      {"<localleader>nc", ":Neorg keybind norg core.qol.todo_items.todo.task_cycle<CR>"},
      {"<localleader>nh", ":Neorg keybind norg core.qol.todo_items.todo.task_on_hold<CR>"},
      {"<localleader>nr", ":Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>"},
      {"<localleader>lt", ":Neorg keybind norg core.pivot.toggle-list-type<CR>"}
    }
}

local function setup_neorg_bindings()
  vim.api.nvim_create_autocmd('FileType', {
	  desc = 'Setup neorg keybinds in neorg buffer only',
	  pattern = 'norg',
	  callback = function ()
      loader.SetKeymaps(loader, keymap, 0)
   end
  })
end

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
      setup_neorg_bindings()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.itero"] = {},
          ["core.promo"] = {},
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

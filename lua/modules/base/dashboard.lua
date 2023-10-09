M = {}

local loader = require('modules.base.loader')

local function footer()
  local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  local lazy_ok, lazy = pcall(require, "lazy")
  if lazy_ok then
    local total_plugins = lazy.stats().count .. " Plugins"
    local startuptime = (math.floor(lazy.stats().startuptime * 100 + 0.5) / 100)
    return version .. "   " .. total_plugins .. "  󰄉 " .. startuptime .. " ms"
  else
    return version
  end
end

local function config_files()
  local cwd = vim.fn.stdpath "config" .. "/"
  local config_dir = { cwd }

  require("telescope.builtin").find_files {
    prompt_title = "Config Files",
    search_dirs = config_dir,
    cwd = cwd,
  }
end


local function new_file()
  local fname = vim.fn.input("File: ", "", "file")
  if fname == "" then return end
  vim.cmd("e " .. fname)
end

local function serach_notes()
  require('telescope').extensions.live_grep_args.live_grep_args({
    search_dirs = {
      loader.Opts.NotesDir
    }
  })
end

local function launch_dashboard()
  require('nvim-tree.api').tree.close()
  vim.cmd(":Dashboard")
end

M.keymap = {
    normal = {
      {'<leader>db', function () launch_dashboard() end}
    }
  }


M.lazy = {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function() require('dashboard').setup({
    theme = "doom",
    config = {
      header = loader.Opts.Title,
      center = {
        {
          icon = '󰈔 ',
          icon_hl = 'Title',
          desc = 'New File                ',
          desc_hl = 'String',
          key = 'n',
          keymap = '\':e\'',
          key_hl = 'Number',
          action = function() new_file() end
        },
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Notes                   ',
          desc_hl = 'String',
          key = 'N',
          keymap = '',
          key_hl = 'Number',
          action = ':Neorg workspace notes'
        },
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Search Notes            ',
          desc_hl = 'String',
          key = 's',
          keymap = '',
          key_hl = 'Number',
          action = function() serach_notes() end
        },
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Find File               ',
          desc_hl = 'String',
          key = 'o',
          keymap = '\' ff\'',
          key_hl = 'Number',
          action = function () require('telescope.builtin').find_files() end
        },
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Config Files            ',
          desc_hl = 'String',
          key = 'c',
          keymap = '',
          key_hl = 'Number',
          action = function() config_files() end
        },
        {
          icon = '󰚰 ',
          icon_hl = 'Title',
          desc = 'Update Plugins          ',
          desc_hl = 'String',
          key = 'u',
          keymap = '\' lu\'',
          key_hl = 'Number',
          action = function () require('lazy').update() end
        },
        {
          icon = '󰩈 ',
          icon_hl = 'Title',
          desc = 'Quit                    ',
          desc_hl = 'String',
          key = 'q',
          keymap = '\':q\'',
          key_hl = 'Number',
          action = ':q'
        },
      },
      footer = {
        " ",
        " ", -- top padding
        footer()
      }
    }
    -- config
  })
end,
dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }

 return M

M = {}

M.lazy = {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  keys = {
    {'<leader>db', function ()
      local ok, api = pcall(require, 'nvim-tree.api')
      if ok then
        api.tree.close()
      end
      vim.cmd(":Dashboard")
    end}
  },
  opts = {
    theme = "doom",
    config = {
      header = require('modules.base.loader').Opts.Title,
      center = {
        {
          icon = '󰈔 ',
          icon_hl = 'Title',
          desc = 'New File                ',
          desc_hl = 'String',
          key = 'n',
          keymap = '\':e\'',
          key_hl = 'Number',
          action = function()
            local fname = vim.fn.input("File: ", "", "file")
            if fname == "" then return end
            vim.cmd("e " .. fname)
          end
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
          action = function()
            local l = require('modules.base.loader')
            require('telescope').extensions.live_grep_args.live_grep_args({
              search_dirs = {
                l.Opts.NotesDir
              }
            })
          end
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
          action = function()
            local cwd = vim.fn.stdpath "config" .. "/"
            local config_dir = { cwd }

            require("telescope.builtin").find_files {
              prompt_title = "Config Files",
              search_dirs = config_dir,
              cwd = cwd,
            }
          end
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
      footer = function ()
        local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local lazy_ok, lazy = pcall(require, "lazy")
        if lazy_ok then
          local total_plugins = lazy.stats().count .. " Plugins"
          local startuptime = (math.floor(lazy.stats().startuptime * 100 + 0.5) / 100)
          return { version .. "   " .. total_plugins .. "  󰄉 " .. startuptime .. " ms" }
        else
          return { version }
        end
      end
    }
  },
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

return M

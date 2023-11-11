return
{
  'nvim-treesitter/nvim-treesitter',
  cond = HasCCompiler,
  build = ":TSUpdate",
  event = 'BufRead',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  main = 'nvim-treesitter.configs',
  keys = {
    {'<leader>ts', function () vim.treesitter.inspect_tree() end},
    {'<leader>tq', function () vim.treesitter.query.edit() end}
  },
  opts = {
    ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "odin", "markdown", "markdown_inline", "query" },
    modules = {},
    ignore_install = {},
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = {
        "make"
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'none',
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ip"] = "@parameter.inner",
        },
        selection_modes = {
          ['@parameter.inner'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@function.inner'] = 'V', -- linewise
        },
        include_surrounding_whitespace = true,
      },
    }
  }
}

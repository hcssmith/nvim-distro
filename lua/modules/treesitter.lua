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
    {'<leader>ts',vim.treesitter.inspect_tree },
    {'<leader>tq', vim.treesitter.query.edit }
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
          ["a="] = "@assignment.outer",
          ["i="] = "@assignment.inner",
          ["l="] = "@assignment.lhs",
          ["r="] = "@assignment.rhs",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ip"] = "@parameter.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
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

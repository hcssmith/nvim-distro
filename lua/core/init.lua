M = {}

M.keymap = {
    insert = {
      {"jk", "<Esc>"}
    },
    terminal = {
      {"jk", "<C-\\><C-N>"}
    },
    normal = {
      {"<C-h>", "<C-W><C-h>"},
      {"<C-j>", "<C-W><C-j>"},
      {"<C-k>", "<C-W><C-k>"},
      {"<C-l>", "<C-W><C-l>"},
      {"<C-Left>", "<C-W><C-h>"},
      {"<C-Down>", "<C-W><C-j>"},
      {"<C-Up>", "<C-W><C-k>"},
      {"<C-Right>", "<C-W><C-l>"},
    }
}

return M

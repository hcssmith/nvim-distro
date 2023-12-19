# Nvim-Distro

## Intro
First we set the base_dir to be the config location, in case for some reason the
config needs to be installed elsewhere. To use in conjunction with another nvim
setup. We append this to the RTP and run the `init` function from the `setup`
module.

## Setup
In setup we store some global variables and the init function. In the init
function we merge the opts from the function and the standard variable set. We
also set the `Home` and `OneDrive` paths. We then pass the resultant settings
table into the global module to make it available to any plugins. We also set
the `leader` key to space here. Next we run the `lazy.nvim` initialisation, then
pass in the plugin directory.

## lazy
In the `init` function we check to see if lazy is installed, if it is not we
clone the latest stable branch of the `lazy.nvim` repo and make sure to add the
resultant path into `rtp`.

Next we have the `Run` function which you pass a string to in this case `plugins` 
this will load all plugins in the `lua/plugins` folder. Use the `lazy`lua 
snippet to create a return value on a file in the correct format. I have
extracted the `LazyPluginSpec` type from `lazy.nvim` to enable the lsp to
autosuggest the entries in a plugin specification.

## plugins
An explaination of each of the plugins that are installed, along with any
options that are specified.

### cmp
In `cmp.lua` we define a local function `set_hl()` which is used to style the
cmp completion menu. Primarily this allows for the lefthand block that indicates
the completion type.

CMP is laxy loaded on the `InserEnter` event. It depends on various completion
sources listed below as well as `lspkind` and `nvim-autopairs` lsp kind is used
for the icons in the completion menu, nvim-autopairs is used to automatically
insert a `()` at the end of a method / function completion, this is enbled in
the `config` function. In the config function we also run the `set_hl`
function and pass the opts table to `cmp.setup()` manually.

In `opts` we ensure the snippet provider is set to be `luasnip`. We enable some
basic mappings `C-b` / `C-f`: scroll documentation. `CR` to accept the
completion only when something is explicitly selected and `C-Space` to launch
the completion window if not currently triggered. We also style the menu by
removing any border removing all padding and setting the offset to be -3 this
should put the menu bellow the words being typed properly lined up. We also set
a couple of highlights to render the menu to be transparent.

We also configure the layout of the individual entries. We set it to be kind /
abbr / menu. kind we get from `lspkind`, menu we define a label for each CMP
source. abbr is provided by the CMP source.

#### sources
- `nvim_lsp` Get from an active LSP client, ignore any snippet types, as we get
   these from luasnip.
- `path` complete form paths on the system.
- `buffer` any words in the buffer, trigger on words longer than 5 letters.
- `luasnip` snippet provider
- `treesitter` completion based on treesitter parsing. useful for strings.

### composer
This is used to complement the macro functionalities within neovim. Providing
some additional utilites (notifications / register views). We use layy to bind
`<space>m` to the macros menu.

### dashboard
This is a pretty menu that is dispalyed when starting vim. It has shortcuts to
the notes dir, config, find files, new file, lazy update and quit.

### dracula
The dracula nvim theme, with the itallic comments options set to true.

### gitsigns
Display any changes to a file as tracked by git.

### gitworktree
Makes using wokrtrees easier.

### harpoon
Easily switch between a set of files, `<space>h(n)` for files `<space>hm` to
mark a file and `<space>hl` to list marked files.

### keybind
A custom plugin that contains my base keybinds (`jk`, Control movement etc. )
Will be expanded to allow custom keybinds in opts eventually.

### lsp
Lsp currently uses lsp-zero. I have setup an auto command to run 
`vim.lsp.buf.format()` whenever a client is attached which has the ability to
format a page. We also bind a few keys such as `gd`: Goto Definition.

### lspconfig
Is configured to load on Lsp Stat / Info and Install.

### lspsaga
A fancier UI for some LSP actions, I have chosed to use definition, codeaction,
outline & hover from this. I have disabled the symbol in winbar function as
well.

### lualine
This replaces the statusline, The theme is taken from globals, to ensure that
lualine & everything else matches. Icons are also enabled. The neocomposer
status is displayed alongside the mode. Next we have the branch / diff and
diagnostics list. After that we display the filename or the WinBar from LspSaga.
Then the LSP status. The reset of the lualine is the default config (encoding /
OS / filetype / location)

### luasnip
This is the snippet engine configured with CMP. I have setup `C-j/k` to move
through the insert points in the snippet, and `C-n` to cycle through the options
in a choice node. I have setup, via ext_ops, an indication as to what nodes
there are and what the types of said nodes are. Snippets are loaded from the
`filetype.lua` in `$CONFIG/snippets` loaded in the init section of the plugin
alongside the entries from FriendlySnippets.

### markdownpreview
A lazy loaded markdown previewer, loads on `<space>pv` key press.

### mason-lspconfig
Specific configurations for lsp servers. I have setup inlay hints in here,
though it only seems to wokr half of the time, I will need to do some further
investigation into the causes of this.

### mason
Lsp & treesitter installer.

### neodev
Poper LSP integration of the nvim api.

### neogit
Manage git from within nvim.

### neorg
Notes taking plugin, several keybinds are done in this to make handling task
items a bit easier. Also the core notes directory is defined from globals. 

### noice
Fancier UI in neovim. Some compatibilty options are set within here. Bottom
search / floating cms, message split are enabled whilst inc_rename &
lsp_doc_border are diabled. We also override the deault notifier with
`nvim-notify`

### nordic
Nordic UI theme.

### nvimsidebar
Disabled 

### nvim-tree
Tree based filebrowser in the sidebar, toggle with `<space>e`.

### setup
Core configuration options set through a plugin.

### telescope
A fuzzy finder used in multiple plugins, I have bound `<space>ff` to find files,
`<space>fb` to find buffers, `<space>gf` to git files and `<space>ps` to grep.

### tokyonight
Tokyonight theme.

### treesitter
context aware syntax highlighting. Enabled when going into a buffer. Also
enabled is textobjects to enable treesitter aware motions. 

### ufo
Lsp based code folding.

### vimtex
Latex help.




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

### 


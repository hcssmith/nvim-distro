# Nvim-Distro

## Intro
Designed to be a modular neovim configuration, each plugin is defined in
it's own file with a plugin table, a keymap table and a config function.

This allows for all parts of a plugin to be in the same area and esaily enabled
as a job lot

## Adding a module
In either opt or base add a neww file in the following format
```lua
M = {}

M.keymap = {
    normal = {
    { 'keys', function() --[[Actions]] end }
}

function M.settings()
    --general config
end

M.lazy = {
    --Lazy definition
}
return M
```
If this is in base, add the module string to the list in
lua/setup/init.lua:base_modules otherwise it will need to be 
added into the list in init.lua to be passed to the setup function

## setup
The setup:init() function takes in a table of globaly availble modules and a list of optional modules to load, the module must be in the include path somewhere. As part of this function we set various settings, some of which are controlled by the globals defined in setup.vars and overwritten by the table passed to setup:init()

### Steps in order
1. merge Global Vars & opts
2. Set opts.Home
3. Set opts.OneDrive path
4. pass all opts to loader for global access
5. set mapleader (required for lazy)
6. Initialise lazy (download & install if missing)
7. Load all base modules into module collection
8. load all optional modules into module collection
9. Install all modules
10. Apply all module settings (M.settings())
11. Apply general settings

## Modules
Description of all modules in the config

### Base Modules

#### modules.lazy
This module loads the lazy.nvim plugin manager (M:Init()) this adds in the lazy
installation path, checks if lazy is installed there and if it is not, it calls
git in order to install lazy.nvim to the lazy installation path.

We also have two helper functions to register a module into the plugin list
(M:RegisterModule(module)) and to then run lazyvim against the plugin list;
(M:Run(opts))

#### modules.base
This module contains the basic keymaps such as `jk` for escape and `C-Left /
Right` for movement. 

#### modules.base.dashboard
This loads the dashboard plugin, which is the landing page for `nvim` with no
file / path specified, I have keybinds on here to update plugins search config
files, search notes files, and open the Neorg notes. Menu entries are definied
in the lazy plugin specification. I have found that the menu action functions
are best setup in the lazy definition rather than as separate functions due to
issues with scope. I may be able to work arround this with proper requires, but
I have not yet tried this.

#### modules.base.loader
This is the core module that loads other modules, and applies keymaps and
settings. There are 3 functions in this module to be aware of, `Load`,
`SetKeymap` and `ApplySettings`

##### Load
Pass this function the path of a module, it will check if any keymaps are
definined, if they are it adds them to a table, likewise for settings and the
lazy plugin definition.

##### SetKeymap
`SetKeymap` runs through all fields in the table searching based on a defined
set of modes, any new modes required can be added in the modes table (longname,
keycode). Also passed to this function is an optional bufnr to apply keymaps to
secific buffers only.

##### ApplySettings
This runs all module settings functions and then applys any keymaps definied in
the module.

#### modules.base.lsp
This sets up the LSP environment, and the various required plugins. Aside from
the standard lazy / keymaps & settings we also define two functions to check if
a buffer has a LSP client running `LspActive` & `LspInactive`. There is nothing
special in the lazy definition, just the recommneded parts from the Lsp-Zero
plugin. In settings we configure keymaps on a buffer basis, only applying once
the LSP is started, there is also some configuraiton done to install Lsp clients
and completion key bindings

#### modules.base.lspsaga
This provides several useful features to compliment the usage of LSP, I have
used the breadcrumbs in the satus bar as well as Hover & show definition with
the keymaps being set in `modules.base.lsp`

#### modules.base.lualine
I have modified the default lualine confif to have the LSP breadcrumbs from
lspsaga dsipalyed if an LSP is loaded else it displays the filename. 

#### modules.base.Neorg
This is the Notes plugin, unusually keybinds are done using the method included
in the plugin rather than the keybind function it uses the inbuilt keybind
module. prefixes the kybinds with the local leaders and only performs the binds
in norg buffers.

#### modules.base.telescope
A fuzzy finder which can be easily integrated into other plugins, I have
keybinds for files, buffers, git files, grep results and help. I have also
overwitten the finf_files picker to cd into the directory that is picked.

#### modules.base.treesitter
This is the main module that provides syntax highliting via parsing the AST. I
have disabled this for Makefiles as I dislike the syntax highlighting provided
for this.

#### modules.opt.dracula
Dracula colour scheme, itallic comments set to true.

#### modules.opt.gitsigns
Git changes in the gutter, no other changes.

#### modules.opt.gitworktree
For managing worktree based workflows, a couple of keybinds and some hooks to
indicate what was done in a message.

#### modules.opt.markdownpreview
Preview markdown in a webbrowser. Keybind to launch.

#### modules.opt.noice
Fancy UI for neovim, notifications in popups, command line in popupi window, no
command line at the bottom.

#### modules.opt.nordic
Nordic colourscheme

#### modules.opt.nvimsidebar
Neovim sidebar with the following modules, git, files, todos, buffers.

#### modules.opt.nvimtree
Tree based file browser in sidebar, replaces netrw. Disable netrw once enabled.

#### modules.opt.tokyonight
Tokyonight colourscheme, storm option picked.

#### modules.opt.ufo
Lsp based code folding.

#### modules.opt.vimtex
LaTeX nvim utils.
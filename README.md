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
added into the list in init.lua to be passed to the setup function.

# setup
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

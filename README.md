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
The setup:init() function takes in a table of globaly availble modules and 
a list of optional modules to load, the module must be in the include path
somewhere. 

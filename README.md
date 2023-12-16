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

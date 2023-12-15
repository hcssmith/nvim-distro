local global = require('core.global').Opts

---@type LazyPluginSpec
return {
 'hcssmith/hcssmith-core-setup',
 opts = {
    Theme = global.Theme,
    Home = global.Home
 }
}

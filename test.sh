#!/usr/bin/env bash

cwd=$(pwd)

nvim -u "$cwd/init.lua" --cmd "lua vim.opt.rtp:prepend('$cwd')" --cmd "lua Test=true"

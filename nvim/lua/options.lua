require "nvchad.options"

-- add yours here!

local o = vim.o

o.mouse = 'a'
o.clipboard = 'unnamedplus'

o.shell = os.getenv('SHELL') or '/bin/bash'

o.number = true
o.relativenumber = true
o.cursorlineopt = 'both'
o.colorcolumn = '80'

o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

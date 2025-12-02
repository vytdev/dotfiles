local o = vim.o
local g = vim.g
local opt = vim.opt

-- misc
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.termguicolors = true
o.shell = os.getenv('SHELL') or '/usr/bin/bash'
-- opt.shortmess:append('sI')  -- disable startup screen

o.updatetime = 250
o.timeoutlen = 500
o.swapfile = true
o.undofile = true

o.splitkeep = 'screen'

-- gutter
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.signcolumn = 'yes'

-- other highlights
o.colorcolumn = '80'
o.cursorline = true
o.cursorlineopt = 'both'

-- search
o.ignorecase = true
o.smartcase = true

-- indentation
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true

-- folding
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has 'win32' ~= 0
local sep = is_windows and '\\' or '/'
local delim = is_windows and ';' or ':'
vim.env.PATH = table.concat({ vim.fn.stdpath 'data', 'mason', 'bin' }, sep) ..
                      delim .. vim.env.PATH

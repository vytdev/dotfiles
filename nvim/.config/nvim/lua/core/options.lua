local o = vim.o
local opt = vim.opt


-- misc
o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.termguicolors = true
o.shell = os.getenv('SHELL') or '/usr/bin/bash'
-- opt.shortmess:append('sI')  -- disable startup screen

o.updatetime = 250
o.timeoutlen = 500
o.splitkeep = 'screen'
opt.fillchars = { eob = ' ' }

o.ignorecase = true
o.smartcase = true


-- window-local
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    local wo = vim.wo
    local is_file = vim.bo.buftype == ''

    -- gutter stuff
    wo.number = is_file
    wo.relativenumber = is_file
    wo.numberwidth = 5
    wo.signcolumn = 'yes'

    -- cursorline
    wo.cursorline = is_file
    wo.cursorlineopt = 'number'
  end
})


-- buffer-local
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  callback = function()
    local bo = vim.bo
    local is_file = bo.buftype == ''

    bo.swapfile = is_file
    bo.undofile = is_file

    -- indentation
    bo.expandtab = is_file
    bo.smartindent = is_file
    bo.shiftwidth = 2
    bo.tabstop = 2
    bo.softtabstop = 2
  end
})


-- filetype-dependent
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    local wo = vim.wo
    local bo = vim.bo
    local is_file = bo.buftype == ''

    local ok = pcall(vim.treesitter.start)
    if not ok then return end

    -- folding
    wo.foldenable = is_file
    wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    wo.foldmethod = 'expr'
    wo.foldlevel = 99

    -- tree-sitter-based indentation
    -- bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

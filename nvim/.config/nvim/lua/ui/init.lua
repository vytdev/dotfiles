-- append color aliases
local hls = require'ui.hls'
hls.append_colors(require'ui.colors')

-- statusline stuff
local StatusLine = require'ui.modules.statusline'.StatusLine
function _G.__render_statusline() return StatusLine:render{} end
vim.o.statusline = '%!v:lua.__render_statusline()'
vim.o.laststatus = 3

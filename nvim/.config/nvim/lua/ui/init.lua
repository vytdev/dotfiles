-- append color aliases
local hls = require'ui.hls'
hls.append_colors(require'ui.colors')

local StatusLine = require'ui.modules.statusline'.StatusLine

local function draw()
  return StatusLine:render{}
end

vim.opt.statusline = '%!v:lua.require("ui").draw()'
vim.opt.laststatus = 3
return { draw = draw }

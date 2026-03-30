-- append color aliases
local hls = require'numsqx.ui.hls'
hls.append_colors(require'numsqx.ui.colors')

local StatusLine = require'numsqx.ui.modules.statusline'.StatusLine

local function draw()
  return StatusLine:render{}
end

vim.opt.statusline = '%!v:lua.require("numsqx.ui").draw()'
vim.opt.laststatus = 3
return { draw = draw }

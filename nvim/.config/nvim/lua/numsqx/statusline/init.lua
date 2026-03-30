local ui = require'numsqx.statusline.ui'
local ViMode = require'numsqx.statusline.vimode' .ViMode

local StatusLine = ui.El{
  ViMode, ' ',
  -- these are temporary
  ui.hlbeg('Comment'),
  '%f%=%l,%c%V %P',
  ui.hlend(),
}


function draw_status_line()
  return StatusLine:render{}
end

vim.o.statusline = '%!v:lua.draw_status_line()'
vim.o.laststatus = 3

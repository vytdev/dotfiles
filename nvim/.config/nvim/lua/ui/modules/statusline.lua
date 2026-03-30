local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend

local ViMode = require'ui.modules.vimode'.ViMode


-- Default status line.
M.DefaultLine = comp.Component:new{
  ViMode,
  -- these are temporary
  hlbeg('Comment'),
  ' %f%=%l,%c%V %P',
  hlend(1),
}

-- StatueLine component.
M.StatusLine = comp.Component:new{
  function()
    -- decide what to use in here.
    return M.DefaultLine
  end
}

return M

local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend

local ViMode        = require'ui.modules.vimode'.ViMode
local FileNameBlock = require'ui.modules.filename'.FileNameBlock


-- Default status line.
M.DefaultLine = comp.Component:new{
  ViMode,
  -- these are temporary
  hlbeg('Comment'),
  FileNameBlock,
  '%=%l,%c%V %P',
  hlend(1),
}

-- StatusLine component.
M.StatusLine = comp.Component:new{
  function()
    -- decide what to use in here.
    return M.DefaultLine
  end
}

return M

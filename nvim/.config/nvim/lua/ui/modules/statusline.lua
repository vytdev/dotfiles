local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend

local vimode      = require'ui.modules.vimode'
local filename    = require'ui.modules.filename'
local diagnostics = require'ui.modules.diagnostics'

-- Default status line.
M.DefaultLine = comp.Component:new{
  vimode.ViMode,
  hlbeg('Comment'),
  filename.FileIcon,
  filename.FileName,
  filename.Modified,
  filename.ReadOnly, '  ',
  diagnostics.Diagnostics,
  '%=%l,%c%V %P', -- temporary
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

local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend

local devicons = require'nvim-web-devicons'


-- File name of the current buffer.
M.FileName = comp.Component:new{
  redraw = { 'BufEnter' },
  '%f '   -- we dont have to complicate our lives.
}

-- File type icon for the current buffer.
M.FileIcon = comp.Component:new{
  redraw = { 'BufEnter' },
  function(state)
    local fname = vim.api.nvim_buf_get_name(0)
    local ext = vim.fn.fnamemodify(fname, ':e')
    state.icon, state.icon_hl = devicons.get_icon(
        fname, ext, { default = true })
    return state.icon .. ' '
  end,
}

-- Whether the current buffer is modified.
M.Modified = comp.Component:new{
  function()
    return vim.bo[0].modified and '󰏫 ' or ''
  end
}

-- Whether the current buffer is read-only.
M.ReadOnly = comp.Component:new{
  redraw = { 'BufEnter', 'OptionSet' },
  function()
    return vim.bo[0].readonly and '󰌾 ' or ''
  end
}

return M

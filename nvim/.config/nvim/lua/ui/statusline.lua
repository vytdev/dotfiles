local M = {}

local comp = require'ui.comp'
local hl = require'ui.hls'.hl

local devicons = require'nvim-web-devicons'


local Align = '%='
local Space = ' '


-- File name of the current buffer.
local FileName = comp.Component:new{
  '%f ',  -- we dont have to complicate our lives.
}

-- File type icon for the current buffer.
local FileIcon = comp.Component:new{
  redraw = { 'BufEnter' },
  function()
    local fname = vim.api.nvim_buf_get_name(0)
    local ext = vim.fn.fnamemodify(fname, ':e')
    local icon, icon_hl = devicons.get_icon(fname, ext, { default = true })
    return icon .. ' '
  end,
}

-- Whether the current buffer is modified.
local Modified = comp.Component:new{
  function()
    return vim.bo[0].modified and '󰏫 ' or ''
  end
}

-- Whether the current buffer is read-only.
local ReadOnly = comp.Component:new{
  redraw = { 'BufEnter', 'OptionSet' },
  function()
    return vim.bo[0].readonly and '󰌾 ' or ''
  end
}


-- Returns a Vi mode's info.
-- @param mode The mode to work with
-- @return The mode's name.
-- @return Mode hl color.
local function get_mode_info(mode)
  local map = {
    ['n']   = {'NOR', 'red'},
    ['i']   = {'INS', 'green'},
    ['v']   = {'VSL', 'purple'},
    ['V']   = {'V-L', 'purple'},
    ['\22'] = {'V-B', 'purple'},
    ['c']   = {'CMD', 'blue'},
    ['R']   = {'RPL', 'orange'},
    ['t']   = {'TRM', 'yellow'},
  }
  local info = map[mode:sub(1,1)] or {'UNK', 'grey'}
  return unpack(info)
end


-- ViMode component.
local ViMode = comp.Component:new{
  redraw = { 'ModeChanged','BufEnter' },
  function()
    local mode = vim.fn.mode(1)
    local name, color = get_mode_info(mode)
    local hl_bg = hl{ bg = color, fg = 'dark_grey', bold = true }
    local hl_fg = hl{ fg = color }

    return string.format('%s 󰣇 %s %s %s',
      hl_bg, name, hl_fg, hl'StatusLine')
  end
}


-- Count how many diagnostics are found with severity sev.
-- @param sev The severity number.
-- @return The number of diagnostics.
local function get_diag_count(sev)
  return #vim.diagnostic.get(0, {
    severity = sev
  })
end


-- Get the severity icom from vim.diagnostic config.
-- @param sev The severity number.
-- @return The icon.
local function get_severity_icon(sev)
  return vim.diagnostic.config().signs.text[sev] or ''
end


-- Make a diagnostic count pretty-printer.
-- @param sev The severity.
-- @return A function.
local function make_diag_count(sev)
  sev = vim.diagnostic.severity[sev]
  return function()
    local count = get_diag_count(sev)
    if count < 1 then return '' end
    -- lsp setup's not immediate, it's better to re-fetch
    local icon = get_severity_icon(sev)
    return string.format('%s%d ', icon, count)
  end
end


-- Diagnostics stuff.
local Diagnostics = comp.Component:new{
  redraw = {
    'DiagnosticChanged', 'BufEnter',
    callback = function() vim.cmd'redrawstatus' end,
  },
  make_diag_count('ERROR'),
  make_diag_count('WARN'),
  make_diag_count('INFO'),
  make_diag_count('HINT'),
}


-- Ruler
local Ruler = comp.Component:new{
  -- LN,COL-VCOL PERCENT% @ BUFNR
  '%l,%c%V %P @ %n'
}


-- Default status line.
local DefaultLine = comp.Component:new{
  ViMode,
  hl'Comment',

  FileIcon,
  FileName,
  Modified,
  ReadOnly,
  Space, Diagnostics,

  Align,

  Ruler,
}

-- StatusLine component.
local StatusLine = comp.Component:new{
  function()
    -- decide what to use in here.
    return DefaultLine
  end
}


-- Apply the statusline.
function M.apply()
  function _G.__render_statusline() return StatusLine:render{} end
  vim.o.statusline = '%!v:lua.__render_statusline()'
  vim.o.laststatus = 3
end


return M

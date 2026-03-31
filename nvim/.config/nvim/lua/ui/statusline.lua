local M = {}


local comp = require'ui.component'
local hl = require'ui.hls'.hl

local devicons = require'nvim-web-devicons'


local default_hl = hl'Comment'

local Align = '%='
local Space = ' '


-- File name of the current buffer.
local FileName = comp.Component:new{
  '%f ',  -- we dont have to complicate our lives.
}

-- Currwnt help name.
local HelpName = comp.Component:new{
  function()
    return vim.fn.fnamemodify(
      vim.api.nvim_buf_get_name(0), ':t') .. ' '
  end
}

-- File type of the current buffer.
local FileType = comp.Component:new{
  function()
    return string.format('[%s]', vim.bo.filetype) .. ' '
  end
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
      hl_bg, name, hl_fg, default_hl)
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

-- Ruler.
local Ruler = comp.Component:new{
  -- LN,COL-VCOL PERCENT% @ BUFNR
  '%l,%c%V %P @ %n'
}


-- Default status line.
local DefaultLine = comp.Component:new{
  ViMode,

  default_hl,
  FileIcon,
  FileName,
  Modified,
  ReadOnly,
  Space, Diagnostics,

  Align,

  Ruler,
}

-- Other stuff.
local OtherLine = comp.Component:new{
  Space,        -- too close to edge
  default_hl,
  FileIcon,
  HelpName,
  FileType,
}

-- For terminal buffers.
local TerminalLine = comp.Component:new{
  ViMode,
  default_hl,
  '󰆍 Terminal',
  Align,
  FileName,
}

-- StatusLine component.
local StatusLine = comp.Component:new{
  function()
    -- decide what to use in here.
    local buftype = vim.bo[0].buftype

    if buftype == 'terminal' then
      return TerminalLine end

    if buftype == 'nofile' or buftype == 'prompt' or
       buftype == 'quickfix' or buftype == 'help'
    then return OtherLine end

    return DefaultLine
  end
}


-- Apply the statusline.
function M.apply()
  function _G.__render_statusline() return StatusLine:render{} end
  vim.o.statusline = '%!v:lua.__render_statusline()'
  vim.o.laststatus = 3   -- global statusline
end


-- export other stuf

M.default_hl = default_hl

M.Align = Align
M.Space = Space

M.FileName = FileName
M.HelpName = HelpName
M.FileType = FileType
M.FileIcon = FileIcon
M.Modified = Modified
M.ReadOnly = ReadOnly
M.ViMode = ViMode
M.Diagnostics = Diagnostics
M.Ruler = Ruler

M.DefaultLine = DefaultLine
M.OtherLine = OtherLine
M.TerminalLine = TerminalLine

M.StatusLine = StatusLine

return M

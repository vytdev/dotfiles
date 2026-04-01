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

-- File type icon for the current buffer.
local FileIcon = comp.Component:new{
  function(state, dirty)
    local fname = vim.api.nvim_buf_get_name(state.bufid)
    local ext = vim.fn.fnamemodify(fname, ':e')
    local icon, icon_hl = devicons.get_icon(fname, ext, { default = true })
    return icon .. ' '
  end,
}

-- Whether the current buffer is modified.
local Modified = comp.Component:new{
  function(state)
    return vim.bo[state.bufid].modified and '󰏫 ' or ''
  end
}

-- Whether the current buffer is read-only.
local ReadOnly = comp.Component:new{
  function(state)
    return vim.bo[state.bufid].readonly and '󰌾 ' or ''
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
local last_vimode
local ViMode = comp.Component:new{
  redraw = { 'ModeChanged','BufEnter' },
  function(state, dirty)
    -- hide the mode from inactive windows
    if not state.active_win then
      return '' end
    if dirty then
      local mode = vim.fn.mode(1)
      local name, color = get_mode_info(mode)
      local hl_bg = hl{ bg = color, fg = 'dark_grey', bold = true }
      local hl_fg = hl{ fg = color }
      last_vimode = string.format('%s 󰣇 %s %s %s',
        hl_bg, name, hl_fg, default_hl)
    end
    return last_vimode
  end
}


-- Count how many diagnostics are found with severity sev.
-- @param bufid The buffer to fetch info from.
-- @param sev The severity number.
-- @return The number of diagnostics.
local function get_diag_count(bufid, sev)
  return #vim.diagnostic.get(bufid, {
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
  return function(state, dirty)
    if dirty then
      local count = get_diag_count(state.bufid, sev)
      if count < 1 then return '' end
      -- lsp setup's not immediate, it's better to re-fetch
      local icon = get_severity_icon(sev)
      state['diag_' .. sev] = string.format('%s%d ', icon, count)
    end
    return state['diag_' .. sev] or ''
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
  '%l,%c%V %P',
}

-- Buffer number.
local BufNr = comp.Component:new{
  '@ %n',
}

-- File without the parent dir path.
local FileBaseName = comp.Component:new{
  '%t ',
}

-- File [type].
local FileType = comp.Component:new{
  '%y ',
}


-- Default status line.
local DefaultLine = comp.Component:new{
  ViMode,

  default_hl,
  FileIcon,
  FileName,
  Modified,
  ReadOnly,
  Space,
  Diagnostics,

  Align,

  Ruler,
  Space,
  BufNr,
}

-- Other stuff.
local OtherLine = comp.Component:new{
  Space,        -- too close to edge
  default_hl,
  FileIcon,
  FileBaseName,
  FileType,

  Align,

  BufNr,
}

-- For terminal buffers.
local TerminalLine = comp.Component:new{
  ViMode,
  default_hl,
  '󰆍 Terminal',

  Align,

  FileName,
  BufNr,
}

-- StatusLine component.
local StatusLine = comp.Component:new{
  function(state)
    -- decide what to use in here.
    local buftype = vim.bo[state.bufid].buftype
    if buftype == 'terminal' then
      return TerminalLine end
    if buftype == 'nofile' or buftype == 'prompt' or
       buftype == 'quickfix' or buftype == 'help'
      then return OtherLine end
    return DefaultLine
  end
}


-- persistent state per window
local win_state = {}


-- Apply the statusline.
function M.apply()
  function _G.__render_statusline()
    local winid = vim.g.statusline_winid
    if not win_state[winid] then
      win_state[winid] = {}
      win_state[winid].winid = vim.g.statusline_winid
    end
    win_state[winid].bufid = vim.api.nvim_win_get_buf(winid)
    win_state[winid].active_win = winid == vim.api.nvim_get_current_win()
    return StatusLine:render(win_state[winid])
  end
  vim.o.statusline = '%!v:lua.__render_statusline()'
  --vim.o.laststatus = 2   -- per-window statusline
  vim.o.laststatus = 3   -- global statusline
end


-- export other stuf

M.default_hl = default_hl

M.Align = Align
M.Space = Space

M.FileName = FileName
M.FileIcon = FileIcon
M.Modified = Modified
M.ReadOnly = ReadOnly
M.ViMode = ViMode
M.Diagnostics = Diagnostics
M.Ruler = Ruler
M.FileBaseName = FileBaseName
M.FileType = FileType

M.DefaultLine = DefaultLine
M.OtherLine = OtherLine
M.TerminalLine = TerminalLine

M.StatusLine = StatusLine

return M

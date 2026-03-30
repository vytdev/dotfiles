local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend


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
M.ViMode = comp.Component:new{
  redraw = {'ModeChanged','BufEnter'},
  init = function(state)
    state.mode = vim.fn.mode(1)
    state.mode_name, state.mode_color = get_mode_info(state.mode)
  end,

  -- as simple as it can become
  hlbeg(function(state) return { bg = state.mode_color, fg = 'dark_grey', bold = true } end),
  function(state) return string.format(' 󰣇 %s ', state.mode_name) end, hlend(1),
  hlbeg(function(state) return { fg = state.mode_color } end), ' ', hlend(1),
}

return M

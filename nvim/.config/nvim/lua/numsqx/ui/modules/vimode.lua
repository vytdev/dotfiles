local M = {}

local comp = require'numsqx.ui.comp'
local hls = require'numsqx.ui.hls'
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


local fg_mode = function(state) return { fg = state.mode_color } end
local bg_mode = function(state) return { bg = state.mode_color } end
local fg_grey = { fg = 'dark_grey' }
local bg_grey = { bg = 'dark_grey' }


-- ViMode component.
M.ViMode = comp.Component:new{
  redraw = {'ModeChanged','BufEnter'},
  init = function(state)
    state.mode = vim.fn.mode(1)
    state.mode_name, state.mode_color = get_mode_info(state.mode)
  end,
  hlbeg(fg_mode), '', hlend(1),                         -- outer-left
  hlbeg(bg_mode), hlbeg(fg_grey), '󰣇 ', hlend(2),        -- icon
  hlbeg(bg_grey), hlbeg(fg_mode), ' ',                  -- mid sep
  function(state) return state.mode_name end, hlend(2),  -- mode name
  hlbeg(fg_grey), '', hlend(1),                         -- outer-right
}

return M

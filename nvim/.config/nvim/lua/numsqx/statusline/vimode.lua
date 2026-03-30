local col = require'numsqx.statusline.colors'
local ui = require'numsqx.statusline.ui'

local function get_mode_info(mode)
  local map = {
    ['n']   = {'NOR',col.red},
    ['i']   = {'INS',col.green},
    ['v']   = {'VSL',col.purple},
    ['V']   = {'V-L',col.purple},
    ['\22'] = {'V-B',col.purple},
    ['c']   = {'CMD',col.blue},
    ['R']   = {'RPL',col.orange},
    ['t']   = {'TRM',col.yellow},
  }
  local info = map[mode:gsub(1,1)] or {'UNK',col.grey}
  return info[1], info[2]
end

local bg_mode = function(state) return { bg = state.mode_color } end
local fg_mode = function(state) return { fg = state.mode_color } end
local bg_grey = { bg = col.dark_grey }
local fg_grey = { fg = col.dark_grey }

local hlbeg = ui.hlbeg
local hlend = ui.hlend


local ViMode = ui.El{
  redraw = {'ModeChanged','BufEnter'},

  init = function(state)
    state.mode = vim.fn.mode(1)
    state.mode_name, state.mode_color = get_mode_info(state.mode)
  end,

  -- outer-left
  hlbeg(fg_mode), '', hlend(1),

  -- icon
  hlbeg(bg_mode), hlbeg(fg_grey), '󰣇 ', hlend(2),

  -- mid separator
  hlbeg(bg_grey), hlbeg(fg_mode), ' ',

  -- name
  function(state) return state.mode_name end, hlend(2),

  -- outer-right
  hlbeg(fg_grey), '', hlend(1),
}

return {
  ViMode = ViMode,
}

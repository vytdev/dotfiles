local M = {}


local utils = require'utils'
local comp = require'ui.component'


-- ClickableComponent class.
-- @class ClickableComponent
-- @super comp.Component
-- @field clkname Unique name for the callback.
-- @field onclick The callback to run whenever the component is
-- clicked. Receives the component class as an argument.
local ClickableComponent = utils.class(comp.Component)
M.ClickableComponent = ClickableComponent


-- Create a new ClickableComponent instance.
-- @param def The component def.
-- @return The new instance.
function ClickableComponent:new(def)
  local o = self.__super.new(self, def)
  -- setup the callback
  if def.clkname then o:set_clkname(def.clkname) end
  if def.onclick then o:set_onclick(def.onclick) end
  return o
end


-- Helper function to construct a reference id. This is to avoid overriding
-- global variables.
-- @param name The source name.
-- @return The constructed global id.
function M.get_refid(name)
  if not name:match('^[A-Za-z0-9_]*$') then
    error('ClickableComponent: Invalid clkname: ' .. name, 2)
  end
  return '__numsqx_ui_clickcbk_' .. name
end


-- Set a new on-click callback.
-- @param func The on-click callback.
-- @return self to allow chaining.
function ClickableComponent:set_onclick(func)
  self.onclick = func
  return self
end


-- Set a new unique clkname.
-- @param name The new on-click name.
-- @return self to allow chaining.
function ClickableComponent:set_clkname(name)
  self.clkname = name
  -- unset the old global func
  if type(self._refid) == 'string' then
    _G[self._refid] = nil
  end
  -- set a new global func
  self._refid = M.get_refid(name)
  _G[self._refid] = function()
    if type(self.onclick) ~= 'function' then
      error('ClickableComponent: onclick is not set')
    end
    self.onclick(self)
  end
  return self
end


-- Draw with click region. Do not nest clickable components.
-- @param state The state object to work on.
-- @return The ui strng.
function ClickableComponent:draw(state)
  if type(self._refid) ~= 'string' then
    error('ClickableComponent: clkname is not set')
  end
  local ui = self.__super.draw(self, state)
  return '%@v:lua.' .. self._refid .. '@' .. ui .. '%T'
end


return M

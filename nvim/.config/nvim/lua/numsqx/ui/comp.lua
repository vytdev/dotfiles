local M = {}


local Component = {}
Component.__index = Component
M.Component = Component


-- Create a new Component instance.
-- @param def The component def.
-- @return The new instance.
function Component:new(def)
  local obj = setmetatable(def, Component)
  -- register redraw rules
  if obj.redraw then
    obj:set_redraw(obj.redraw)
  end
  return obj
end


-- Render this component, respecting redraw rules.
-- @param state The drawing state object.
-- @return The final ui string.
function Component:render(state)
  if not self.redraw or not self._last_render then
    self._last_render = self:draw(state)
  end
  return self._last_render
end


-- Forces a redraw of this component, disregarding redraw rules.
-- @param state The drawing state object.
-- @return The final ui string.
function Component:force_render(state)
  self._last_render = self:draw(state)
  return self._last_render
end


-- Draw this component given a state. It musn't be called directly,
-- use Component:render() instead.
-- @param state The state object to work on.
-- @return The final ui string (can be set to statusline).
function Component:draw(state)
  local ui = ''

  -- begin hooks
  if self.cond and not self.cond(state) then return ui end
  if self.init then self.init(state) end

  for i, child in ipairs(self) do
    if type(child) == 'function' then child = child(state) end
    if getmetatable(child) == Component then child = child:render(state) end
    -- Ultimately, we want a plain string.
    ui = ui .. tostring(child)
  end

  return ui
end


-- Set a new draw condition.
-- @param cond The condition function.
-- @return self to allow chaining.
function Component:set_cond(cond)
  self.cond = cond
  return self
end


-- Set an initializer.
-- @param fn The init function.
-- @return self to allow chaining.
function Component:set_init(fn)
  self.init = fn
  return self
end


-- Prevent autocmd duplicates every reload.
local redraw_aug = vim.api.nvim_create_augroup(
    '__numsqx_ui_redraw_handlers', { clear = true })

-- Set new redraw rules.
-- @param events The events when to trigger a redraw.
-- @return self to allow chaining.
function Component:set_redraw(events)
  if self._curr_redraw_autocmd then
    vim.api.nvim_del_autocmd(self._curr_redraw_autocmd)
  end
  self._curr_redraw_autocmd = vim.api.nvim_create_autocmd(events, {
    group = redraw_aug,
    callback = function()
      self._last_render = nil  -- just invalidate the last render
    end
  })
  self.redraw = events
  return self
end


return M

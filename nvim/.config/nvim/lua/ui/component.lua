local M = {}


local utils = require'utils'


-- Component class.
-- @class Component
-- @field redraw 'always' | 'ignore' | 'static' | table
-- Can be:
-- - 'always': Always redraw. (default)
-- - 'ignore': Don't draw.
-- - 'static': Only draw once.
-- - autocmd:  Array of event names with optional pattern/callback.
local Component = utils.class()
M.Component = Component


-- Create a new Component instance.
-- @param def The component def.
-- @return The new instance.
function Component:new(def)
  setmetatable(def, self)
  -- register redraw rules
  def:set_redraw(def.redraw or 'always')
  return def
end


-- Render this component, respecting redraw rules.
-- @param state The drawing state object.
-- @return The final ui string.
function Component:render(state)
  -- 'always': always redraw
  if self.redraw == 'always' then
    return self:draw(state) end

  -- 'ignore': do not draw
  if self.redraw == 'ignore' then
    return '' end

  -- 'static'/autocmd: only redraw when _last_render
  -- is not set
  if not self._last_render then
    self._last_render = self:draw(state) end
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

  for i, child in ipairs(self) do
    if type(child) == 'function' then child = child(state) end
    if getmetatable(child) == Component then child = child:render(state) end
    -- Ultimately, we want a plain string.
    ui = ui .. tostring(child)
  end

  return ui
end


-- Prevent autocmd duplicates every reload.
local redraw_aug = vim.api.nvim_create_augroup(
    '__numsqx_ui_redraw_handlers', { clear = true })

-- Set new redraw rules.
-- @param rules The redraw rules.
-- @return self to allow chaining.
function Component:set_redraw(rules)
  if self._curr_redraw_autocmd then
    vim.api.nvim_del_autocmd(self._curr_redraw_autocmd)
  end
  self.redraw = rules

  -- str rules: always, static, ignore
  if type(rules) == 'string' then
    return self
  end

  -- we want indexed entries
  local events = {}
  for i, v in ipairs(rules) do
    events[i] = v
  end

  self._curr_redraw_autocmd = vim.api.nvim_create_autocmd(events, {
    group = redraw_aug,
    pattern = rules.pattern,
    callback = function()
      self._last_render = nil  -- just invalidate the last render
      if type(rules.callback) == 'function' then rules.callback() end
    end
  })
  return self
end


-- Destroys this component object.
function Component:destroy()
  if self._curr_redraw_autocmd then
    vim.api.nvim_del_autocmd(self._curr_redraw_autocmd)
    self._curr_redraw_autocmd = nil
  end
end


return M

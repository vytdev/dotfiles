local M = {}


local utils = require'utils'


-- Component class.
-- @class Component
-- @field redraw
-- Can be:
-- - 'always': Always set the dirty flag. (default)
-- - 'ignore': Don't draw.
-- - 'static': Set dirty flag once.
-- - autocmd:  Array of event names with optional pattern/callback.
-- @field dirty Whether redraw is needed.
local Component = utils.class()
M.Component = Component


-- Create a new Component instance.
-- @param def The component def.
-- @return The new instance.
function Component:new(def)
  setmetatable(def, self)
  -- register redraw rules
  def:set_redraw(def.redraw or 'always')
  self.dirty = true
  return def
end


-- Render this component, respecting redraw rules.
-- @param state The drawing state object.
-- @return The final ui string.
function Component:render(state)
  -- 'ignore': do not draw
  if self.redraw == 'ignore' then
    return '' end
  -- 'always'/'static'/autocmd
  if self.redraw == 'always' then
    self.dirty = true end
  local ui = self:draw(state)
  self.dirty = false
  return ui
end


-- Draw this component given a state. It musn't be called directly,
-- use Component:render() instead.
-- @param state The state object to work on.
-- @return The final ui string (can be set to statusline).
function Component:draw(state)
  local ui = ''
  for _, child in ipairs(self) do
    if type(child) == 'function' then
      child = child(state, self.dirty) end
    if child and type(child.render) == 'function' then
      child = child:render(state) end
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
    return self end
  -- we want indexed entries
  local events = {}
  for i, v in ipairs(rules) do
    events[i] = v end
  self._curr_redraw_autocmd = vim.api.nvim_create_autocmd(events, {
    group = redraw_aug,
    pattern = rules.pattern,
    callback = function()
      self.dirty = true  -- just invalidate the last render
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

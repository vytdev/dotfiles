local M = {}


-- Creates a new table containing all the fields of 'a', overriden
-- by 'b'. Indices are ignored.
-- @param a A
-- @param b B
-- @return New table.
local function merge(a, b)
  local r = {}
  for k, v in pairs(a) do r[k] = v end
  for k, v in pairs(b) do r[k] = v end
  return r
end


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


-- Draw this component given a state. It musn't be called directly,
-- use Component:render() instead.
-- @param state The state object to work on.
-- @return The final ui string (can be set to statusline).
function Component:draw(state)
  local ui = ''

  -- begin hooks
  if self.cond and not self.cond(state) then return ui end
  if self.init then self.init(state) end
  if self.hl then ui = ui .. M.begin_hlgrp(state, self.hl) end

  for i, child in ipairs(self) do
    if type(child) == 'function' then child = child(state) end
    if getmetatable(child) == Component then child = child:render(state) end
    -- Ultimately, we want a plain string.
    ui = ui .. tostring(child)
  end

  -- end hooks
  if self.hl then ui = ui .. M.end_hlgrp(state, 1) end

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


-- Set a new hl.
-- @param hl The new hl; can be an hlname string, hldef, or a func that
-- returns either of these two.
-- @return self to allow chaining.
function Component:set_hl(hl)
  self.hl = hl
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


local hl_cache = {}
local hl_cnt = 0

-- Define a new temporary hlgroup.
-- @param def The hl definition.
-- @return The name of the hlgroup.
function M.make_hl(def)
  local key = vim.inspect(def)
  if hl_cache[key] then
    return hl_cache[key]
  end
  local hl_name = '__numsqx_hlgrp' .. hl_cnt
  hl_cnt = hl_cnt + 1
  hl_cache[key] = hl_name
  vim.api.nvim_set_hl(0, hl_name, def)
  return hl_name
end


-- Begins a highlight subgroup, applying proper inheritance.
-- @param state The state object to work on.
-- @param hl Can be an hl def, an hlgroup name string, or a function that
-- returns an hl def or hlgroup name.
-- @return The new temporary hlgroup reference.
function M.begin_hlgrp(state, hl)
  state.hlgrp_info = { prev = state.hlgrp_info }
  local info = state.hlgrp_info

  if type(hl) == 'function' then hl = hl(state) end
  if type(hl) == 'string' then hl = vim.api.nvim_get_hl(0, { name = hl }) end

  info.hldef  = merge(info.prev and info.prev.hldef or {}, hl)
  info.hlname = M.make_hl(info.hldef)
  info.hlref  = '%#' .. info.hlname .. '#'
  return info.hlref
end


-- Ends a highlight subgroup, popping the previous hl state based
-- on inheritance rules.
-- @param state The state object to work on.
-- @param cnt How many subgroups to pop.
-- @return The parent's highlight ref.
function M.end_hlgrp(state, cnt)
  local lastref
  for i = 1, cnt do
    state.hlgrp_info = state.hlgrp_info and state.hlgrp_info.prev or {}
    lastref = state.hlgrp_info.hlref
  end
  return lastref or '%#StatusLine#'
end


-- Makes a push-hl handler.
-- @param hl The hl to push.
-- @return A Component's children function.
function M.hlbeg(hl)
  return function(state)
    return M.begin_hlgrp(state, hl)
  end
end


-- Makes a pop-hl handler.
-- @param[cnt=1] How many hls to pop.
-- @return A Component's children function.
function M.hlend(cnt)
  if cnt == nil then
    cnt = 1
  end
  return function(state)
    return M.end_hlgrp(state, cnt)
  end
end


-- Creates a new component. Just a convinience wrapper around
-- Component:new().
-- @param def The component definition.
-- @return A new Component instance.
function M.El(def)
  return Component:new(def)
end


return M

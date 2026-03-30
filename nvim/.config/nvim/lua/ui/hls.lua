local M = {}


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
  local hl_name = '__numsqx_ui_hlgrp' .. hl_cnt
  hl_cnt = hl_cnt + 1
  hl_cache[key] = hl_name
  vim.api.nvim_set_hl(0, hl_name, def)
  return hl_name
end


-- Used for color substitution.
M.color_names = {}


-- Appends a new set of color aliases to be used for color substitution.
-- @param new_names The new color names.
function M.append_colors(new_names)
  for k, v in pairs(new_names) do
    if type(v) == 'string' then
      M.color_names[k] = v
    end
  end
end


-- Substitutes appropriate colors to bg/fg/sp. Note: it mutates the provided
-- hldef.
-- @param hldef The hl def to mutate.
function M.sub_colors(hldef)
  hldef.bg = M.color_names[hldef.bg] or hldef.bg
  hldef.fg = M.color_names[hldef.fg] or hldef.fg
  hldef.sp = M.color_names[hldef.sp] or hldef.sp
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

  info.hldef  = vim.tbl_extend('force',
      info.prev and info.prev.hldef or {}, hl)
  M.sub_colors(info.hldef)

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


return M

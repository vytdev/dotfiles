local M = {}


-- Class creation helper.
-- @param parent? Optional parent class.
-- @return A (sub)class object you can populate.
function M.class(parent)
  local c = setmetatable({}, parent)
  c.__super = parent
  c.__index = c
  return c
end


return M

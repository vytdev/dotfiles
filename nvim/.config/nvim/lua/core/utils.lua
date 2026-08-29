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


-- completion kind icons
-- thx: https://github.com/onsails/lspkind.nvim
local lsp_kind = {
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}

M.lsp_kind = lsp_kind



return M

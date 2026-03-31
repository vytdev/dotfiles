local M = {}

local comp = require'ui.comp'
local hls = require'ui.hls'
local hlbeg = hls.hlbeg
local hlend = hls.hlend


-- Count how many diagnostics are found with severity sev.
-- @param sev The severity number.
-- @return The number of diagnostics.
local function get_diag_count(sev)
  return #vim.diagnostic.get(0, {
    severity = sev
  })
end


-- Get the severity icom from vim.diagnostic config.
-- @param sev The severity number.
-- @return The icon.
local function get_severity_icon(sev)
  return vim.diagnostic.config().signs.text[sev] or ''
end


-- Make a diagnostic count pretty-printer.
-- @param sev The severity.
-- @return A function.
local function make_diag_count(sev)
  sev = vim.diagnostic.severity[sev]
  return function()
    local count = get_diag_count(sev)
    if count < 1 then return '' end
    -- lsp setup's not immediate, it's better to re-fetch
    local icon = get_severity_icon(sev)
    return string.format('%s%d ', icon, count)
  end
end


-- Diagnostics stuff.
M.Diagnostics = comp.Component:new{
  redraw = {
    'DiagnosticChanged', 'BufEnter',
    callback = function() vim.cmd'redrawstatus' end,
  },
  make_diag_count('ERROR'),
  make_diag_count('WARN'),
  make_diag_count('INFO'),
  make_diag_count('HINT'),
}

return M

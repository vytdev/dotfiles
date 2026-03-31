-- append color aliases
local hls = require'ui.hls'
hls.append_colors(require'ui.colors')

require'ui.statusline'.apply()

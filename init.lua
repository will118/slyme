local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

COLUMN_COUNT = 3

DESIRED_X_ORIGIN = 6
DESIRED_Y_ORIGIN = 33
DESIRED_MAX_HEIGHT = 848
DESIRED_MAX_WIDTH = 1424
DESIRED_COLUMN_WIDTH = DESIRED_MAX_WIDTH / COLUMN_COUNT

-- fromright: i.e. not from the left.
function resizewindow(widthfactor, fromright)
  local win = window.focusedwindow()
  local f = win:frame()
  local appname = win:application():title()
  local isiterm = appname == "iTerm2"

  -- set the y position.
  f.y = DESIRED_Y_ORIGIN
  -- set width, if iterm2 then requires adding 2px to this.
  f.w = isiterm and (DESIRED_COLUMN_WIDTH * widthfactor) + 2 or DESIRED_COLUMN_WIDTH * widthfactor
  -- set the x position.
  f.x = fromright and (DESIRED_MAX_WIDTH - f.w + 6) or DESIRED_X_ORIGIN
  -- set height.
  f.h = isiterm and 860 or DESIRED_MAX_HEIGHT

  win:setframe(f)
end

local shortcuts = {
  ["1"] = function() resizewindow(1, false) end,
  ["2"] = function() resizewindow(2, false) end,
  ["9"] = function() resizewindow(2, true) end,
  ["0"] = function() resizewindow(1, true) end,
  R = function() resizewindow(3, false) end,
}

for key, func in pairs(shortcuts) do
  hotkey.bind({"cmd", "ctrl"}, key, func)
end

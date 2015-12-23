local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

hotkey.bind({"cmd", "ctrl"}, "R", function()
  local win = window.focusedwindow()
  local f = win:frame()
  local appname = win:application():title()
  f.x = 6
  f.y = 33

  if appname == "iTerm2" then
    f.w = 1426
    f.h = 860
  else
    f.w = 1424
    f.h = 848
  end

  win:setframe(f)
end)

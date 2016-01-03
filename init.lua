local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local audiodevice = require "mjolnir._asm.sys.audiodevice"
local ipc = require "mjolnir._asm.ipc"

COLUMN_COUNT = 4
DESIRED_X_ORIGIN = 6
DESIRED_Y_ORIGIN = 33
DESIRED_MAX_HEIGHT = 848
DESIRED_MAX_WIDTH = 1424
DESIRED_COLUMN_WIDTH = DESIRED_MAX_WIDTH / COLUMN_COUNT

-- text: input string
-- colors: array of escape code numbers
-- endindex: where the text will be trimmed (the most faded part)
function constanttextansigradient(text, colors, endindex)
  local trimmed = string.sub(text, 1, endindex)
  charindex = 1
  local outputstring = ""

  for i = #colors, 1, -1 do
    local colorindex = (#colors + 1) - i
    local color = colors[colorindex]
    local charcount = 5
    local slice = string.sub(trimmed, charindex, charindex + charcount)
    charindex = charindex + charcount + 1
    outputstring = outputstring .. string.format("\27[%dm%s", color, slice)
  end

  return outputstring
end

function activewindowtitle()
  local win = window.focusedwindow()
  local colors = {32, 33, 34, 35, 36, 37, 90, 91, 92, 93, 94, 95, 96, 97}
  local windowtitle = constanttextansigradient(win:title(), colors, 68)
  local apptitle = win:application():title()
  return '\27[30m' .. apptitle .. '\27[31m ፨ ' .. windowtitle
end

function speakerstate()
  local device = audiodevice.defaultoutputdevice()
  local volume = math.floor(device:volume())
  if device:muted() then
    return '\27[90m' .. volume .. "%"
  elseif device:name() == 'Built-in Output' then
    return '\27[94m' .. volume .. "%"
  else
    return '\27[96m' .. volume .. "%"
  end
end

function centerandshrink()
  local win = window.focusedwindow()
  local f = win:frame()
  f.w = DESIRED_MAX_WIDTH / 1.5
  f.h = DESIRED_MAX_HEIGHT / 1.5
  -- TODO: Make this the actual middle.
  f.x = 280
  f.y = 150
  win:setframe(f)
end

-- fromright: i.e. not from the left.
function resizewindow(widthfactor, fromright)
  local win = window.focusedwindow()
  local f = win:frame()
  local isiterm = win:application():title() == "iTerm2"
  -- set width, if iterm2 then requires adding 2px to this.
  local basewidth = DESIRED_COLUMN_WIDTH * widthfactor
  f.w = isiterm and basewidth + 2 or basewidth
  -- set height.
  f.h = isiterm and 860 or DESIRED_MAX_HEIGHT
  -- set the y position.
  f.y = DESIRED_Y_ORIGIN
  -- set the x position.
  f.x = fromright and (DESIRED_MAX_WIDTH - f.w + 6) or DESIRED_X_ORIGIN
  win:setframe(f)
end

local shortcuts = {
  ["1"] = function() resizewindow(1, false) end,
  ["2"] = function() resizewindow(2, false) end,
  ["3"] = function() resizewindow(3, false) end,
  ["8"] = function() resizewindow(3, true) end,
  ["9"] = function() resizewindow(2, true) end,
  ["0"] = function() resizewindow(1, true) end,
  R = function() resizewindow(4, false) end,
  C = centerandshrink,
}

for key, func in pairs(shortcuts) do
  hotkey.bind({"cmd", "ctrl"}, key, func)
end

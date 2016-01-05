local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local audiodevice = require "mjolnir._asm.sys.audiodevice"
local ipc = require "mjolnir._asm.ipc"
local utf8 = require 'lua-utf8'

-- text: input string
-- colors: array of escape code numbers
-- endindex: where the text will be trimmed (the most faded part)
function constanttextansigradient(text, colors, endindex)
  local cleaned = utf8.escape(text)
  local trimmed = string.sub(cleaned, 1, endindex)
  local charindex = 1
  local charcount = 5
  local outputstring = ""

  for i = 1, #colors do
    local color = colors[i]
    local slice = string.sub(trimmed, charindex, charindex + charcount)
    charindex = charindex + charcount + 1
    outputstring = outputstring .. string.format("\27[%dm%s", color, slice)
  end

  return outputstring
end

function activewindowtitle()
  local win = window.focusedwindow()
  local colors = {32, 33, 34, 35, 36, 37, 90, 91, 92, 93, 94, 95, 96, 97}
  if win then
    local windowtitle = constanttextansigradient(win:title(), colors, 70)
    local apptitle = win:application():title()
    return '\27[30m' .. apptitle .. '\27[31m ፨ ' .. windowtitle .. '\27[0m'
  else
    return ''
  end
end

function speakerstate()
  local ok, value = pcall(speakerinfo)
  if ok then
    return value
  else
    return '\27[90m' .. 'HDMI\27[0m'
  end
end

function speakerinfo()
  local device = audiodevice.defaultoutputdevice()
  local volume = math.floor(device:volume())
  local volumestring = volume .. "%" .. '\27[0m'
  if device:muted() then
    return '\27[90m' .. volumestring
  elseif device:name() == 'Built-in Output' then
    return '\27[94m' .. volumestring
  else
    return '\27[96m' .. volumestring
  end
end

COLUMN_COUNT = 4
DESIRED_X_ORIGIN = 6
DESIRED_Y_ORIGIN = 33
DESIRED_MAX_HEIGHT = 848
DESIRED_MAX_WIDTH = 1424
DESIRED_COLUMN_WIDTH = DESIRED_MAX_WIDTH / COLUMN_COUNT

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

function resizetoalmostfull()
  local win = window.focusedwindow()
  local screenframe = win:screen():fullframe()
  local isiterm = win:application():title() == "iTerm2"
  local desiredwidth = math.floor((screenframe.w / 100) * 99)
  desiredwidth = isiterm and desiredwidth + 8 or desiredwidth + 2
  local heightmultiplier = isiterm and 97 or 96
  local desiredheight = math.floor((screenframe.h / 100) * heightmultiplier)
  local windowframe = win:frame()
  windowframe.w = desiredwidth
  windowframe.h = desiredheight
  windowframe.x = DESIRED_X_ORIGIN
  windowframe.y = DESIRED_Y_ORIGIN
  win:setframe(windowframe)
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
  R = function() resizetoalmostfull() end,
  Z = mjolnir.reload,
  C = centerandshrink,
}

for key, func in pairs(shortcuts) do
  hotkey.bind({"cmd", "ctrl"}, key, func)
end

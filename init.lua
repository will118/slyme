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
  local utext = utf8.escape(text)
  local trimmed = utf8.sub(utext, 1, endindex)
  local charcount = 5
  local charindex = 1
  local outputstring = ""

  for i = 1, #colors do
    local color = colors[i]
    local slice = utf8.sub(trimmed, charindex, charindex + charcount)
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

function centerandshrink()
  local win = window.focusedwindow()
  if win then
    local screenframe = win:screen():fullframe()
    local winframe = win:frame()
    local shrinkfactor = 1.3
    winframe.w = screenframe.w / shrinkfactor
    winframe.h = screenframe.h / shrinkfactor
    winframe.x = (screenframe.w - winframe.w) / 2
    winframe.y = (screenframe.h - winframe.h) / 2
    win:setframe(winframe)
  end
end

DESIRED_X_ORIGIN = 0
DESIRED_Y_ORIGIN = 22

function resizeto(fullwidth, rightside)
  local win = window.focusedwindow()
  if win then
    local screenframe = win:screen():fullframe()

    local desiredwidth = (fullwidth and screenframe.w) or (screenframe.w / 2)
    local desiredheight = screenframe.h
    local windowframe = win:frame()

    -- set values
    windowframe.w = desiredwidth
    windowframe.h = desiredheight - DESIRED_Y_ORIGIN
    windowframe.x = DESIRED_X_ORIGIN

    if rightside then
      windowframe.x = desiredwidth
    end

    windowframe.y = DESIRED_Y_ORIGIN
    win:setframe(windowframe)
  end
end

function killcitations()
  os.execute ("killall Citations")
end

local shortcuts = {
  R = function() return resizeto(true) end,
  W = function() return resizeto(false, false) end,
  E = function() return resizeto(false, true) end,
  Z = mjolnir.reload,
  C = centerandshrink,
  f9 = killcitations
}

for key, func in pairs(shortcuts) do
  hotkey.bind({"cmd", "ctrl"}, key, func)
end

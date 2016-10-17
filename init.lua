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

function speakerstate()
  local ok, value = pcall(speakerinfo)
  if ok then
    return value .. '#[default]'
  else
    -- possibly broken behviour now I've fixed sys/audiodevices
    return '#[fg=colour69]' .. 'HDMI' .. '#[default]'
  end
end

function speakerinfo()
  local device = audiodevice.defaultoutputdevice()
  local volume = math.floor(device:volume())
  local volumestring = volume .. "%"
  if device:muted() then
    return '#[fg=colour59]' .. volumestring
  elseif device:name() == 'Built-in Output' then
    return '#[fg=colour107]' .. volumestring
  else
    return '#[fg=colour69]' .. volumestring
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
DESIRED_Y_ORIGIN = 18

function resizeto(fullwidth, rightside)
  local win = window.focusedwindow()
  if win then
    local screenframe = win:screen():fullframe()

    local desiredwidth = (fullwidth and screenframe.w) or (screenframe.w / 2)
    local desiredheight = screenframe.h
    local windowframe = win:frame()

    local isiterm = win:application():title() == "iTerm2"
    local y_origin = (isiterm and 0) or DESIRED_Y_ORIGIN

    -- set values
    windowframe.w = desiredwidth
    windowframe.h = desiredheight - y_origin
    windowframe.x = DESIRED_X_ORIGIN

    if rightside then
      windowframe.x = desiredwidth
    end

    windowframe.y = y_origin
    win:setframe(windowframe)
  end
end

local shortcuts = {
  R = function() return resizeto(true) end,
  W = function() return resizeto(false, false) end,
  E = function() return resizeto(false, true) end,
  Z = mjolnir.reload,
  C = centerandshrink
}

for key, func in pairs(shortcuts) do
  hotkey.bind({"cmd", "ctrl"}, key, func)
end

local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local audiodevice = require "mjolnir._asm.sys.audiodevice"
local ipc = require "mjolnir._asm.ipc"
local utf8 = require 'lua-utf8'
local networking = require "mjolnir._asm.sys.networking"
local filesize = require 'filesize'

-- settings
local interfacename = "en0" -- interface for netspeeds
--

local oldstats = networking.getstats(interfacename)
-- called externally by tmux.sh for tmux status
function netspeeds()
  local newstats = networking.getstats(interfacename)
  local bytesin = newstats.ibytes - oldstats.ibytes
  local bytesout = newstats.obytes - oldstats.obytes
  local usecondssince = newstats.time_usec - oldstats.time_usec

  oldstats = newstats

  local secondssince = usecondssince / 1000000
  local bytesinpersecond = bytesin / secondssince
  local bytesoutpersecond = bytesout / secondssince
  if (bytesinpersecond < 1000) and (bytesoutpersecond < 1000) then
    return "#[fg=colour249]0.0KBs 0.0KBs#[default]"
  else
    local downspeed = filesize(bytesinpersecond, { spacer = '' })
    local upspeed = filesize(bytesoutpersecond, { spacer = '' })
    return "#[fg=colour249]" ..  downspeed .. "s " .. upspeed  .. "s#[default]"
  end
end

-- called externally by tmux.sh for tmux status
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

    local isterm = win:application():title() == "Terminal"
    local y_origin = (isterm and 0) or DESIRED_Y_ORIGIN

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

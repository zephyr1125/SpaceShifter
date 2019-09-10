-- mocklove.lua
-- No comment.
--
-- Author:    Brian L Price <blprice61#yahoo.com>
--
-- Created:   27/06/2013
-- Copyright: (c) Brian L Price 2013
-- Licence:   GPLv3
--
-- This file is part of DSRL (Dark Stars Rogue L(ua, ove, ike)).
-- 
local table = table

local M = {}
local _callstack = {}
M['_callstack'] = _callstack

local function decode_args(...)
  local r = {}
  for _, e in ipairs({...}) do
    table.insert(r, e)
  end
  table.insert(_callstack, r)
end

function M._clear_callstack()
  _callstack = {}
  M['_callstack'] = _callstack
end

local mg = {}
M['graphics'] = mg

function mg.setPointSize(...)
  decode_args(mg, 'setPointSize', ...)
end

function mg.setPointStyle(...)
  decode_args(mg, 'setPointStyle', ...)
end

function mg.setColor(...)
  decode_args(mg, 'setColor', ...)
end

function mg.point(...)
  decode_args(mg, 'point', ...)
end

function mg.rectangle(...)
  decode_args(mg, 'rectangle', ...)
end

function mg.setColorMode(...)
  decode_args(mg, 'setColorMode', ...)
end

function mg.setLineWidth(...)
  decode_args(mg, 'setLineWidth', ...)
end

function mg.print(...)
  decode_args(mg, 'print', ...)
end

function mg.setFont(...)
  decode_args(mg, 'setFont', ...)
end

local mgf = {}
function mg.newFont(...)
  decode_args(mg, 'newFont', ...)
  return mgf
end

function mgf.getWidth(...)
  decode_args(mgf, 'getWidth', ...)
  return 32
end

function mgf.getHeight()
  decode_args(mgf, 'getHeight')
  return 32
end

function mg.draw(...)
  decode_args(mg, 'draw', ...)
end

local mgi = {}
function mg.newImage(...)
  decode_args(mg, 'newImage', ...)
  return mgi
end

function mgi.getWidth()
  decode_args(mgi, 'getWidth')
  return 1600
end

function mgi.getHeight()
  decode_args(mgi, 'getHeight')
  return 900
end

local me = {}
M['event'] = me
function me.push(...)
  decode_args(me, 'push', ...)
end

local mm = {}
M['math'] = mm
function mm.randomseed(...)
    --math.randomseed(...)
end

function mm.random(n,m)
    local result = math.random(n,m)
    return result
end

function mm.random(m)
    local result = math.random(m)
    return result
end

return M

package.path =  '/home/pi/sailor/src/?.lua;'..package.path
local sailor = require "sailor"
local path = require "pl.path"

if path.exists("/opt/lunardrink") then
  path.chdir("/opt/lunardrink")
end

--print("path: " .. path.currentdir())

sailor.launch()

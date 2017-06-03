local peri = require "periphery"
local gpio = peri.GPIO

pins = {14,15,18,23,24}
iop = {}

for _,p in ipairs(pins) do
  table.insert(iop, gpio(p, "high"))
end

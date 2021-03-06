local peri = require "periphery"
local gpio = peri.GPIO

local pins = {14,15,18,23,24}
local iop = {}

if #arg ~= 4 then
  print("passe quatro parametros, tempo do rum, tempo da coca")
  os.exit(1)
end

for _,p in ipairs(pins) do
  local err, pio = pcall(peri.GPIO, p, "high")
  if not err then
     error(tostring(err))
  else
     table.insert(iop, pio)
   end
end


local rum = iop[2]
local coca = iop[1]
local orange = iop[3]
local vodka = iop[4]


if tonumber(arg[1]) > 0 then
  print("colocando rum...")
  rum:write(false)
  os.execute("sleep " .. arg[1] )
  rum:write(true)
end

if tonumber(arg[2]) > 0 then
  print("colocando coca...")
  coca:write(false)
  os.execute("sleep " .. arg[2])
  coca:write(true)
end


if tonumber(arg[3]) > 0 then
  print("colocando laranja...")
  orange:write(false)
  os.execute("sleep " .. arg[3] )
  orange:write(true)
end


if tonumber(arg[4]) > 0 then
  print("colocando vodka...")
  vodka:write(false)
  os.execute("sleep " .. arg[3] )
  vodka:write(true)
end

print("pronto!")
coca:close()
rum:close()

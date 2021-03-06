local lunardrink = {
      maitai = {60, 0, 120, 0},
      cubalibre = {70, 120, 0, 0},
      hifi = {0, 0, 120, 70},
      moskvasvobodno = {0, 120, 0, 70},
      teste = {5, 0, 0, 0}
}


local stringx = require "pl.stringx" 
local tablex = require "pl.tablex"
local utils = require "pl.utils"

function lunardrink.mix_drink(drink)

    if lunardrink[drink] == nil then
         return {status = "erro", msg = "Esse drink não existe"}
    end

    local time_needed = tablex.reduce("+", lunardrink[drink])

    local p = require "posix"
    local fd = p.creat("/tmp/file.txt", "rw-r--r--")

    -- Set lock on file
    local lock = {
        l_type = p.F_WRLCK;     -- Exclusive lock
        l_whence = p.SEEK_SET;  -- Relative to beginning of file
        l_start = 0;            -- Start from 1st byte
        l_len = 0;              -- Lock whole file
    }

    local result = p.fcntl(fd, p.F_SETLK, lock)
    if result == -1 then
        return {status="erro", msg="alguem esta preparando outro drink"}
    end
		    
    local t, c, o, e = utils.executeex("sudo /usr/bin/lua /var/www/html/mix_drink.lua " .. table.concat(lunardrink[drink], " ") .. " &")
    --assert(loadfile("/var/www/html/mix.lua"))(unpack(lunardrink[drink]))

    lock.l_type = p.F_UNLCK
    p.fcntl(fd, p.F_SETLK, lock)

    return {status = "ok", t=t,c=c,o=o,e=e, msg = "Fazendo " .. drink .. "...", time = time_needed}
    
end

return lunardrink
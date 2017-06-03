local main = {}
local json = require "dkjson"
local lunardrink = require "lunardrink"

function main.index(page)
    page:render('index')
end

function main.make(page)
    local drink = page.GET.drink or "maitai"

    local tbl = lunardrink.mix_drink(drink)
    local str = json.encode(tbl)
    page:enable_cors()
    page.r.content_type = 'application/json'
    page:write(str)
end

return main

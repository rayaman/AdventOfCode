local file = io.open("input.txt")
local content = file:read("a*")

-- local content = [[
-- 467..114..
-- ...*......
-- ..35..633.
-- ......#...
-- 617*......
-- .....+.58.
-- ..592.....
-- ......755.
-- ...$.*....
-- .664.598..
-- ]]

local sum = 0
local maxX = #content:match("(.-)\n") + 1

local function find(str, substr, callback, init)
    init = init or 1
    local first, last = str:find(substr, init)

    if first then
        callback(str, first, last)
        return find(str, substr, callback, last+1)
    end
end

local function isSymbol(data)
    if data:match("[0-9]") or data=="." or data == "\n" then
        return false
    end
    return true
end

local function isGear(data)
    return data == "*"
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end

local function smartInsert(tbl, val)
    for i,v in ipairs(tbl) do
        if v==val then
            return false
        end
    end
    table.insert(tbl, val)
    return true
end

local gearSum = 0
--
local gears = {}
find(content,"[0-9]+",function(str, first, last)
    local num = str:sub(first,last)
    local len = last-first
    local good = false
    local isgear = false
    local gearPos = -1
    for i=-1,len+1 do
        local posPre = (first + i) - maxX
        local posPost = (first + i) + maxX

        if isSymbol(str:sub(first-1,first-1)) or isSymbol(str:sub(last+1,last+1)) then
            good = true
        end

        if isGear(str:sub(first-1,first-1)) then
            print("Side Gear! First",num,first-1)
            if not gears[first-1] then
                gears[first-1] = {num}
            else
                smartInsert(gears[first-1], num)
            end
            isgear = true
            gearPos = first-1
        end

        if isGear(str:sub(last+1,last+1)) then
            print("Side Gear! Last",num,last-1)
            if not gears[last+1] then
                gears[last+1] = {num}
            else
                smartInsert(gears[last+1], num)
            end
            isgear = true
            gearPos = last+1
        end

        if posPre>=1 then
            local dataPre = str:sub(posPre, posPre)
            if isSymbol(dataPre) then
                good = true
            end
            if isGear(dataPre) then
                if not gears[posPre] then
                    gears[posPre] = {num}
                else
                    smartInsert(gears[posPre], num)
                end
                isgear = true
                gearPos = posPre
            end
        end

        if posPost<=#content then
            local dataPost = str:sub(posPost, posPost)
            if isSymbol(dataPost) then
                good = true
            end
            if isGear(dataPost) then
                if not gears[posPost] then
                    gears[posPost] = {num}
                else
                    smartInsert(gears[posPost], num)
                end
                isgear = true
                gearPos = posPost
            end
        end
    end

    if good then
        print(num,isgear,gearPos)
        sum = sum + tonumber(num)
    end
end)
for i,v in pairs(gears) do
    if #v == 2 then
        gearSum = gearSum + v[1]*v[2]
    end
end
print("Sum: "..sum)
print("GearSum: "..gearSum)

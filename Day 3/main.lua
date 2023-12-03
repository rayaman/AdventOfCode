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

local lines = {}
for line in content:gmatch("(.-)\n") do
    table.insert(lines,line)
end

local maxX = #content:match("(.-)\n")
local _, maxY = content:gsub("(\n)","")
print(maxX, maxY)

local function find(str, substr, callback, init)
    init = init or 1
    local first, last = str:find(substr, init)

    if first then
        callback(str, first, last)
        return find(str, substr, callback, last+1)
    end
 end

local function getCords(grid, num)
    local cords = {}
    find(grid, num, function(str, first, last)
        if first-1 >= 1 and last+1 < #content then
            --print(str:sub(first-1,last+1):match("%d+"),num,str:sub(first-1,last+1):match("%d+")==num)
            if not(str:sub(first-1,last+1):match("%d+")==num) then
                --print("RET")
                return
            end
        end
        x = first % maxX
        y = math.floor(first/maxX + 1) 
        table.insert(cords, {x, y, last-first})
    end)
    return cords
end

local function getAdjacentPoints(x, y, len)
    local adj = {}
    for i=-1,len+1 do
        for v=-1,1 do
            if y+v >=1 and x+i>=1 and y+v>1 and y+v<=maxY-1 and x+i<=maxX-1 then
                table.insert(adj,{x+i,y+v})
            end
        end
    end
    return adj
end

local function getPoint(grid, x, y)
    first = (y-1) * maxX + x
    return grid:sub(first,first)
end

local function getNeighbors(grid, num)
    local cords = getCords(grid, num)
    local neighbors = {}
    for i,v in pairs(cords) do
        local x, y, len = v[1], v[2], v[3]
        local points = getAdjacentPoints(x, y, len)
        for ii,vv in pairs(points) do
            local sym = getPoint(grid, vv[1],vv[2])
            if not sym:match("%.") and not sym:match("[0-9]") then
                -- print(sym, vv[1], vv[2], num)
                -- print(lines[vv[2]-1])
                -- print(lines[vv[2]])
                -- print(lines[vv[2]+1])
                -- io.read()
                return true
            end
        end
    end
    return false
end

local sum = 0

for num in content:gmatch("[0-9]+") do
    if getNeighbors((content:gsub("\n","")), num) then
        sum = sum + tonumber(num)
    end
end
print(sum)
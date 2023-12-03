local file = io.open("input.txt")
local content = file:read("a*")

local reds, greens, blues = 12, 13, 14

local function getRounds(game)
    local rounds = {}
    local r,b,g = 0,0,0
    for str in game:gmatch("([^;]+)") do
        local rnd = (str:gsub("%s+",""))
        local red = tonumber(rnd:match("(%d+)red")) or 0
        local blue = tonumber(rnd:match("(%d+)blue")) or 0
        local green = tonumber(rnd:match("(%d+)green")) or 0
        if red > r then r = red end
        if blue > b then b = blue end
        if green > g then g = green end
    end
    return r*b*g
end

local sum=0
for line in content:gmatch("(.-)\n") do
    id, game = line:match([[Game (%d+): (.+)]])
    local possible = true
    sum = sum + getRounds(game)
end

print(sum)
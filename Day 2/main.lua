local file = io.open("input.txt")
local content = file:read("a*")

local reds, greens, blues = 12, 13, 14

local function getRounds(game)
    local rounds = {}
    for str in game:gmatch("([^;]+)") do
        local rnd = (str:gsub("%s+",""))
        local red = rnd:match("(%d+)red")
        local blue = rnd:match("(%d+)blue")
        local green = rnd:match("(%d+)green")
        table.insert(rounds, {
            red = tonumber(red) or 0, 
            blue = tonumber(blue) or 0, 
            green = tonumber(green) or 0
        })
    end
    return rounds
end

local legit = {}
for line in content:gmatch("(.-)\n") do
    id, game = line:match([[Game (%d+): (.+)]])
    local possible = true
    for i,v in ipairs(getRounds(game)) do
        if not(v.red <= reds and v.green <= greens and v.blue <= blues) then
            possible = false
        end
    end
    if possible then
        legit[id] = true
        possible = true
    end
end

local sum = 0
for i,v in pairs(legit) do
    sum = sum + tonumber(i)
end
print(sum)
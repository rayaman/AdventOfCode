local file = io.open("input.txt")
local content = file:read("a*")
local sum = 0

local function replace(str, i, char)
    local list = {}
    for c in str:gmatch(".") do
        table.insert(list,c)
    end
    list[i] = char
    return table.concat(list)
end

local function find(str, substr, callback, init)
    init = init or 1
    local first, last = str:find(substr, init)
    if first then
        callback(str, first, last)
        return find(str, substr, callback, last+1)
    end
 end

local function sanitize(str)
    local orig = str
    local num = {
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    }

    local nums = {}

    for i,v in pairs(num) do
        find(str,v,function(str, first)
            table.insert(nums, {i, first})
        end)
    end

    table.sort(nums,function(a,b)
        return a[2] < b[2]
    end)

    for i,v in ipairs(nums) do
        str = replace(str, v[2], v[1])
    end

    return str
end

local function getDigits(str)

    local first, last

    str = sanitize(str)

    for digit in str:gmatch(".") do
        if tonumber(digit) then
            if not first then
                first = tonumber(digit)
            else
                last = tonumber(digit)
            end
        end
    end

    last = last or first

    return tonumber(first .. last)
end

for line in content:gmatch("(.-)\n") do
    sum = sum + getDigits(line)
end

print(sum)
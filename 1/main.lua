local file = io.open("input.txt")
local content = file:read("a*")
local sum = 0

local sample = [[two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
]]

local function sanitize(str)
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
        if str:find(v) then
            table.insert(nums, {i, str:find(v)})
        end
    end

    table.sort(nums,function(a,b)
        return a[2] < b[2]
    end)

    if nums >= 2 then

    end
end

local function getDigits(str)

    local first, last

    for digit in str:gmatch(".") do
        if tonumber(digit) then
            if not first then
                first = tonumber(digit)
            else
                last = tonumber(digit)
            end
        else
            if not match then
                match = digit
            else
                match = match .. digit
            end
            local good = false
            for i,v in pairs(num) do
                local len = #match
                if #i >= len and match:sub(len, len) == i:sub(len, len) then
                    good = true
                end
            end
            if not good then
                match = nil
            end
            print(match)
        end
    end

    last = last or first

    return tonumber(first .. last)
end

for line in sample:gmatch("(.-)\n") do
    print(sanitize(line))
    --sum = sum + getDigits(line)
end

print(sum)
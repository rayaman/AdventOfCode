local file = io.open("input.txt")
local content = file:read("a*")

-- content = [[Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
-- Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
-- Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
-- Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
-- Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
-- Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
-- ]]

function string.split (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function calculateCardPoints(matches)
    if matches == 0 then return 0 end
    return 2^(matches-1)
end

function getMatches(card1, card2)
    local matches = 0
    for i,v in pairs(card2) do
        for ii,vv in pairs(card1) do
            if v==vv then
                matches = matches + 1
            end
        end
    end
    return matches
end

local sum = 0
local cards = {}

for card_num, your_num, win_num in content:gmatch("Card%s*(%d+):%s*(.-)%s*|%s*(.-)\n") do
    cards[tonumber(card_num)] = 1
end

for card_num, your_num, win_num in content:gmatch("Card%s*(%d+):%s*(.-)%s*|%s*(.-)\n") do
    local card_num = tonumber(card_num)
    local matches = getMatches(your_num:split(), win_num:split())
    for i=1,matches do
        cards[card_num+i] = cards[card_num+i] + 1 * cards[card_num]
    end
end

for i=1,#cards do
    sum = sum + cards[i]
end
print("Total: "..sum)

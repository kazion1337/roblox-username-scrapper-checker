-- /* Settings *\
local Tell_When_UsernameTaken = true -- If you want it to tell you when it doesnt work
local UsernamesToCheck = 10000 -- How many usernames you want to check.
local CharacterLength = 4 -- How long you want the usernames.
local UpperCaseLetters = true -- If you want Upper Case Letters in username
local LowerCaseLetters = true -- If you want lower case letters in username
local Numbers = false -- If you want numbers inside the string
-- /* Needed Items *\
local httpservice = require("socket.http")
local UpChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local LowChars = "abcdefghijklmnopqrstuvwxyz"
local _Numbers = "1234567890"
local stringDone = ""
local Usernames = {}

-- /* Main Script *\
math.randomseed(os.time())
function Generate()
    local useable = {}
    if Numbers == true then
        table.insert(useable,1,_Numbers)
    end
    if UpperCaseLetters == true then
        table.insert(useable,1,UpChars)
    end
    if LowerCaseLetters == true then
        table.insert(useable,1,LowChars)
    end
    return useable
end

for i=1, UsernamesToCheck do
    for i=1, CharacterLength do
        local mainTable = Generate()
        local Type = mainTable[math.random(1, #mainTable)]
        local Finish = math.random(1, string.len(Type))
        stringDone = stringDone..string.sub(Type, Finish, Finish)
        if string.len(stringDone) == CharacterLength then
            table.insert(Usernames ,stringDone)
            stringDone = ""
        end
    end
end

print("------------| Username Scraper/Checker By Kaeden! |------------")
for i,v in pairs(Usernames) do
    local link = "https://api.roblox.com/users/get-by-username?username="..v
    result = httpservice.request(link)
    if result == '{"success":false,"errorMessage":"User not found"}' then
        print(v.." | Available!")
    else
        if Tell_When_UsernameTaken == true then
            print(v.." | Taken!")
        end
    end
end
print("----------------------------------------------------------------")

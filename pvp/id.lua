local allowedUserIDs = {
    [5135788947] = true
}

local player = game.Players.LocalPlayer
local playerID = player.UserId

local isUserAllowed = allowedUserIDs[playerID]
for _, userID in pairs(allowedUserIDs) do
    if game.Players.LocalPlayer.UserId == userID then
        isUserAllowed = true
        break
    end
end

if not isUserAllowed then
    game.Players.LocalPlayer:Kick("You are not authorized to use this script.")
    return
end

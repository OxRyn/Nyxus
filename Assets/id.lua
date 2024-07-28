local allowedUserIDs = {
	[5301171585] = true,
	[198808362] = true,
	[701960844] = true,
	[3536732697] = true,
	[2444171267] = true,
	[2284763687] = true,
	[4709231043] = true,
	[5199242503] = true,
	[329593171] = true,
	[4450803435] = true,
	[3277265743] = true,
	[5842977595] = true
};
local player = game.Players.LocalPlayer;
local playerID = player.UserId;
local isUserAllowed = allowedUserIDs[playerID];
for _, userID in pairs(allowedUserIDs) do
	if game.Players.LocalPlayer.UserId == userID then
		isUserAllowed = true;
		break;
	end;
end;
if not isUserAllowed then
	game.Players.LocalPlayer:Kick("Spiking. Banned until January 12, 2025 17:20:49");
	return;
end;
(loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus/main/pvp/id.lua")))();

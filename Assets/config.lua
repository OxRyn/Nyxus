local Library = (loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua")))();
local Window = Library.CreateLib("TheFartMan GUI - Age Of Heros", "Ocean");
local Tab = Window:NewTab("AutoFarm Menu");
local MainSection = Tab:NewSection("AutoFarm Menu");
local TargetTab = Window:NewTab("Target Menu");
local TargetSection = TargetTab:NewSection("Target Menu");
local STab = Window:NewTab("Self Menu");
local SSection = STab:NewSection("Self Menu");
local StatTab = Window:NewTab("AutoStat Menu");
local StatSection = StatTab:NewSection("AutoStat Menu");
local TTab = Window:NewTab("Teleport Menu");
local TSection = TTab:NewSection("Teleport Menu");
local KTab = Window:NewTab("Keybind Menu");
local KSection = KTab:NewSection("Keybind Menu");
local MTab = Window:NewTab("Misc Menu");
local MSection = MTab:NewSection("Misc Menu");
local GTab = Window:NewTab("Scripts Menu");
local GSection = GTab:NewSection("Scripts Menu");
_G.CToggle = false;
_G.metalskin = false;
_G.LOCALPLAYER = game.Players.LocalPlayer.Name;
_G.bring = false;
player = game.Players.LocalPlayer;
breakvelocity = function()
	spawn(function()
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0);
		delay(1, function()
			BeenASecond = true;
		end);
		while not BeenASecond do
			for _, v in ipairs(player.Character:GetDescendants()) do
				if v.IsA(v, "BasePart") then
					v.Velocity, v.RotVelocity = V3, V3;
				end;
			end;
			wait();
		end;
	end);
end;
plrlist = {};
plrnum = 0;
getNearPlayer = function(maxDistance)
	pcall(function()
		if player and player.Character then
			local playerLocation = player.Character.HumanoidRootPart.Position;
			for i, v in pairs(game.Players:GetChildren()) do
				if v.Character and v.Character.Health ~= 0 then
					local location = v.Character.HumanoidRootPart.Position;
					if (location - playerLocation).Magnitude <= maxDistance and v.Character.Health ~= 0 then
						pcall(function()
							if v == player then
							else
								local teleexist = (game:GetService("Workspace"))[v.Name].HumanoidRootPart;
								if not teleexist:FindFirstChild("telekinesisPosition") and v.Character.Health ~= 0 then
								elseif v ~= player then
									plrnum += 1;
									table.insert(plrlist, v.Character);
								end;
							end;
						end);
					end;
				end;
			end;
		end;
	end);
end;
GetList = function()
	x = 1;
	Plyr = game.Players:GetPlayers();
	dropdown = {};
	for value in pairs(Plyr) do
		PLR = Plyr[x].Name;
		x += 1;
		table.insert(dropdown, PLR);
	end;
end;
TSection:NewDropdown("Safezone Locations", "", {
	"Bar",
	"Building Park",
	"City Square",
	"Evil Lair",
	"Feild",
	"Hero HQ",
	"Hero Lair",
	"Motel",
	"Mountain",
	"Mountain-2",
	"Park",
	"Plains",
	"Prison"
}, function(currentOption)
	_G.selectedstat = currentOption;
end);
TSection:NewDropdown("Other Locations", "", {
	"Contruction Building",
	"Corner-1",
	"Corner-2",
	"Corner-3",
	"Corner-4",
	"Ignite Tower",
	"Military Base",
	"Mountain Hole",
	"Police Department",
	"Cave"
}, function(currentOption)
	_G.selectedstat = currentOption;
end);
TSection:NewDropdown("Unfortunate Locations", "", {
	"Unfortunate Spot (Secret Area)",
	"Unfortunate Spot (In Building)",
	"Unfortunate Spot (Trap)",
	"Unfortunate Spot (Space)",
	"Unfortunate Spot (Under Map)",
	"Unfortunate Spot (Dead End)",
	"Unfortunate Spot (Box)",
	"Unfortunate Spot (Arena)",
	"Unfortunate Spot (Backrooms)",
	"Unfortunate Spot (Sex Dungeon)"
}, function(currentOption)
	_G.selectedstat = currentOption;
end);
TSection:NewToggle("Teleport Player", "", function(state)
	if state then
		_G.bring = true;
	else
		_G.bring = false;
	end;
end);
TSection:NewButton("Teleport", "", function()
	getNearPlayer(99);
	if _G.selectedstat == "Bar" then
		if _G.bring == true then
			getNearPlayer(99);
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1313, 197, 149);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1313, 197, 149);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Building Park" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1751, 442, 1266);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1751, 442, 1266);
			breakvelocity();
		end;
	elseif _G.selectedstat == "City Square" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-385, 86, 256);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-385, 86, 256);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Evil Lair" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-905, 94, -1086);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-905, 94, -1086);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Feild" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(2355, 81, 4);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2355, 81, 4);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Hero HQ" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(259, 169, 2748);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259, 169, 2748);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Hero Lair" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(2351, 39, -1855);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2351, 39, -1855);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Motel" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1750, 94, -1349);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1750, 94, -1349);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Mountain" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-2206, 817, -2425);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2206, 817, -2425);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Mountain-2" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-2429, 762, -2363);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2429, 762, -2363);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Park" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(1399, 94, 1154);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1399, 94, 1154);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Plains" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-3683, 97, -144);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3683, 97, -144);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Prison" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-779, 269, -2594);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-779, 269, -2594);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Contruction Building" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(650, 779, 284);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(650, 779, 284);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Corner-1" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(2773, 96, -4996);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2773, 96, -4996);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Corner-2" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-3757, 97, -3801);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3757, 97, -3801);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Corner-3" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-3650, 97, 2764);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3650, 97, 2764);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Corner-4" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(2810, 102, 2821);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2810, 102, 2821);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Ignite Tower" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-70, 616, -247);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-70, 616, -247);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Military Base" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(259, 99, -4639);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259, 99, -4639);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Mountain Hole" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-2732, 256, -1776);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2732, 256, -1776);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Police Department" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-62, 94, -480);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-62, 94, -480);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Cave" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(269, -59, 2729);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(269, -59, 2729);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Secret Area)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1100, 61, -1169);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1100, 61, -1169);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (In Building)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-494, 96, -98);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-494, 96, -98);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Trap)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-790, 135, -2769);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-790, 135, -2769);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Space)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(0, 9999999, 0);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 9999999, 0);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Under Map)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(0, 0, 0);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Dead End)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(1453, 98, -2506);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1453, 98, -2506);
			breakvelocity();
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Box)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1695, 94, -1309);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1695, 94, -1309);
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Arena)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1728, 94, -1188);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1728, 94, -1188);
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Backrooms)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1519, 95, -1072);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1519, 95, -1072);
		end;
	elseif _G.selectedstat == "Unfortunate Spot (Sex Dungeon)" then
		if _G.bring == true then
			for i, v in pairs(plrlist) do
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition:Destroy();
				(game:GetService("Workspace"))[v.Name].HumanoidRootPart.CFrame = CFrame.new(-1585, 95, -1159);
				wait(0.2);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
			end;
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1585, 95, -1159);
		end;
	end;
	plrlist = {};
end);
StatSection:NewDropdown("AutoStats", "", {
	"vitality",
	"healing",
	"strength",
	"energy",
	"flight",
	"speed",
	"climbing",
	"swinging",
	"fireball",
	"frost",
	"lightning",
	"power",
	"telekinesis",
	"shield",
	"laserVision",
	"metalSkin"
}, function(currentOption)
	selectedstat = currentOption;
end);
StatSection:NewToggle("Toggle AutoStats", "", function(state)
	if state then
		(getgenv()).AutoStats = true;
		while AutoStats do
			wait(0.1);
			spawn(function()
				(game:GetService("ReplicatedStorage")).Events.UpgradeAbility:InvokeServer(selectedstat);
				(game:GetService("ReplicatedStorage")).Events.UpgradeAbility:InvokeServer(selectedstat);
				(game:GetService("ReplicatedStorage")).Events.UpgradeAbility:InvokeServer(selectedstat);
				(game:GetService("ReplicatedStorage")).Events.UpgradeAbility:InvokeServer(selectedstat);
				(game:GetService("ReplicatedStorage")).Events.UpgradeAbility:InvokeServer(selectedstat);
			end);
		end;
	else
		spawn(function()
			(getgenv()).AutoStats = false;
		end);
	end;
end);
MainSection:NewToggle("Autofarm Orbs", "", function(state)
	if state then
		(getgenv()).OrbFarm = true;
		repeat
			local Playerhead = game.Players.LocalPlayer.Character.Head;
			spawn(function()
				for i, v in pairs((game:GetService("Workspace")).ExperienceOrbs:GetDescendants()) do
					if v.Name == "TouchInterest" and v.Parent then
						firetouchinterest(Playerhead, v.Parent, 0);
					end;
				end;
			end);
			wait(15);
		until OrbFarm == false;
	else
		spawn(function()
			(getgenv()).OrbFarm = false;
		end);
	end;
end);
MainSection:NewToggle("Laser Civilian Farm", "", function(state)
	if state then
		(getgenv()).LaserC = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserC = true;
			while LaserC and part do
				wait();
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Civilian" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
			end;
			event:InvokeServer(false);
		end));
	else
		spawn(function()
			(getgenv()).LaserC = false;
		end);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Laser Police Farm", "", function(state)
	if state then
		(getgenv()).LaserV = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserV = true;
			while LaserV and part do
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Police" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
				wait();
			end;
			event:InvokeServer(false);
		end));
	else
		spawn(function()
			(getgenv()).LaserV = false;
		end);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Laser Thug Farm", "", function(state)
	if state then
		(getgenv()).LaserH = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserH = true;
			while LaserH and part do
				wait();
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Thug" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
			end;
			event:InvokeServer(false);
		end));
	else
		spawn(function()
			(getgenv()).LaserH = false;
		end);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Laser Civilian Farm From Sky", "", function(state)
	if state then
		orbCX = player.Character.HumanoidRootPart.Position.X;
		orbCY = player.Character.HumanoidRootPart.Position.Y;
		orbCZ = player.Character.HumanoidRootPart.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbCX, 2500, orbCZ);
		(getgenv()).LaserC = true;
		wait(0.2);
		player.Character.HumanoidRootPart.Anchored = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserC = true;
			while LaserC and part do
				wait();
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Civilian" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
			end;
			event:InvokeServer(false);
		end));
	else
		player.Character.HumanoidRootPart.Anchored = false;
		spawn(function()
			(getgenv()).LaserC = false;
		end);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbCX, orbCY, orbCZ);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Laser Police Farm From Sky", "", function(state)
	if state then
		orbVX = player.Character.HumanoidRootPart.Position.X;
		orbVY = player.Character.HumanoidRootPart.Position.Y;
		orbVZ = player.Character.HumanoidRootPart.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbVX, 2500, orbVZ);
		(getgenv()).LaserV = true;
		wait(0.2);
		player.Character.HumanoidRootPart.Anchored = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserV = true;
			while LaserV and part do
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Police" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
				wait();
			end;
			event:InvokeServer(false);
		end));
	else
		player.Character.HumanoidRootPart.Anchored = false;
		spawn(function()
			(getgenv()).LaserV = false;
		end);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbVX, orbVY, orbVZ);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Laser Thug Farm From Sky", "", function(state)
	if state then
		orbHX = player.Character.HumanoidRootPart.Position.X;
		orbHY = player.Character.HumanoidRootPart.Position.Y;
		orbHZ = player.Character.HumanoidRootPart.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbHX, 2500, orbHZ);
		(getgenv()).LaserH = true;
		wait(0.2);
		player.Character.HumanoidRootPart.Anchored = true;
		coroutine.resume(coroutine.create(function()
			local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
			local part = event:InvokeServer(true);
			(getgenv()).LaserH = true;
			while LaserH and part do
				wait();
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.ClassName == "Model" and v.Name == "Thug" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						part.Position = v.HumanoidRootPart.Position;
					end;
				end;
			end;
			event:InvokeServer(false);
		end));
	else
		player.Character.HumanoidRootPart.Anchored = false;
		spawn(function()
			(getgenv()).LaserH = false;
		end);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbHX, orbHY, orbHZ);
		breakvelocity();
	end;
end);
MainSection:NewToggle("Civilian Farm", "", function(state)
	if state then
		CivilianX = player.Character.HumanoidRootPart.Position.X;
		CivilianY = player.Character.HumanoidRootPart.Position.Y;
		CivilianZ = player.Character.HumanoidRootPart.Position.Z;
		(getgenv()).Civilian = true;
		while Civilian do
			wait(0.2);
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					if v.ClassName == "Model" and v.Name == "Civilian" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2);
					end;
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).Civilian = false;
			wait(0.2);
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(CivilianX, CivilianY, CivilianZ);
		end);
	end;
end);
MainSection:NewToggle("Police Farm", "", function(state)
	if state then
		PoliceX = player.Character.HumanoidRootPart.Position.X;
		PoliceY = player.Character.HumanoidRootPart.Position.Y;
		PoliceZ = player.Character.HumanoidRootPart.Position.Z;
		(getgenv()).Police = true;
		while Police do
			wait(0.2);
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					if v.ClassName == "Model" and v.Name == "Police" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2);
					end;
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).Police = false;
			wait(0.2);
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(PoliceX, PoliceY, PoliceZ);
		end);
	end;
end);
MainSection:NewToggle("Thug Farm", "", function(state)
	if state then
		thugX = player.Character.HumanoidRootPart.Position.X;
		thugY = player.Character.HumanoidRootPart.Position.Y;
		thugZ = player.Character.HumanoidRootPart.Position.Z;
		(getgenv()).Thug = true;
		while Thug do
			wait(0.2);
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					if v.ClassName == "Model" and v.Name == "Thug" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2);
					end;
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).Thug = false;
			wait(0.2);
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(thugX, thugY, thugZ);
		end);
	end;
end);
SSection:NewToggle("Spawn Point", "", function(state)
	if state then
		(getgenv()).Deathcheck = true;
		local varX = player.Character.UpperTorso.Position.X;
		local varY = player.Character.UpperTorso.Position.Y;
		local varZ = player.Character.UpperTorso.Position.Z;
		spawn(function()
			while Deathcheck do
				local player = game.Players.LocalPlayer.Character.Humanoid.Health;
				if player == 0 then
					wait(6.5);
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
				end;
				wait(1);
			end;
		end);
	else
		spawn(function()
			(getgenv()).Deathcheck = false;
		end);
	end;
end);
SSection:NewToggle("Rapid Punch", "", function(state)
	if state then
		(getgenv()).rapid = true;
		local UserInputService = game:GetService("UserInputService");
		local function onInputEnded(inputObject, gameProcessedEvent)
			if gameProcessedEvent then
				return;
			end;
			if rapid == true then
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					end);
				end;
			end;
		end;
		UserInputService.InputEnded:Connect(onInputEnded);
	else
		spawn(function()
			(getgenv()).rapid = false;
		end);
	end;
end);
SSection:NewToggle("Rapid Heavy Punch", "", function(state)
	if state then
		(getgenv()).Hrapid = true;
		local UserInputService = game:GetService("UserInputService");
		local function onInputEnded(inputObject, gameProcessedEvent)
			if gameProcessedEvent then
				return;
			end;
			if Hrapid == true then
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
				end;
			end;
		end;
		UserInputService.InputEnded:Connect(onInputEnded);
	else
		spawn(function()
			(getgenv()).Hrapid = false;
		end);
	end;
end);
SSection:NewToggle("Super Rapid Punch", "", function(state)
	if state then
		(getgenv()).superrapid = true;
		local UserInputService = game:GetService("UserInputService");
		local function onInputEnded(inputObject, gameProcessedEvent)
			if gameProcessedEvent then
				return;
			end;
			if superrapid == true then
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					end);
				end;
			end;
		end;
		UserInputService.InputEnded:Connect(onInputEnded);
	else
		spawn(function()
			(getgenv()).superrapid = false;
		end);
	end;
end);
SSection:NewToggle("Super Heavy Rapid Punch", "", function(state)
	if state then
		(getgenv()).superhrapid = true;
		local UserInputService = game:GetService("UserInputService");
		local function onInputEnded(inputObject, gameProcessedEvent)
			if gameProcessedEvent then
				return;
			end;
			if superhrapid == true then
				if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
					end);
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
						(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.01, 1);
					end);
				end;
			end;
		end;
		UserInputService.InputEnded:Connect(onInputEnded);
	else
		spawn(function()
			(getgenv()).superhrapid = false;
		end);
	end;
end);
getRoot = function(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso");
	return rootPart;
end;
getRoot = function(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso");
	return rootPart;
end;
Players = game:GetService("Players");
SSection:NewButton("Name Esp", "", function()
	local esp_settings = {
		textsize = 20
	};
	local gui = Instance.new("BillboardGui");
	local esp = Instance.new("TextLabel", gui);
	gui.Name = "esp";
	gui.ResetOnSpawn = false;
	gui.AlwaysOnTop = true;
	gui.LightInfluence = 0;
	gui.Size = UDim2.new(1.75, 0, 1.75, 0);
	esp.BackgroundColor3 = Color3.fromRGB(0, 255, 255);
	esp.Text = "";
	esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
	esp.BorderSizePixel = 4;
	esp.BorderColor3 = Color3.new(0, 255, 255);
	esp.BorderSizePixel = 0;
	esp.Font = "SourceSansSemibold";
	esp.TextSize = esp_settings.textsize;
	esp.TextColor3 = Color3.fromRGB(0, 255, 255);
	(getgenv()).esp = true;
	(game:GetService("RunService")).RenderStepped:Connect(function()
		for i, v in pairs((game:GetService("Players")):GetPlayers()) do
			if v ~= (game:GetService("Players")).LocalPlayer and Players.LocalPlayer.Character and v.Character.Head:FindFirstChild("esp") == nil then
				esp.Text = "Name: " .. v.Name .. "";
				(gui:Clone()).Parent = v.Character.Head;
			end;
		end;
	end);
end);
SSection:NewToggle("GodMode", "", function(state)
	if state then
		local varX = player.Character.UpperTorso.Position.X;
		local varY = player.Character.UpperTorso.Position.Y;
		local varZ = player.Character.UpperTorso.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2142, -195, -1925);
		wait(0.2);
		player.Character.UpperTorso.Waist:Destroy();
		player.Character.Head.Anchored = true;
		wait(2);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	else
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		player.Character:BreakJoints();
		wait(6.5);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	end;
end);
SSection:NewToggle("Invisibility", "", function(state)
	if state then
		local varX = player.Character.UpperTorso.Position.X;
		local varY = player.Character.UpperTorso.Position.Y;
		local varZ = player.Character.UpperTorso.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2711, 229, -1769);
		wait(0.2);
		(game:GetService("Workspace"))[_G.LOCALPLAYER].LowerTorso.Root:Destroy();
		wait(2);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	else
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		player.Character:BreakJoints();
		wait(6.5);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	end;
end);
SSection:NewToggle("Invisibility With Godmode", "", function(state)
	if state then
		local varX = player.Character.UpperTorso.Position.X;
		local varY = player.Character.UpperTorso.Position.Y;
		local varZ = player.Character.UpperTorso.Position.Z;
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-320, 86, 271);
		wait(0.2);
		(game:GetService("Workspace"))[_G.LOCALPLAYER].LowerTorso.Root:Destroy();
		wait(2);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	else
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		player.Character:BreakJoints();
		wait(6.5);
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
	end;
end);
SSection:NewToggle("Hide Title Gui", "", function(state)
	if state then
		(getgenv()).hide = true;
		while hide do
			wait();
			if game.Players.LocalPlayer.Character then
				local rP = game.Players.LocalPlayer.Character.HumanoidRootPart;
				if rP and rP:FindFirstChild("titleGui") then
					rP.titleGui:Destroy();
				end;
			end;
		end;
	else
		spawn(function()
			(getgenv()).hide = false;
		end);
	end;
end);
SSection:NewToggle("Anti-Grab", "", function(state)
	if state then
		(getgenv()).localtele = true;
		spawn(function()
			while localtele do
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[_G.LOCALPLAYER].Character);
				wait();
			end;
		end);
	else
		spawn(function()
			(getgenv()).localtele = false;
		end);
	end;
end);
SSection:NewToggle("Auto MetalSkin", "Auto Turns On MetalSkin", function(state)
	if state then
		(getgenv()).metal = true;
		while metal do
			wait(0.2);
			spawn(function()
				(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", true);
			end);
		end;
	else
		spawn(function()
			(getgenv()).metal = false;
			wait(0.2);
			(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", false);
		end);
	end;
end);
SSection:NewToggle("Destroy ForceFeild", "Turns Of The Forcefeild Around You When You Die", function(state)
	if state then
		(getgenv()).ff = true;
		while ff do
			wait(0.2);
			spawn(function()
				(game:GetService("Workspace"))[_G.LOCALPLAYER].ForceField:Destroy();
			end);
		end;
	else
		spawn(function()
			(getgenv()).ff = false;
		end);
	end;
end);
SSection:NewToggle("Telekinesis Lock Aura", "", function(state)
	if state then
		(getgenv()).teleaura = true;
		while teleaura do
			wait();
			spawn(function()
				local LookVector = game.Workspace.Camera.CFrame.LookVector;
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, true);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, false);
			end);
		end;
	else
		spawn(function()
			(getgenv()).teleaura = false;
		end);
	end;
end);
SSection:NewToggle("Telekinesis Space Fling", "", function(state)
	if state then
		(getgenv()).telesauras = true;
		while telesauras do
			wait(0.2);
			spawn(function()
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(999999, 999999, 999999), true);
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(999999, 999999, 999999), false);
			end);
		end;
	else
		spawn(function()
			(getgenv()).telesauras = false;
		end);
	end;
end);
SSection:NewToggle("Safe Teleport", "", function(state)
	if state then
		local player1 = game.Players.LocalPlayer.Character.Humanoid.Health;
		local math = player1 / 3;
		(getgenv()).st = true;
		while st do
			task.wait();
			spawn(function()
				local player = game.Players.LocalPlayer.Character.Humanoid.Health;
				if player < math then
					(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[_G.LOCALPLAYER].Character);
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1368.27539, 195.429108, 195.75, 0, 0, -1, 0, 1, 0, 1, 0, 0);
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).st = false;
		end);
	end;
end);
SSection:NewToggle("Anti-Knockback", "", function(state)
	if state then
		(getgenv()).AntiKnockback = true;
		while AntiKnockback do
			task.wait();
			spawn(function()
				local PrimaryPart = player.Character.PrimaryPart;
				if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
					PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
					PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
					PrimaryPart.CFrame = LastPosition;
				elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
					LastPosition = PrimaryPart.CFrame;
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).AntiKnockback = false;
		end);
	end;
end);
SSection:NewToggle("Anti-Fling", "", function(state)
	if state then
		player.Character.HumanoidRootPart.Anchored = true;
	else
		player.Character.HumanoidRootPart.Anchored = false;
	end;
end);
MSection:NewSlider("Speed", "", 2000, 16, function(s)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s;
end);
MSection:NewSlider("Jump", "", 700, 50, function(s)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = s;
end);
MSection:NewButton("Inf jump", "", function()
	(game:GetService("UserInputService")).JumpRequest:connect(function()
		((game:GetService("Players")).LocalPlayer.Character:FindFirstChildOfClass("Humanoid")):ChangeState("Jumping");
	end);
end);
MSection:NewButton("Destroy Safezone & Parts", "", function()
	(game:GetService("Workspace")).City.Buildings:Destroy();
	(game:GetService("Workspace")).City.Interactive.Bank.Model:Destroy();
	((game:GetService("Workspace")).City.Interactive["Police Station"]:GetChildren())[28]:Destroy();
	(game:GetService("Workspace")).City.Interactive.Grove.WareHouse:Destroy();
	((game:GetService("Workspace")).City.Interactive["Main Plaza"]:GetChildren())[38]:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
	(game:GetService("Workspace")).SafeZones.Barrier:Destroy();
end);
MSection:NewButton("Anti-Lag", "", function()
	local Terrain = workspace:FindFirstChildOfClass("Terrain");
	Terrain.WaterWaveSize = 0;
	Terrain.WaterWaveSpeed = 0;
	Terrain.WaterReflectance = 0;
	Terrain.WaterTransparency = 0;
	(settings()).Rendering.QualityLevel = 1;
	for i, v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic";
			v.Reflectance = 0;
		elseif v:IsA("Decal") then
			v.Transparency = 1;
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0);
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1;
			v.BlastRadius = 1;
		end;
	end;
	workspace.DescendantAdded:Connect(function(child)
		(coroutine.wrap(function()
			if child:IsA("ForceField") then
				RunService.Heartbeat:Wait();
				child:Destroy();
			elseif child:IsA("Sparkles") then
				RunService.Heartbeat:Wait();
				child:Destroy();
			elseif child:IsA("Smoke") or child:IsA("Fire") then
				RunService.Heartbeat:Wait();
				child:Destroy();
			end;
		end))();
	end);
end);
MSection:NewButton("Ground Crack Lag", "", function(state)
	for i = 1, 1000 do
		(game:GetService("ReplicatedStorage")).Events.GroundCrack:FireServer();
	end;
end);
MSection:NewButton("Mini Ground Crack Lag", "", function(state)
	for i = 1, 500 do
		(game:GetService("ReplicatedStorage")).Events.GroundCrack:FireServer();
	end;
end);
MSection:NewButton("Mini Mini Ground Crack Lag", "", function(state)
	for i = 1, 200 do
		(game:GetService("ReplicatedStorage")).Events.GroundCrack:FireServer();
	end;
end);
MSection:NewButton("Mini Crash", "", function(state)
	local x = 0;
	repeat
		x += 1;
		(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer("true");
	until x == 5000;
	(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer(false);
	wait();
	(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer(false);
end);
MSection:NewButton("Super Crash", "", function(state)
	local x = 0;
	local y = 0;
	local z = 0;
	spawn(function()
		repeat
			x += 1;
			(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer("true");
		until x == 5000;
	end);
	spawn(function()
		repeat
			y += 1;
			(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer("true");
		until y == 5000;
	end);
	spawn(function()
		repeat
			z += 1;
			(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer("true");
		until z == 5000;
	end);
	(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer(false);
	wait();
	(game:GetService("ReplicatedStorage")).Events.ToggleBlocking:FireServer(false);
end);
GetList();
local slcplr = TargetSection:NewDropdown("Select Player", "", dropdown, function(currentOption)
	spawn(function()
		_G.tplayer = currentOption;
	end);
end);
MSection:NewButton("Break Velocity", "", function()
	breakvelocity();
end);
MSection:NewButton("Reset", "", function()
	player.Character:BreakJoints();
end);
TargetSection:NewButton("Refresh Dropdown", "", function()
	spawn(function()
		GetList();
		slcplr:Refresh(dropdown);
	end);
end);
TargetSection:NewButton("Teleport To Player", "", function()
	spawn(function()
		local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart;
		p1.CFrame = game.Players[_G.tplayer].Character.HumanoidRootPart.CFrame;
		breakvelocity();
	end);
end);
TargetSection:NewToggle("Spectate Player", "", function(state)
	spawn(function()
		if state then
			spawn(function()
				(getgenv()).watch = true;
				while watch do
					spawn(function()
						viewing = game.Players[_G.tplayer];
						workspace.CurrentCamera.CameraSubject = viewing.Character;
					end);
					wait();
				end;
			end);
		else
			spawn(function()
				(getgenv()).watch = false;
				viewing = game.Players.LocalPlayer;
				workspace.CurrentCamera.CameraSubject = viewing.Character;
				wait();
				(getgenv()).watch = false;
				viewing = game.Players.LocalPlayer;
				workspace.CurrentCamera.CameraSubject = viewing.Character;
			end);
		end;
	end);
end);
TargetSection:NewToggle("Kill Player", "", function(state)
	if state then
		(getgenv()).killplr = true;
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		wait();
		local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart;
		local pos = p1.CFrame;
		(getgenv()).breakv = true;
		spawn(function()
			while breakv do
				breakvelocity();
				(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", true);
				wait(1);
			end;
		end);
		spawn(function()
			while killplr do
				task.wait();
				task.wait();
				task.wait();
				task.wait();
				task.wait();
				task.wait();
				spawn(function()
					pcall(function()
						for i, v in pairs(game.Workspace:GetChildren()) do
							if v.Name == _G.tplayer and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1);
							end;
						end;
					end);
				end);
				spawn(function()
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
					(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
				end);
				spawn(function()
					local LookVector = game.Workspace.Camera.CFrame.LookVector;
					(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, true);
					(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, false);
				end);
				spawn(function()
					if killplr == false then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
					end;
				end);
			end;
		end);
	else
		spawn(function()
			(getgenv()).breakv = false;
			wait(0.2);
			(getgenv()).killplr = false;
			wait(0.1);
			(getgenv()).killplr = true;
			breakvelocity();
		end);
	end;
end);
TargetSection:NewToggle("Stick To Player", "", function(state)
	if state then
		(getgenv()).loopgoto = true;
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		wait();
		local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart;
		local pos = p1.CFrame;
		(getgenv()).breakv = true;
		spawn(function()
			while breakv do
				wait(1);
				breakvelocity();
			end;
		end);
		while loopgoto do
			task.wait();
			spawn(function()
				pcall(function()
					for i, v in pairs(game.Workspace:GetChildren()) do
						if v.Name == _G.tplayer and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3);
						end;
					end;
				end);
			end);
			spawn(function()
				if loopgoto == false then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).breakv = false;
			wait(0.2);
			(getgenv()).loopgoto = false;
			wait(0.1);
			(getgenv()).loopgoto = true;
			breakvelocity();
		end);
	end;
end);
TargetSection:NewToggle("Fling Player", "", function(state)
	if state then
		(getgenv()).fling = true;
		local varX = player.Character.HumanoidRootPart.Position.X;
		local varY = player.Character.HumanoidRootPart.Position.Y;
		local varZ = player.Character.HumanoidRootPart.Position.Z;
		wait();
		local p1 = game.Players.LocalPlayer.Character.HumanoidRootPart;
		local pos = p1.CFrame;
		(getgenv()).Flingvel = true;
		for _, child in pairs(player.Character:GetDescendants()) do
			if child:IsA("BasePart") then
				child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 0.3, 0.5);
			end;
		end;
		local bambam = Instance.new("BodyAngularVelocity");
		bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart;
		bambam.AngularVelocity = Vector3.new(0, 1000, 0);
		bambam.MaxTorque = Vector3.new(0, math.huge, 0);
		local Char = player.Character:GetChildren();
		for i, v in next, Char do
			if v:IsA("BasePart") then
				v.CanCollide = false;
				v.Massless = true;
				v.Velocity = Vector3.new(0, 0, 0);
			end;
		end;
		while fling do
			task.wait();
			spawn(function()
				pcall(function()
					for i, v in pairs(game.Workspace:GetChildren()) do
						if v.Name == _G.tplayer and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							(game:GetService("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0);
						end;
					end;
				end);
			end);
			spawn(function()
				local PrimaryPart = player.Character.PrimaryPart;
				if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
					PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
					PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
					PrimaryPart.CFrame = LastPosition;
				elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
					LastPosition = PrimaryPart.CFrame;
				end;
			end);
			spawn(function()
				if fling == false then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(varX, varY, varZ);
				end;
			end);
		end;
	else
		spawn(function()
			(getgenv()).fling = false;
			wait(0.1);
			(getgenv()).fling = true;
		end);
		local playerChar = player.Character;
		if not playerChar or (not getRoot(playerChar)) then
			return;
		end;
		for i, v in pairs((getRoot(playerChar)):GetChildren()) do
			if v.ClassName == "BodyAngularVelocity" then
				v:Destroy();
			end;
		end;
		for _, child in pairs(playerChar:GetDescendants()) do
			if child.ClassName == "Part" or child.ClassName == "MeshPart" then
				child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5);
			end;
		end;
		breakvelocity();
	end;
end);
TargetSection:NewToggle("Gives Player Anti-Tele", "Gives Assigned Player Anti Tele", function(state)
	spawn(function()
		if state then
			(getgenv()).at = true;
			while at do
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(0, 0, 0), false, (game:GetService("Players"))[_G.tplayer].Character);
				wait(0.1);
			end;
		else
			(getgenv()).at = false;
		end;
	end);
end);
TargetSection:NewToggle("Laser", "", function(state)
	spawn(function()
		if state then
			(getgenv()).LaserL = true;
			wait();
			coroutine.resume(coroutine.create(function()
				local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
				local part = event:InvokeServer(true);
				(getgenv()).LaserL = true;
				while LaserL and part and _G.tplayer do
					wait();
					local target = game.Players:FindFirstChild(_G.tplayer);
					if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
						part.Position = target.Character.HumanoidRootPart.Position;
					end;
				end;
				event:InvokeServer(false);
			end));
		else
			spawn(function()
				(getgenv()).LaserL = false;
			end);
		end;
	end);
end);
TargetSection:NewToggle("Laser From Sky", "Laser Beams Assigned Player From Sky", function(state)
	spawn(function()
		if state then
			orbX = player.Character.HumanoidRootPart.Position.X;
			orbY = player.Character.HumanoidRootPart.Position.Y;
			orbZ = player.Character.HumanoidRootPart.Position.Z;
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbX, 5000, orbZ);
			(getgenv()).LaserL = true;
			wait(0.2);
			player.Character.HumanoidRootPart.Anchored = true;
			coroutine.resume(coroutine.create(function()
				local event = (game:GetService("ReplicatedStorage")).Events.ToggleLaserVision;
				local part = event:InvokeServer(true);
				(getgenv()).LaserL = true;
				while LaserL and part and _G.tplayer do
					wait();
					local target = game.Players:FindFirstChild(_G.tplayer);
					if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
						part.Position = target.Character.HumanoidRootPart.Position;
					end;
				end;
				event:InvokeServer(false);
			end));
		else
			player.Character.HumanoidRootPart.Anchored = false;
			spawn(function()
				(getgenv()).LaserL = false;
			end);
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(orbX, orbY, orbZ);
			breakvelocity();
		end;
	end);
end);
TargetSection:NewToggle("Give Orbs", "", function(state)
	spawn(function()
		if state then
			(getgenv()).ORBGIVE = true;
			while ORBGIVE do
				local character = (game.Players:FindFirstChild(_G.tplayer)).Character;
				for i, v in pairs((game:GetService("Workspace")).ExperienceOrbs:GetChildren()) do
					local hrp = character.HumanoidRootPart;
					v.CFrame = hrp.CFrame;
				end;
				wait();
			end;
		else
			spawn(function()
				(getgenv()).ORBGIVE = false;
			end);
		end;
	end);
end);
TargetSection:NewButton("Remove Gyro", "", function()
	(game:GetService("Workspace"))[_G.tplayer].HumanoidRootPart.telekinesisGyro:Destroy();
	(game:GetService("Workspace"))[_G.tplayer].HumanoidRootPart.telekinesisPosition:Destroy();
	(game:GetService("Workspace"))[_G.tplayer].Humanoid.PlatformStand = false;
	(game:GetService("Workspace"))[_G.tplayer].Humanoid.WalkSpeed = 200;
	(game:GetService("Workspace"))[_G.tplayer].Humanoid.JumpPower = 150;
end);
TargetSection:NewToggle("Disable Telekinesis", "", function(state)
	spawn(function()
		if state then
			Players = game:GetService("Players");
			for i, player in pairs(Players:GetPlayers()) do
				(getgenv()).LToggle = true;
				spawn(function()
					while LToggle do
						wait();
						(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[player.Name].Character);
					end;
				end);
			end;
		else
			spawn(function()
				(getgenv()).LToggle = false;
			end);
		end;
	end);
end);
KSection:NewKeybind("MetalSkin", "", Enum.KeyCode.LeftShift, function()
	if _G.metalskin == false then
		(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", true);
		_G.metalskin = true;
	else
		(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", false);
		_G.metalskin = false;
	end;
end);
KSection:NewKeybind("Carry Player", "", Enum.KeyCode.H, function()
	if _G.CToggle == false then
		spawn(function()
			getNearPlayer(99);
			wait();
			_G.CToggle = true;
			(getgenv()).CarryP = true;
			while CarryP do
				wait();
				spawn(function()
					for i, v in pairs(plrlist) do
						if v == player then
						else
							Xt = player.Character.HumanoidRootPart.Position.X;
							Yt = player.Character.HumanoidRootPart.Position.Y;
							Zt = player.Character.HumanoidRootPart.Position.Z;
							(game:GetService("Workspace"))[v.Name].HumanoidRootPart.telekinesisPosition.Position = Vector3.new(Xt, Yt + 8, Zt + 5);
						end;
					end;
				end);
			end;
		end);
	else
		spawn(function()
			_G.CToggle = false;
			plrlist = {};
			(getgenv()).CarryP = false;
		end);
	end;
end);
KSection:NewKeybind("Telekinesis Lock", "", Enum.KeyCode.T, function()
	spawn(function()
		local LookVector = game.Workspace.Camera.CFrame.LookVector;
		(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, true);
		(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(LookVector, false);
	end);
end);
KSection:NewKeybind("Telekinesis kill", "", Enum.KeyCode.G, function()
	spawn(function()
		getNearPlayer(99);
		for i, v in pairs(plrlist) do
			if v == player then
			else
				spawn(function()
					v.Head.Neck:Destroy();
					v.Head.Neck:Destroy();
					plrlist = {};
					spawn(function()
						(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[v.Name].Character);
					end);
				end);
			end;
		end;
	end);
end);
KSection:NewKeybind("Release Telekinesis", "", Enum.KeyCode.C, function()
	plrlist = {};
	Players = game:GetService("Players");
	for i, player in pairs(Players:GetPlayers()) do
		spawn(function()
			(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[player.Name].Character);
		end);
	end;
end);
KSection:NewKeybind("Teleport To Motel", "", Enum.KeyCode.Z, function()
	if _G.bring == true then
		(game:GetService("Workspace"))[_G.teleportplayer].HumanoidRootPart.telekinesisPosition:Destroy();
		(game:GetService("Workspace"))[_G.teleportplayer].HumanoidRootPart.CFrame = CFrame.new(-1745, 95, -1530);
		wait(0.2);
		(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[_G.teleportplayer].Character);
	else
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1745, 95, -1530);
	end;
	breakvelocity();
end);
KSection:NewKeybind("Teleport To Middle", "", Enum.KeyCode.V, function()
	if _G.bring == true then
		(game:GetService("Workspace"))[_G.teleportplayer].HumanoidRootPart.telekinesisPosition:Destroy();
		(game:GetService("Workspace"))[_G.teleportplayer].HumanoidRootPart.CFrame = CFrame.new(-376, 94, 91);
		wait(0.2);
		(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(1, 1, 1), false, game.Players[_G.teleportplayer].Character);
	else
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-376, 94, 91);
	end;
	breakvelocity();
end);
KSection:NewKeybind("Toggle UI", "", Enum.KeyCode.RightShift, function()
	Library:ToggleUI();
end);
GSection:NewButton("Infinite Yield", "", function()
	(loadstring(game:HttpGet("https://pastebin.com/raw/aCmksbMy")))();
end);
GSection:NewButton("Chat Spammer", "", function()
	(loadstring(game:HttpGet("https://raw.githubusercontent.com/ColdStep2/Chatdestroyer-Hub-V1/main/Chatdestroyer%20Hub%20V1", true)))();
end);
GSection:NewButton("Chat Spoofer", "", function()
	(loadstring(game:HttpGet("https://pastebin.com/raw/djBfk8Li", true)))();
end);
GSection:NewButton("Zen X", "", function()
	(loadstring(game:HttpGet("https://raw.githubusercontent.com/laderite/zenhub/main/script")))();
end);
GSection:NewButton("Grandenebbia", "", function()
	(loadstring(game:HttpGet("https://pastebin.com/raw/cJ9CtKZ9")))();
end);
GSection:NewButton("Motion Blur", "", function()
	(loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/MotionBlur.xml")))();
end);
local MainSection = Tab:NewSection("Made By Killo");
local TargetSection = TargetTab:NewSection("Made By Killo");
local SSection = STab:NewSection("Made By Killo");
local StatSection = StatTab:NewSection("Made By Killo");
local TSection = TTab:NewSection("Made By Killo");
local MSection = MTab:NewSection("Made By Killo");
local KSection = KTab:NewSection("Made By Killo");
local GSection = GTab:NewSection("Made By Killo");
print("I skidded this script Bruuuuhhhh");

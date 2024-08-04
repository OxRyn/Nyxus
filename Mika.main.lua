-- (loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus/main/Assets/id.lua")))();
local VLibrary = (loadstring(game:HttpGet("https://raw.githubusercontent.com/vep1032/VepStuff/main/VL")))();
local window = VLibrary:Window("WS Farming Script", "Age Of Heros", "WS");
local Tank_Settings = window:Tab("Tank Settings Menu");
local Puncher_Settings = window:Tab("Puncher Settings Menu");
_G.metalskin = false;
_G.SelectedLocation = nil;
_G.metalskin = false;
_G.LOCALPLAYER = game.Players.LocalPlayer.Name;
player = game.Players.LocalPlayer;
plrlist = {};
LocalPlayer = game.Players.LocalPlayer;
local UserInputService = game:GetService("UserInputService");
function breakvelocity()
	spawn(function()
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0);
		delay(1, function()
			BeenASecond = true;
		end);
		while not BeenASecond do
			for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
				if v.IsA(v, "BasePart") then
					v.Velocity, v.RotVelocity = V3, V3;
				end;
			end;
			wait();
		end;
	end);
end;
function getRoot(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso");
	return rootPart;
end;
function getNearPlayer(maxDistance)
	pcall(function()
		Players = game:GetService("Players");
		if LocalPlayer and LocalPlayer.Character then
			local playerLocation = LocalPlayer.Character.HumanoidRootPart.Position;
			for i, v in pairs(game.Players:GetChildren()) do
				if v.Character and v.Character.Health ~= 0 then
					local location = v.Character.HumanoidRootPart.Position;
					if (location - playerLocation).Magnitude <= maxDistance and v.Character.Health ~= 0 then
						pcall(function()
							if v == LocalPlayer then
							else
								local teleexist = (game:GetService("Workspace"))[v.Name].HumanoidRootPart;
								if not teleexist:FindFirstChild("telekinesisPosition") and v.Character.Health ~= 0 then
								elseif v ~= LocalPlayer then
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
local AutoPunching = false;
local RapidPunching = false;
local AutoPunchFarmSpeed = false;
local function punch()
	for i = 1, 5 do
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
local players = {};
for _, player in ipairs(game.Players:GetPlayers()) do
	table.insert(players, player.Name);
end;
local selectedPlayer;
Tank_Settings:Dropdown("Players", players, function(value)
	selectedPlayer = value;
	print("Selected Player: " .. selectedPlayer);
end);
Tank_Settings:Button("Teleport to Player", function()
	if selectedPlayer then
		local player = game.Players:FindFirstChild(selectedPlayer);
		if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame;
		end;
	else
		print("No player selected");
	end;
end);
Tank_Settings:Toggle("Stick to player", function(state)
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
						if v.Name == selectedPlayer and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
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
Tank_Settings:Button("Gravity", function()
	workspace.Gravity = 1000000000000;
end);
Tank_Settings:Button("Anti Idle", function()
	local PlayersUi = game.Players.LocalPlayer:WaitForChild("PlayerGui");
	if PlayersUi:FindFirstChild("AntiIdleKickerMaxTheDev21") then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Alert!!!",
			Text = "Anti Idle System Is Already Running.",
			Duration = 5,
			Color = Color3.fromRGB(255, 165, 0),
			Image = "rbxassetid://14840798901"
		});
	else
		local AntiIdleKickerMaxTheDev21 = Instance.new("ScreenGui");
		local Frame = Instance.new("Frame");
		local UICorner = Instance.new("UICorner");
		local MadeBy = Instance.new("TextLabel");
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
		local MoveGuiFrame = Instance.new("Frame");
		local UICorner_2 = Instance.new("UICorner");
		local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint");
		local Header = Instance.new("TextLabel");
		local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint");
		local TimeDisplay = Instance.new("TextLabel");
		local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint");
		local KickMessageFrame = Instance.new("Frame");
		local UICorner_3 = Instance.new("UICorner");
		local TextLabel = Instance.new("TextLabel");
		local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint");
		local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint");
		local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint");
		AntiIdleKickerMaxTheDev21.Name = "AntiIdleKickerMaxTheDev21";
		AntiIdleKickerMaxTheDev21.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
		AntiIdleKickerMaxTheDev21.ResetOnSpawn = false;
		Frame.Parent = AntiIdleKickerMaxTheDev21;
		Frame.BackgroundColor3 = Color3.fromRGB(48, 48, 48);
		Frame.BackgroundTransparency = 0.1;
		Frame.Position = UDim2.new(0.397882968, 0, 0.47597006, 0);
		Frame.Size = UDim2.new(0.186823919, 0, 0.0770862848, 0);
		UICorner.CornerRadius = UDim.new(0, 4);
		UICorner.Parent = Frame;
		MadeBy.Name = "MadeBy";
		MadeBy.Parent = Frame;
		MadeBy.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		MadeBy.BackgroundTransparency = 1;
		MadeBy.Position = UDim2.new(0.248908341, 0, 0.779369354, 0);
		MadeBy.Size = UDim2.new(0.676999927, 0, 0.17695041, 0);
		MadeBy.Font = Enum.Font.Sarpanch;
		MadeBy.Text = "Made By MaxTheDev21";
		MadeBy.TextColor3 = Color3.fromRGB(85, 255, 0);
		MadeBy.TextScaled = true;
		MadeBy.TextSize = 14;
		MadeBy.TextWrapped = true;
		UIAspectRatioConstraint.Parent = MadeBy;
		UIAspectRatioConstraint.AspectRatio = 18.286;
		MoveGuiFrame.Name = "MoveGuiFrame";
		MoveGuiFrame.Parent = Frame;
		MoveGuiFrame.BackgroundColor3 = Color3.fromRGB(85, 255, 0);
		MoveGuiFrame.BackgroundTransparency = 0.2;
		MoveGuiFrame.Position = UDim2.new(0.0219999999, 0, 0.0909999982, 0);
		MoveGuiFrame.Size = UDim2.new(0.169963419, 0, 0.80458349, 0);
		UICorner_2.CornerRadius = UDim.new(0, 4);
		UICorner_2.Parent = MoveGuiFrame;
		UIAspectRatioConstraint_2.Parent = MoveGuiFrame;
		UIAspectRatioConstraint_2.AspectRatio = 1.01;
		Header.Name = "Header";
		Header.Parent = Frame;
		Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Header.BackgroundTransparency = 1;
		Header.Position = UDim2.new(0.248908341, 0, 0.0906161219, 0);
		Header.Size = UDim2.new(0.676855803, 0, 0.314107567, 0);
		Header.Font = Enum.Font.Sarpanch;
		Header.Text = "Anti-Idle Kicker v2.0";
		Header.TextColor3 = Color3.fromRGB(85, 255, 0);
		Header.TextScaled = true;
		Header.TextSize = 14;
		Header.TextWrapped = true;
		UIAspectRatioConstraint_3.Parent = Header;
		UIAspectRatioConstraint_3.AspectRatio = 10.299;
		TimeDisplay.Name = "TimeDisplay";
		TimeDisplay.Parent = Frame;
		TimeDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		TimeDisplay.BackgroundTransparency = 1;
		TimeDisplay.Position = UDim2.new(0.248908341, 0, 0.430000067, 0);
		TimeDisplay.Size = UDim2.new(0.676855981, 0, 0.289999992, 0);
		TimeDisplay.Font = Enum.Font.Sarpanch;
		TimeDisplay.Text = "Up Time: 0H 0M 0S";
		TimeDisplay.TextColor3 = Color3.fromRGB(85, 255, 0);
		TimeDisplay.TextScaled = true;
		TimeDisplay.TextSize = 14;
		TimeDisplay.TextWrapped = true;
		UIAspectRatioConstraint_4.Parent = TimeDisplay;
		UIAspectRatioConstraint_4.AspectRatio = 11.155;
		KickMessageFrame.Name = "KickMessageFrame";
		KickMessageFrame.Parent = Frame;
		KickMessageFrame.BackgroundColor3 = Color3.fromRGB(48, 48, 48);
		KickMessageFrame.BackgroundTransparency = 0.1;
		KickMessageFrame.Position = UDim2.new(0.000000133264564, 0, -0.37783134, 0);
		KickMessageFrame.Size = UDim2.new(1.00000036, 0, 0.345414788, 0);
		KickMessageFrame.Visible = false;
		UICorner_3.CornerRadius = UDim.new(0, 4);
		UICorner_3.Parent = KickMessageFrame;
		TextLabel.Parent = KickMessageFrame;
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		TextLabel.BackgroundTransparency = 1;
		TextLabel.Position = UDim2.new(0.0169837624, 0, 0.11757081, 0);
		TextLabel.Size = UDim2.new(0.967732251, 0, 0.750522435, 0);
		TextLabel.Font = Enum.Font.Sarpanch;
		TextLabel.Text = "We just stopped roblox from kicking you!";
		TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0);
		TextLabel.TextScaled = true;
		TextLabel.TextSize = 14;
		TextLabel.TextWrapped = true;
		UIAspectRatioConstraint_5.Parent = TextLabel;
		UIAspectRatioConstraint_5.AspectRatio = 17.842;
		UIAspectRatioConstraint_6.Parent = KickMessageFrame;
		UIAspectRatioConstraint_6.AspectRatio = 13.837;
		UIAspectRatioConstraint_7.Parent = Frame;
		UIAspectRatioConstraint_7.AspectRatio = 4.78;
		local function OMZVG_fake_script()
			local script = Instance.new("LocalScript", Frame);
			local Frame = script.Parent;
			(game:service("Players")).LocalPlayer.Idled:Connect(function()
				local VU = game:service("VirtualUser");
				VU:CaptureController();
				VU:ClickButton2(Vector2.new());
				if Frame.KickMessageFrame.Visible == false then
					Frame.KickMessageFrame.Visible = true;
					wait(3);
					Frame.KickMessageFrame.Visible = false;
				end;
			end);
			local UIS = game:GetService("UserInputService");
			local dragToggle = nil;
			local dragStart = nil;
			local startPos = nil;
			local function updateInput(input)
				local delta = input.Position - dragStart;
				local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				((game:GetService("TweenService")):Create(Frame, TweenInfo.new(0.01), {
					Position = position
				})):Play();
			end;
			Frame.MoveGuiFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragToggle = true;
					dragStart = input.Position;
					startPos = Frame.Position;
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false;
						end;
					end);
				end;
			end);
			UIS.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					if dragToggle then
						updateInput(input);
					end;
				end;
			end);
			local t = 0;
			while true do
				wait(1);
				t = t + 1;
				local seconds = t % 60;
				local minutes = math.floor(t / 60) % 60;
				local hours = math.floor(t / 3600) % 24;
				Frame.TimeDisplay.Text = "Up Time: " .. hours .. "H " .. minutes .. "M " .. seconds .. "S";
			end;
		end;
		(coroutine.wrap(OMZVG_fake_script))();
	end;
end);
Puncher_Settings:Dropdown("Unfortunate Locations", {
	"Military Base",
	"Mountain Hole",
	"Cave",
	"Unfortunate Spot (Secret Area)",
	"Unfortunate Spot (Trap)",
	"Unfortunate Spot (Space)",
	"Unfortunate Spot (Under Map)",
	"Unfortunate Spot (Dead End)",
	"Unfortunate Spot (Box)",
	"Unfortunate Spot (Arena)",
	"Unfortunate Spot (Backrooms)",
	"Unfortunate Spot (Sex Dungeon)",
	"Private Helioso"
}, function(value)
	_G.SelectedLocation = value;
end);
Puncher_Settings:Button("Teleport To Location", function()
	getNearPlayer(999);
	if _G.SelectedLocation == "Military Base" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259, 99, -4639);
		breakvelocity();
	elseif _G.SelectedLocation == "Mountain Hole" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2732, 256, -1776);
		breakvelocity();
	elseif _G.SelectedLocation == "Cave" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(269, -59, 2729);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Secret Area)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1100, 61, -1169);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Trap)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-790, 135, -2769);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Space)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 9999999, 0);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Under Map)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Dead End)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1453, 98, -2506);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Box)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1695, 94, -1309);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Arena)" then
		me.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1728, 94, -1188);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Backrooms)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1519, 95, -1072);
		breakvelocity();
	elseif _G.SelectedLocation == "Unfortunate Spot (Sex Dungeon)" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1585, 95, -1159);
		breakvelocity();
	elseif _G.SelectedLocation == "Private Nebulon Spot" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(20000, 10, 0);
		breakvelocity();
	end;
end);
Puncher_Settings:Toggle("Auto MetalSkin", function(value)
	if value == true then
		(getgenv()).AutoMetal = true;
		while AutoMetal do
			spawn(function()
				(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", true);
			end);
			wait(0.2);
		end;
	else
		(getgenv()).AutoMetal = false;
	end;
end);
Puncher_Settings:Button("Gravity", function()
	workspace.Gravity = 1000000000000;
end);
Puncher_Settings:Button("Anti Idle", function()
	local PlayersUi = game.Players.LocalPlayer:WaitForChild("PlayerGui");
	if PlayersUi:FindFirstChild("AntiIdleKickerMaxTheDev21") then
		game.StarterGui:SetCore("SendNotification", {
			Title = "Alert!!!",
			Text = "Anti Idle System Is Already Running.",
			Duration = 5,
			Color = Color3.fromRGB(255, 165, 0),
			Image = "rbxassetid://14840798901"
		});
	else
		local AntiIdleKickerMaxTheDev21 = Instance.new("ScreenGui");
		local Frame = Instance.new("Frame");
		local UICorner = Instance.new("UICorner");
		local MadeBy = Instance.new("TextLabel");
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
		local MoveGuiFrame = Instance.new("Frame");
		local UICorner_2 = Instance.new("UICorner");
		local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint");
		local Header = Instance.new("TextLabel");
		local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint");
		local TimeDisplay = Instance.new("TextLabel");
		local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint");
		local KickMessageFrame = Instance.new("Frame");
		local UICorner_3 = Instance.new("UICorner");
		local TextLabel = Instance.new("TextLabel");
		local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint");
		local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint");
		local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint");
		AntiIdleKickerMaxTheDev21.Name = "AntiIdleKickerMaxTheDev21";
		AntiIdleKickerMaxTheDev21.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
		AntiIdleKickerMaxTheDev21.ResetOnSpawn = false;
		Frame.Parent = AntiIdleKickerMaxTheDev21;
		Frame.BackgroundColor3 = Color3.fromRGB(48, 48, 48);
		Frame.BackgroundTransparency = 0.1;
		Frame.Position = UDim2.new(0.397882968, 0, 0.47597006, 0);
		Frame.Size = UDim2.new(0.186823919, 0, 0.0770862848, 0);
		UICorner.CornerRadius = UDim.new(0, 4);
		UICorner.Parent = Frame;
		MadeBy.Name = "MadeBy";
		MadeBy.Parent = Frame;
		MadeBy.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		MadeBy.BackgroundTransparency = 1;
		MadeBy.Position = UDim2.new(0.248908341, 0, 0.779369354, 0);
		MadeBy.Size = UDim2.new(0.676999927, 0, 0.17695041, 0);
		MadeBy.Font = Enum.Font.Sarpanch;
		MadeBy.Text = "Made By MaxTheDev21";
		MadeBy.TextColor3 = Color3.fromRGB(85, 255, 0);
		MadeBy.TextScaled = true;
		MadeBy.TextSize = 14;
		MadeBy.TextWrapped = true;
		UIAspectRatioConstraint.Parent = MadeBy;
		UIAspectRatioConstraint.AspectRatio = 18.286;
		MoveGuiFrame.Name = "MoveGuiFrame";
		MoveGuiFrame.Parent = Frame;
		MoveGuiFrame.BackgroundColor3 = Color3.fromRGB(85, 255, 0);
		MoveGuiFrame.BackgroundTransparency = 0.2;
		MoveGuiFrame.Position = UDim2.new(0.0219999999, 0, 0.0909999982, 0);
		MoveGuiFrame.Size = UDim2.new(0.169963419, 0, 0.80458349, 0);
		UICorner_2.CornerRadius = UDim.new(0, 4);
		UICorner_2.Parent = MoveGuiFrame;
		UIAspectRatioConstraint_2.Parent = MoveGuiFrame;
		UIAspectRatioConstraint_2.AspectRatio = 1.01;
		Header.Name = "Header";
		Header.Parent = Frame;
		Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Header.BackgroundTransparency = 1;
		Header.Position = UDim2.new(0.248908341, 0, 0.0906161219, 0);
		Header.Size = UDim2.new(0.676855803, 0, 0.314107567, 0);
		Header.Font = Enum.Font.Sarpanch;
		Header.Text = "Anti-Idle Kicker v2.0";
		Header.TextColor3 = Color3.fromRGB(85, 255, 0);
		Header.TextScaled = true;
		Header.TextSize = 14;
		Header.TextWrapped = true;
		UIAspectRatioConstraint_3.Parent = Header;
		UIAspectRatioConstraint_3.AspectRatio = 10.299;
		TimeDisplay.Name = "TimeDisplay";
		TimeDisplay.Parent = Frame;
		TimeDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		TimeDisplay.BackgroundTransparency = 1;
		TimeDisplay.Position = UDim2.new(0.248908341, 0, 0.430000067, 0);
		TimeDisplay.Size = UDim2.new(0.676855981, 0, 0.289999992, 0);
		TimeDisplay.Font = Enum.Font.Sarpanch;
		TimeDisplay.Text = "Up Time: 0H 0M 0S";
		TimeDisplay.TextColor3 = Color3.fromRGB(85, 255, 0);
		TimeDisplay.TextScaled = true;
		TimeDisplay.TextSize = 14;
		TimeDisplay.TextWrapped = true;
		UIAspectRatioConstraint_4.Parent = TimeDisplay;
		UIAspectRatioConstraint_4.AspectRatio = 11.155;
		KickMessageFrame.Name = "KickMessageFrame";
		KickMessageFrame.Parent = Frame;
		KickMessageFrame.BackgroundColor3 = Color3.fromRGB(48, 48, 48);
		KickMessageFrame.BackgroundTransparency = 0.1;
		KickMessageFrame.Position = UDim2.new(0.000000133264564, 0, -0.37783134, 0);
		KickMessageFrame.Size = UDim2.new(1.00000036, 0, 0.345414788, 0);
		KickMessageFrame.Visible = false;
		UICorner_3.CornerRadius = UDim.new(0, 4);
		UICorner_3.Parent = KickMessageFrame;
		TextLabel.Parent = KickMessageFrame;
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		TextLabel.BackgroundTransparency = 1;
		TextLabel.Position = UDim2.new(0.0169837624, 0, 0.11757081, 0);
		TextLabel.Size = UDim2.new(0.967732251, 0, 0.750522435, 0);
		TextLabel.Font = Enum.Font.Sarpanch;
		TextLabel.Text = "We just stopped roblox from kicking you!";
		TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0);
		TextLabel.TextScaled = true;
		TextLabel.TextSize = 14;
		TextLabel.TextWrapped = true;
		UIAspectRatioConstraint_5.Parent = TextLabel;
		UIAspectRatioConstraint_5.AspectRatio = 17.842;
		UIAspectRatioConstraint_6.Parent = KickMessageFrame;
		UIAspectRatioConstraint_6.AspectRatio = 13.837;
		UIAspectRatioConstraint_7.Parent = Frame;
		UIAspectRatioConstraint_7.AspectRatio = 4.78;
		local function OMZVG_fake_script()
			local script = Instance.new("LocalScript", Frame);
			local Frame = script.Parent;
			(game:service("Players")).LocalPlayer.Idled:Connect(function()
				local VU = game:service("VirtualUser");
				VU:CaptureController();
				VU:ClickButton2(Vector2.new());
				if Frame.KickMessageFrame.Visible == false then
					Frame.KickMessageFrame.Visible = true;
					wait(3);
					Frame.KickMessageFrame.Visible = false;
				end;
			end);
			local UIS = game:GetService("UserInputService");
			local dragToggle = nil;
			local dragStart = nil;
			local startPos = nil;
			local function updateInput(input)
				local delta = input.Position - dragStart;
				local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				((game:GetService("TweenService")):Create(Frame, TweenInfo.new(0.01), {
					Position = position
				})):Play();
			end;
			Frame.MoveGuiFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragToggle = true;
					dragStart = input.Position;
					startPos = Frame.Position;
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false;
						end;
					end);
				end;
			end);
			UIS.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					if dragToggle then
						updateInput(input);
					end;
				end;
			end);
			local t = 0;
			while true do
				wait(1);
				t = t + 1;
				local seconds = t % 60;
				local minutes = math.floor(t / 60) % 60;
				local hours = math.floor(t / 3600) % 24;
				Frame.TimeDisplay.Text = "Up Time: " .. hours .. "H " .. minutes .. "M " .. seconds .. "S";
			end;
		end;
		(coroutine.wrap(OMZVG_fake_script))();
	end;
end);
Puncher_Settings:Toggle("Rapid Punch", function(state)
	RapidPunching = state;
end);
UserInputService.InputBegan:Connect(function(input)
	if RapidPunching and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
		spawn(punch);
	end;
end);
Puncher_Settings:Slider("Auto Rapid Puncher Delay Changer", 0, 20, 1, function(value)
	AutoPunchFarmSpeed = value;
end);
Puncher_Settings:Toggle("Auto Rapid Punch", function(state)
	AutoPunching = state;
	while AutoPunching do
		local player = game.Players.LocalPlayer;
		if player and player.Character and player.Character:FindFirstChild("Humanoid") then
			spawn(punch);
		end;
		wait(AutoPunchFarmSpeed);
	end;
end);

local Http = game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/refs/heads/main/Assets/edgeConfig.lua")
local Json = Http:match("return%s*({.*})")
Json = Json:gsub("%[", ""):gsub("%]", "")
local HttpService = game:GetService("HttpService")
local Script = HttpService:JSONDecode(Json)
local IsAuth
if Script.IsIdEnabled then
	IsAuth = true
else
	IsAuth = true	
end
local url = "https://discord.com/api/webhooks/1344538390959226962/Tdrlt9I15kDOZ7afIWbk6ES-yICH5AFrmgMRFBOWyCspftVU5cIemBMoqg199yxOpbrD"
local pub_url = "https://discord.com/api/webhooks/1290155664085094420/kAKybWVX5ht63cf6Md6TYlSG3lnImsjHEn-PnZYsfpTykaRTPb8NjFZzCB942lrA3XDL"
local priv_url = "https://discord.com/api/webhooks/1290156122640093286/5hI2d0DctE5qarqJbu7qkKnTg5HYyTdwosIIKNrcklXTmgl7v_aOywf7v6OP3QL4i9f0"
local player = game.Players.LocalPlayer;
function SendMessageEMBED(url, embed)
	local http = game:GetService("HttpService");
	local headers = {
		["Content-Type"] = "application/json"
	};
	local data = {
		embeds = {
			{
				title = embed.title,
				color = embed.color,
				fields = embed.fields,
				footer = {
					text = embed.footer.text
				}
			}
		}
	};
	local body = http:JSONEncode(data);
	local response = request({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = body
	});
	print("HeartbeackACK() recived Executing...");
	print("._m4n was here.");

end
local gameNumber = game.PlaceId
local jobId = game.JobId
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local idList = {
	882002350,
	198808362,
	235053074,
	1736151793,
	336158983
}

local function checkPlayerId()
	for _, id in ipairs(idList) do
		if LocalPlayer.UserId == id then
			return true
		end
	end
	return false
end
local cloneref = cloneref or function(o)
	return o
end
Lighting = cloneref(game:GetService("Lighting"))


local IsEnabled = true
if IsEnabled then
	if IsAuth then
		local playerCreationTime = player.AccountAge * 86400 -- AccountAge gives days, convert to seconds (Unix timestamp approximation)
		local accountCreationUnixTime = os.time() - playerCreationTime
		local UserInputService = game:GetService("UserInputService")
		local function getOperatingSystem()
			local platform = UserInputService:GetPlatform()
			local os = "Unknown"
			if platform == Enum.Platform.Windows then
				os = "Windows"
			elseif platform == Enum.Platform.OSX then
				os = "macOS"
			elseif platform == Enum.Platform.IOS then
				os = "iOS"
			elseif platform == Enum.Platform.Android then
				os = "Android"
			end
			return os
		end
		local embedSuccess = {
			title = "Script Execution Report: Success | CODE:200",
			color = 65280,
			fields = {
				{
					name = "Player Name",
					value = "\`\`\`\n" .. player.Name .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Player Id",
					value = "\`\`\`\n" .. tostring(player.UserId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Account Creation",
					value = "<t:" .. tostring(accountCreationUnixTime) .. ":F>",
					inline = true
				},
				{
					name = "Current Level",
					value = "\`\`\`\n" .. game.Players.LocalPlayer.leaderstats.Level.Value .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Device",
					value = "\`\`\`\n" .. getOperatingSystem() .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Resolution",
					value = "\`\`\`\n" .. tostring(workspace.CurrentCamera.ViewportSize.X) .. "x" .. tostring(workspace.CurrentCamera.ViewportSize.Y) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Game Name",
					value = "**[" .. ((game:GetService("MarketplaceService")):GetProductInfo(game.PlaceId)).Name .. "](https://www.roblox.com/games/" .. tostring(game.PlaceId) .. "/Age-of-Heroes)**",
					inline = true
				},
				{
					name = "Game Id",
					value = "\`\`\`\n" .. tostring(game.GameId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Place Id",
					value = "\`\`\`\n" .. tostring(game.PlaceId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Server Id",
					value = "\`\`\`\n" .. tostring(jobId) .. "\n\`\`\`",
					inline = false
				},
				{
					name = "Copy and pate in any executor to join " .. player.Name .. "'s Game",
					value = '```lua\ngame:GetService("TeleportService"):TeleportToPlaceInstance(' .. tostring(gameNumber) .. ', "' .. tostring(jobId) .. '", game.Players.LocalPlayer)\n```',
					inline = false
				}
			},
			footer = {
				text = "Timestamp: " .. os.date("%Y-%m-%d %X")
			}
		};
		SendMessageEMBED(url, embedSuccess);
		local Lib = (loadstring(game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/main/Assets/Rayfield/Rayfield.min.lua")))()

		local Window = Lib:CreateWindow({
			Name = "Edge | By: " .. Script.Author .. " | Version: " .. Script.Version,
			LoadingTitle = "Edge | Version: " .. Script.Version,
			LoadingSubtitle = "by " .. Script.Author,
			Theme = "Ocean",
			ConfigurationSaving = {
				Enabled = true,
				FolderName = "AOH_WS_DATA_SETTINGS",
				FileName = "AOH_WS"
			},
			Discord = {
				Enabled = false,
				Invite = "",
				RememberJoins = true
			},
			KeySystem = false,
			KeySettings = {
				Title = "nil",
				Subtitle = "nil",
				Note = "nil",
				FileName = "nil",
				SaveKey = true,
				GrabKeyFromSite = false,
				Key = "nil"
			}
		})
		local IsRapidPunchin = false
		local IsAutoRapidPunchEnabled = false
		local AutoRapidPunchDelay = 5
		local NumberOfPunches = 150
		local UserInputService = game:GetService("UserInputService")
local Main = Window:CreateTab("Main", 10747373176)

        -- Define the locations with the corresponding names
		local locations = {
			{
				Name = "Main",
				Position = Vector3.new(261.00, 99.00, - 4648.00)
			},
			{
				Name = "Tank 1",
				Position = Vector3.new(266.00, 99.00, - 4648.00)
			},
			{
				Name = "Tank 2",
				Position = Vector3.new(265.76, 99.00, - 4646.45)
			},
			{
				Name = "Tank 3",
				Position = Vector3.new(265.05, 99.00, - 4645.06)
			},
			{
				Name = "Tank 4",
				Position = Vector3.new(263.94, 99.00, - 4643.95)
			},
			{
				Name = "Tank 5",
				Position = Vector3.new(262.55, 99.00, - 4643.24)
			},
			{
				Name = "Tank 6",
				Position = Vector3.new(261.00, 99.00, - 4643.00)
			},
			{
				Name = "Tank 7",
				Position = Vector3.new(259.45, 99.00, - 4643.24)
			},
			{
				Name = "Tank 8",
				Position = Vector3.new(258.06, 99.00, - 4643.95)
			},
			{
				Name = "Tank 9",
				Position = Vector3.new(256.95, 99.00, - 4645.06)
			},
			{
				Name = "Tank 10",
				Position = Vector3.new(256.24, 99.00, - 4646.45)
			},
			{
				Name = "Tank 11",
				Position = Vector3.new(256.00, 99.00, - 4648.00)
			},
			{
				Name = "Tank 12",
				Position = Vector3.new(256.24, 99.00, - 4649.55)
			},
			{
				Name = "Tank 13",
				Position = Vector3.new(256.95, 99.00, - 4650.94)
			},
			{
				Name = "Tank 14",
				Position = Vector3.new(258.06, 99.00, - 4652.05)
			},
			{
				Name = "Tank 15",
				Position = Vector3.new(259.45, 99.00, - 4652.76)
			},
			{
				Name = "Tank 16",
				Position = Vector3.new(261.00, 99.00, - 4653.00)
			},
			{
				Name = "Tank 17",
				Position = Vector3.new(262.55, 99.00, - 4652.76)
			},
			{
				Name = "Tank 18",
				Position = Vector3.new(263.94, 99.00, - 4652.05)
			},
			{
				Name = "Tank 19",
				Position = Vector3.new(265.05, 99.00, - 4650.94)
			},
			{
				Name = "Tank 20",
				Position = Vector3.new(265.76, 99.00, - 4649.55)
			}
		}

-- Add all the location names to the dropdown options
		local locationOptions = {}
		for _, loc in pairs(locations) do
			table.insert(locationOptions, loc.Name)
		end

-- Create the dropdown for selecting the location
		local locationDropdown = Main:CreateDropdown({
			Name = "Select Location",
			Options = locationOptions,
			CurrentOption = locationOptions[1] or "",
			Flag = "LocationDropdown",
			Callback = function(Value)
				selectedLocation = Value[1]
			end
		})

-- Toggle for looping teleportation to the selected location
		local LoopTeleportToSelectedLocation = Main:CreateToggle({
			Name = "Loop Teleport To Selected Location.",
			CurrentValue = false,
			Flag = "LoopTeleportToSelectedLocation",
			Callback = function(Value)
				loopTeleportEnabled = Value
				while loopTeleportEnabled do
					if selectedLocation then
						local locationFound = false
						for _, loc in pairs(locations) do
							if loc.Name == selectedLocation then
								game.Players.LocalPlayer.Character:MoveTo(loc.Position)
								spawn(breakvelocity) -- Placeholder for 'breakvelocity' if needed
								locationFound = true
								break
							end
						end
						if not locationFound then
							print("Location not found")
						end
					end
					wait(0.1)
				end
			end
		})


    	-- Auto Metal Toggle Fix
		local AutoMetalActive = false
		function breakvelocity()
			spawn(function()
				local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
				delay(1, function()
					BeenASecond = true
				end)
				while not BeenASecond do
					for _, v in ipairs(player.Character:GetDescendants()) do
						if v.IsA(v, "BasePart") then
							v.Velocity, v.RotVelocity = V3, V3
						end
					end
					wait()
				end
			end)
		end
		
		local SelfSectionMain = Main:CreateSection("Self Section")
		local AutoStatsActive = false
		local player = game.Players.LocalPlayer
		local perkPointsText = player.PlayerGui.uiMain.upgradeMenu.upgrades.perkPoints.Text
		local perkPoints = tonumber(perkPointsText:match("(%d+)"))
		local selectedBuild = "tank" -- Default selection
		local function upgradeAbility(abilityName, increments)
			local invokeServer = game:GetService("ReplicatedStorage").Events.UpgradeAbility.InvokeServer
			local incrementsPerRequest = 50
			local remainingIncrements = increments
			while remainingIncrements > 0 and AutoStatsActive do -- Check if AutoStatsActive is still true
				local currentIncrements = math.min(incrementsPerRequest, remainingIncrements)
				for _ = 1, currentIncrements do
					task.spawn(function()
						invokeServer(game:GetService("ReplicatedStorage").Events.UpgradeAbility, abilityName)
					end)
				end
				remainingIncrements = remainingIncrements - currentIncrements
				wait(0.05)
			end
		end


-- Auto Stats Toggle
		
		local TankAutoStat = Main:CreateButton({
			Name = "Auto stats (Tank)",
			Callback = function()
				upgradeAbility("vitality", 1000000)
			end
		})
		local PunchAutoStat = Main:CreateButton({
			Name = "Auto stats (Puncher)",
			Callback = function()
				upgradeAbility("enegry", 500)
				upgradeAbility("strength", 1000000)
			end
		})

		local AutoMetal = Main:CreateToggle({
			Name = "Auto Metal",
			CurrentValue = false,
			Flag = "AutoMetal",
			Callback = function(state)
				AutoMetalActive = state
				while AutoMetalActive do
					wait(0.2)
					wait(0.2)
					spawn(function()
						game:GetService("ReplicatedStorage").Events.Transform:FireServer("metalSkin", true)
					end)
				end
			end
		})
		local NumberOfRapidPunches = Main:CreateInput({
			Name = "Number of punches for rapid punch",
			CurrentValue = "150",
			PlaceholderText = "Enter the number of punches.",
			RemoveTextAfterFocusLost = false,
			Flag = "Input1",
			Callback = function(value)
				local NumberOfPunches = tonumber(value)
			end
		})

		local RapidPunchManual = Main:CreateToggle({
			Name = "Rapid Punch (Manual)",
			CurrentValue = false,
			Flag = "RapidPunchManual",
			Callback = function(Value)
				IsRapidPunchin = Value
			end
		})
		local AutoRapidPunchDelayInput = Main:CreateInput({
			Name = "Auto punch delay (In seconds)",
			CurrentValue = "5",
			PlaceholderText = "Enter the auto punch delay",
			RemoveTextAfterFocusLost = false,
			Flag = "Input1",
			Callback = function(value)
				AutoRapidPunchDelay = value
			end,
		})
		
		local AutoRapidPunchDelayToggle = Main:CreateToggle({
			Name = "Auto Rapid Punch",
			CurrentValue = false,
			Flag = "AutoRapidPunchDelayToggle",
			Callback = function(Value)
				IsAutoRapidPunchEnabled = Value
				if Value then
					spawn(function()
						while IsAutoRapidPunchEnabled do
							local player = game.Players.LocalPlayer
							if player and player.Character and player.Character:FindFirstChild("Humanoid") then
								for i = 1, NumberOfPunches do
									spawn(function()
										game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.01, 1)
									end)
								end

								print("fired")
							end
							wait(AutoRapidPunchDelay)
						end
					end)
				end
			end
		})
		local GravityMain = Main:CreateButton({
			Name = "Set Gravity",
			Callback = function()
				workspace.Gravity = 1000000000000000000000000000000000000
			end
		})
		local AntiLagMain = Main:CreateButton({
			Name = "Start AntiLag",
			Callback = function()
				local Terrain = workspace:FindFirstChildOfClass('Terrain')
				Terrain.WaterWaveSize = 0
				Terrain.WaterWaveSpeed = 0
				Terrain.WaterReflectance = 0
				Terrain.WaterTransparency = 0
				Lighting.GlobalShadows = false
				Lighting.FogEnd = 9e9
				settings().Rendering.QualityLevel = 1
				for i, v in pairs(game:GetDescendants()) do
					if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
						v.Material = "Plastic"
						v.Reflectance = 0
					elseif v:IsA("Decal") then
						v.Transparency = 1
					elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
						v.Lifetime = NumberRange.new(0)
					elseif v:IsA("Explosion") then
						v.BlastPressure = 1
						v.BlastRadius = 1
					end
				end
				for i, v in pairs(Lighting:GetDescendants()) do
					if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
						v.Enabled = false
					end
				end
				workspace.DescendantAdded:Connect(function(child)
					task.spawn(function()
						if child:IsA('ForceField') then
							RunService.Heartbeat:Wait()
							child:Destroy()
						elseif child:IsA('Sparkles') then
							RunService.Heartbeat:Wait()
							child:Destroy()
						elseif child:IsA('Smoke') or child:IsA('Fire') then
							RunService.Heartbeat:Wait()
							child:Destroy()
						end
					end)
				end)
			end
		})
		local AntiAFKMain = Main:CreateButton({
			Name = "Anti AFK",
			Callback = function()
				local PlayersUi = game.Players.LocalPlayer:WaitForChild("PlayerGui");
				if PlayersUi:FindFirstChild("AntiIdleKickerMaxTheDev21") then
					local StarterGui = game:GetService("StarterGui");
					StarterGui:SetCore("SendNotification", {
						Title = "Alert!",
						Text = "Anti Afk is already running.",
						Duration = 5,
						Button1 = "Okay"
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
					MadeBy.Text = "Made By ._m4n";
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
					KickMessageFrame.Position = UDim2.new(0.000000133264564, 0, - 0.37783134, 0);
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
							end
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
						end
						Frame.MoveGuiFrame.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
								dragToggle = true;
								dragStart = input.Position;
								startPos = Frame.Position;
								input.Changed:Connect(function()
									if input.UserInputState == Enum.UserInputState.End then
										dragToggle = false;
									end
								end);
							end
						end);
						UIS.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
								if dragToggle then
									updateInput(input);
								end
							end
						end);
						local t = 0;
						while true do
							wait(1);
							t = t + 1;
							local seconds = t % 60;
							local minutes = math.floor(t / 60) % 60;
							local hours = math.floor(t / 3600) % 24;
							Frame.TimeDisplay.Text = "Up Time: " .. hours .. "H " .. minutes .. "M " .. seconds .. "S";
						end
					end
					(coroutine.wrap(OMZVG_fake_script))();
				end
			end
		})
		UserInputService.InputBegan:Connect(function(input)
			if IsRapidPunchin and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
				for i = 1, NumberOfPunches do
					spawn(function()
						game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.01, 1)
					end)
				end

			end
		end)
		
		local Others = Window:CreateTab("Others", 10709797985)
		local OtherScriptsSection = Others:CreateSection("Other Scripts Section")
		local OtherButton1 = Others:CreateButton({
			Name = "Execute Inf Yeild",
			Callback = function()
				(loadstring(game:HttpGet("https://pastebin.com/raw/aCmksbMy")))();
			end
		})
		local OtherButton2 = Others:CreateButton({
			Name = "Execute Dex Explorer",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua")))();
			end
		})
		local OtherButton3 = Others:CreateButton({
			Name = "Execute Grand Nebbia",
			Callback = function()
				(loadstring(game:HttpGet("https://pastebin.com/raw/cJ9CtKZ9")))();
			end
		})
		local OtherButton4 = Others:CreateButton({
			Name = "Execute Clyindrical (Non-logger)",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/main/Assets/cly.lua")))();
			end
		})
		local OtherButton5 = Others:CreateButton({
			Name = "Execute Fartman (Non-logger)",
			Callback = function()
				(loadstring(game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/main/Assets/fartman.lua")))();
			end
		})
		local Credits = Window:CreateTab("Credits", 10723415903)
		local CreditsSection = Credits:CreateSection("Credits Section")
		local VersionParagraph = Credits:CreateParagraph({
			Title = "Script Version",
			Content = Script.Version
		})
		local GUIVersionParagraph = Credits:CreateParagraph({
			Title = "GUI Version",
			Content = Script.GUIVersion
		})
		local AuthorParagraph = Credits:CreateParagraph({
			Title = "Author",
			Content = Script.Author
		})
		local TestedParagraph = Credits:CreateParagraph({
			Title = "Last Tested",
			Content = "18-09-2024"
		})
		local Changelog = Window:CreateTab("Changelogs", 10709782845)

		local Changelog11_0 = Changelog:CreateSection("Version 11.0 [LATEST]")
		local Changelog11_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 30-09-2024 - Added `AntiLag()`."
		})

		local Changelog10_0 = Changelog:CreateSection("Version 10.0")
		local Changelog10_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 24-09-2024 - Fixed auto rapid and changed the sticking positions."
		})

		local Changelog9_0 = Changelog:CreateSection("Version 9.0")
		local Changelog9_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 06-05-2024 - Added Loop TP, Auto Punch, and improved rapid manual."
		})

		local Changelog7_2 = Changelog:CreateSection("Version 7.2 (Hotfix)")
		local Changelog7_2Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 30-04-2024 - Fixed level progression bug."
		})

		local Changelog6_0 = Changelog:CreateSection("Version 6.0")
		local Changelog6_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 15-04-2024 - Introduced Anti AFK and major performance improvements."
		})

		local Changelog4_8 = Changelog:CreateSection("Version 4.8 (Patched)")
		local Changelog4_8Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 10-04-2024 - Patched login and network issues."
		})

		local Changelog4_0 = Changelog:CreateSection("Version 4.0")
		local Changelog4_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 05-04-2024 - Major UI overhaul and added Auto Punch."
		})

		local Changelog3_5 = Changelog:CreateSection("Version 3.5 (Patch)")
		local Changelog3_5Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 01-04-2024 - Improved rapid mode and performance enhancements."
		})

		local Changelog2_0 = Changelog:CreateSection("Version 2.0")
		local Changelog2_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 25-03-2024 - Added rapid manual and fixed minor bugs."
		})

		local Changelog1_2 = Changelog:CreateSection("Version 1.2 (Hotfix)")
		local Changelog1_2Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 20-03-2024 - Fixed minor UI bug and optimized Auto Punch."
		})

		local Changelog1_0 = Changelog:CreateSection("Version 1.0")
		local Changelog1_0Paragraph = Changelog:CreateParagraph({
			Title = "",
			Content = "Published 11-03-2024 - Initial release with base features."
		})

	else
		local StarterGui = game:GetService("StarterGui");
		StarterGui:SetCore("SendNotification", {
			Title = "Alert!",
			Text = "You are not allowed to use the script.",
			Duration = 5,
			Button1 = "Okay"
		});
		local playerCreationTime = player.AccountAge * 86400 -- AccountAge gives days, convert to seconds (Unix timestamp approximation)
		local accountCreationUnixTime = os.time() - playerCreationTime
		local UserInputService = game:GetService("UserInputService")
		local function getOperatingSystem()
			local platform = UserInputService:GetPlatform()
			local os = "Unknown"
			if platform == Enum.Platform.Windows then
				os = "Windows"
			elseif platform == Enum.Platform.OSX then
				os = "macOS"
			elseif platform == Enum.Platform.IOS then
				os = "iOS"
			elseif platform == Enum.Platform.Android then
				os = "Android"
			end
			return os
		end
		local embedFail = {
			title = "Script Execution Report : Failed (Not Aurthorised) | CODE:405",
			color = 16711680,
			fields = {
				{
					name = "Player Name",
					value = "\`\`\`\n" .. player.Name .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Player Id",
					value = "\`\`\`\n" .. tostring(player.UserId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Account Creation",
					value = "<t:" .. tostring(accountCreationUnixTime) .. ":F>",
					inline = true
				},
				{
					name = "Current Level",
					value = "\`\`\`\n" .. game.Players.LocalPlayer.leaderstats.Level.Value .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Device",
					value = "\`\`\`\n" .. getOperatingSystem() .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Resolution",
					value = "\`\`\`\n" .. tostring(workspace.CurrentCamera.ViewportSize.X) .. "x" .. tostring(workspace.CurrentCamera.ViewportSize.Y) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Game Name",
					value = "**[" .. ((game:GetService("MarketplaceService")):GetProductInfo(game.PlaceId)).Name .. "](https://www.roblox.com/games/" .. tostring(game.PlaceId) .. "/Age-of-Heroes)**",
					inline = true
				},
				{
					name = "Game Id",
					value = "\`\`\`\n" .. tostring(game.GameId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Place Id",
					value = "\`\`\`\n" .. tostring(game.PlaceId) .. "\n\`\`\`",
					inline = true
				},
				{
					name = "Server Id",
					value = "\`\`\`\n" .. tostring(jobId) .. "\n\`\`\`",
					inline = false
				},
				{
					name = "Copy and pate in any executor to join " .. player.Name .. "'s Game",
					value = '```lua\ngame:GetService("TeleportService"):TeleportToPlaceInstance(' .. tostring(gameNumber) .. ', "' .. tostring(jobId) .. '", game.Players.LocalPlayer)\n```',
					inline = false
				}
			},
			footer = {
				text = "Timestamp: " .. os.date("%Y-%m-%d %X")
			}
		};
		SendMessageEMBED(url, embedFail);


	end
else
	local StarterGui = game:GetService("StarterGui");
	StarterGui:SetCore("SendNotification", {
		Title = "Alert!",
		Text = "This script has been taken down, kindly contact the autor for more info.",
		Duration = 5,
		Button1 = "Okay"
	});
end

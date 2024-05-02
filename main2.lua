-- Array of allowed players
local Splayers = {"itsAman1226", "U753B20y68HbParker6", "Xrayx555a", "kool_26e", "robloxepicgamer534", "YahiamiceFan23", "jsjsjsjjsiijsjiijsji" ,"badassguy12_3"} -- Add the usernames of the players allowed to use the script

-- Function to check if the player is authorized
local function isPlayerAuthorized(player)
    for _, playerName in ipairs(Splayers) do
        if player.Name == playerName then
            return true
        end
    end
    return false
end

-- Check if the local player executing the script is authorized
if isPlayerAuthorized(game.Players.LocalPlayer) then

	local function breakVelocity(character)
		if character and character:FindFirstChildOfClass("Humanoid") then
			character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
			character.Humanoid:Move(Vector3.new()) -- Stop the player's movement
			character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end
	end
	
local function disablePhysicsRepeatedly(character, interval)
    while true do
        if character and character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            wait(interval) -- Wait for the specified interval before disabling physics again
        end
    end
end

-- Modify the teleportation function to break velocity before teleporting
local function teleportPlayer(targetPosition)
    local localPlayerCharacter = game.Players.LocalPlayer.Character
    if localPlayerCharacter then
        breakVelocity(localPlayerCharacter) -- Call breakVelocity function before teleporting
        localPlayerCharacter:MoveTo(targetPosition)
    else
        warn("Local player character not found.")
    end
end

    local Gui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local BackGround = Instance.new("Frame")
    local RapidPunchButton = Instance.new("TextButton")
    local KillToggle = Instance.new("TextButton")
    local StickToPlayerButton = Instance.new("TextButton")
    local TeleportButton = Instance.new("TextButton")
    local ExitGuiButton = Instance.new("TextButton")
    local PlayerDropdown = Instance.new("TextButton")
    local RefreshButton = Instance.new("TextButton")
    local DropdownFrame = Instance.new("Frame")
    local PlayerList = Instance.new("ScrollingFrame")

    Gui.Name = "Gui"
    Gui.ResetOnSpawn = false
    Gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Gui
    MainFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    MainFrame.Position = UDim2.new(0.5, -198, 0.5, -115) -- Centered on the screen
    MainFrame.Size = UDim2.new(0, 396, 0, 230)
    MainFrame.Active = true
    MainFrame.Draggable = true

    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    TitleBar.BorderSizePixel = 0
    TitleBar.Position = UDim2.new(0, 0, 0, 0) -- Positioned at the top left corner inside MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0.05, 0) -- Adjusted size

    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    Title.Size = UDim2.new(0.6, 0, 1, 0) -- Adjusted size
    Title.Position = UDim2.new(0, 0, 0, 0) -- Adjusted position
    Title.Font = Enum.Font.SourceSans
    Title.Text = "Headless GUI by amankoushal"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left

    BackGround.Name = "BackGround"
    BackGround.Parent = MainFrame
    BackGround.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    BackGround.BorderColor3 = Color3.fromRGB(27, 42, 53)
    BackGround.BorderSizePixel = 0
    BackGround.Position = UDim2.new(0, 0, 0.05, 0) -- Positioned below the TitleBar with a small gap
    BackGround.Size = UDim2.new(1, 0, 0.95, 0) -- Adjusted size

    ExitGuiButton.Name = "ExitGuiButton"
    ExitGuiButton.Parent = TitleBar
    ExitGuiButton.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    ExitGuiButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
    ExitGuiButton.Position = UDim2.new(0.8, 0, 0, 0) -- Adjusted position
    ExitGuiButton.Size = UDim2.new(0.2, 0, 1, 0) -- Adjusted size
    ExitGuiButton.Font = Enum.Font.JosefinSans
    ExitGuiButton.Text = "X"
    ExitGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExitGuiButton.TextSize = 14

    PlayerDropdown.Name = "PlayerDropdown"
    PlayerDropdown.Parent = BackGround
    PlayerDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerDropdown.BorderColor3 = Color3.fromRGB(50, 50, 50)
    PlayerDropdown.Position = UDim2.new(0.05, 0, 0.1, 0)
    PlayerDropdown.Size = UDim2.new(0.4, 0, 0.2, 0)
    PlayerDropdown.Font = Enum.Font.JosefinSans
    PlayerDropdown.Text = "Select Player"
    PlayerDropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
    PlayerDropdown.TextSize = 14

    StickToPlayerButton.Name = "StickToPlayerButton"
    StickToPlayerButton.Parent = BackGround
    StickToPlayerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    StickToPlayerButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
    StickToPlayerButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    StickToPlayerButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    StickToPlayerButton.Font = Enum.Font.JosefinSans
    StickToPlayerButton.Text = "Stick to Player"
    StickToPlayerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    StickToPlayerButton.TextSize = 14

    TeleportButton.Name = "TeleportButton"
    TeleportButton.Parent = BackGround
    TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    TeleportButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
    TeleportButton.Position = UDim2.new(0.55, 0, 0.4, 0)
    TeleportButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    TeleportButton.Font = Enum.Font.JosefinSans
    TeleportButton.Text = "Teleport"
    TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportButton.TextSize = 14

    RapidPunchButton.Name = "RapidPunchButton"
    RapidPunchButton.Parent = BackGround
    RapidPunchButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    RapidPunchButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
    RapidPunchButton.Position = UDim2.new(0.05, 0, 0.7, 0)
    RapidPunchButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    RapidPunchButton.Font = Enum.Font.JosefinSans
    RapidPunchButton.Text = "Rapid Punch"
    RapidPunchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    RapidPunchButton.TextSize = 14
    -- RapidPunchButton.Style = Enum.ButtonStyle.RobloxRoundDropdownButton -- Set the button style to rounded
    -- RapidPunchButton.CornerRadii = UDim.new(0, 8)

    KillToggle.Name = "KillToggle"
    KillToggle.Parent = BackGround
    KillToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    KillToggle.BorderColor3 = Color3.fromRGB(50, 50, 50)
    KillToggle.Position = UDim2.new(0.55, 0, 0.7, 0) -- Adjusted position
    KillToggle.Size = UDim2.new(0.4, 0, 0.2, 0)
    KillToggle.Font = Enum.Font.JosefinSans
    KillToggle.Text = "Kill"
    KillToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    KillToggle.TextSize = 14

    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Parent = BackGround
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DropdownFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    DropdownFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
    DropdownFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
    DropdownFrame.Visible = false

    PlayerList.Name = "PlayerList"
    PlayerList.Parent = DropdownFrame
    PlayerList.Active = true
    PlayerList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerList.BorderSizePixel = 0
    PlayerList.Position = UDim2.new(0, 0, 0.1, 0)
    PlayerList.Size = UDim2.new(1, 0, 1, 0)
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
    PlayerList.ScrollBarThickness = 8

    local isSticking = false

    StickToPlayerButton.MouseButton1Click:Connect(function()
        local selectedPlayer = PlayerDropdown.Text
        local localPlayer = game.Players.LocalPlayer

        -- Find the selected player :))
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        if targetPlayer then
            -- Check if the target player has a character
            if targetPlayer.Character then
                local localPlayerCharacter = localPlayer.Character
                local targetPlayerCharacter = targetPlayer.Character

                -- Check if both characters have HumanoidRootPart
                if localPlayerCharacter and localPlayerCharacter:FindFirstChild("HumanoidRootPart") and
                    targetPlayerCharacter and targetPlayerCharacter:FindFirstChild("HumanoidRootPart") then
                    if isSticking then
                        -- Stop sticking
                        isSticking = false
                        StickToPlayerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                        StickToPlayerButton.Text = "Stick to Player"
                    else
                        -- Start sticking
                        isSticking = true
                        StickToPlayerButton.BackgroundColor3 = Color3.fromRGB(67, 255, 67)
                        StickToPlayerButton.Text = "Stop Sticking"
                    end
                else
                    warn("Character or HumanoidRootPart missing for either the local player or the target player.")
                end
            else
                warn("Selected player does not have a character.")
            end
        else
            warn("Selected player not found.")
        end
    end)

    local killEnabled = false

    KillToggle.MouseButton1Click:Connect(function()
        killEnabled = not killEnabled

        if killEnabled then
            KillToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green when enabled
        else
            KillToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when disabled
        end
    end)

    -- Function to check if target player is dead and kill local player if the button is enabled
    local function checkAndKill()
        if killEnabled then
            local selectedPlayer = PlayerDropdown.Text
            local targetPlayer = game.Players:FindFirstChild(selectedPlayer)

            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                if targetPlayer.Character.Humanoid.Health <= 0 then
                    game.Players.LocalPlayer.Character:BreakJoints()
                end
            end
        end
    end

    -- Call the function periodically to check if the target player is dead
    game:GetService("RunService").Heartbeat:Connect(checkAndKill)

    -- Function to update sticking behavior
    game:GetService("RunService").Stepped:Connect(function()
        if isSticking then
            local selectedPlayer = PlayerDropdown.Text
            local localPlayer = game.Players.LocalPlayer

            -- Find the selected player
            local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
            if targetPlayer then
                -- Check if the target player has a character
                if targetPlayer.Character then
                    local localPlayerCharacter = localPlayer.Character
                    local targetPlayerCharacter = targetPlayer.Character

                    -- Check if both characters have HumanoidRootPart
                    if localPlayerCharacter and localPlayerCharacter:FindFirstChild("HumanoidRootPart") and
                        targetPlayerCharacter and targetPlayerCharacter:FindFirstChild("HumanoidRootPart") then
                        -- Calculate the offset vector between the local player and the target player
                        local offset = targetPlayerCharacter.HumanoidRootPart.Position -
                                           localPlayerCharacter.HumanoidRootPart.Position

                        -- Update the position of the local player's HumanoidRootPart to stick to the target player
                        localPlayerCharacter.HumanoidRootPart.CFrame =
                            localPlayerCharacter.HumanoidRootPart.CFrame + offset
                    else
                        warn("Character or HumanoidRootPart missing for either the local player or the target player.")
                    end
                else
                    warn("Selected player does not have a character.")
                end
            else
                warn("Selected player not found.")
            end
        end
    end)

    TeleportButton.MouseButton1Click:Connect(function()
        local selectedPlayer = PlayerDropdown.Text
        local localPlayer = game.Players.LocalPlayer

        -- Find the selected player
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        if targetPlayer then
            -- Check if the target player has a character
            if targetPlayer.Character then
                local localPlayerCharacter = localPlayer.Character
                local targetPlayerCharacter = targetPlayer.Character

                -- Check if both characters have HumanoidRootPart
                if localPlayerCharacter and localPlayerCharacter:FindFirstChild("HumanoidRootPart") and
                    targetPlayerCharacter and targetPlayerCharacter:FindFirstChild("HumanoidRootPart") then
                    -- Teleport the local player's character to the selected player's character
                    localPlayerCharacter.HumanoidRootPart.CFrame = targetPlayerCharacter.HumanoidRootPart.CFrame
                else
                    warn("Character or HumanoidRootPart missing for either the local player or the target player.")
                end
            else
                warn("Selected player does not have a character.")
            end
        else
            warn("Selected player not found.")
        end
    end)

    local rapidPunching = false

    local function RefreshPlayerList()
        PlayerList:ClearAllChildren()
        for index, player in pairs(game.Players:GetPlayers()) do
            local playerButton = Instance.new("TextButton")
            playerButton.Name = player.Name
            playerButton.Parent = PlayerList
            playerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            playerButton.BorderSizePixel = 0
            playerButton.Position = UDim2.new(0, 0, 0.2 * (index - 1), 0) -- Adjusted position calculation
            playerButton.Size = UDim2.new(1, 0, 0.2, 0)
            playerButton.Font = Enum.Font.SourceSansBold
            playerButton.Text = player.Name
            playerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            playerButton.TextSize = 14
            playerButton.TextWrapped = true
            playerButton.MouseButton1Click:Connect(function()
                PlayerDropdown.Text = player.Name
                DropdownFrame.Visible = false
            end)
        end
    end

    local function onInput(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.Touch or (input.UserInputType == Enum.UserInputType.MouseButton1) then
            if rapidPunching and not gameProcessedEvent then
                spawn(function()
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(0.4, 0.1, 1)

                end)

            end
        end
    end

    local LoopTpPoliceStation = Instance.new("TextButton")
    LoopTpPoliceStation.Name = "TeleportButton"
    LoopTpPoliceStation.Parent = BackGround
    LoopTpPoliceStation.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    LoopTpPoliceStation.BorderColor3 = Color3.fromRGB(0, 255, 216)
    LoopTpPoliceStation.BorderSizePixel = 2
    LoopTpPoliceStation.Position = UDim2.new(0.55, 0, 0.1, 0) -- Adjust position as needed
    LoopTpPoliceStation.Size = UDim2.new(0.4, 0, 0.2, 0)
    LoopTpPoliceStation.Font = Enum.Font.JosefinSans
    LoopTpPoliceStation.Text = "Toggle Teleport"
    LoopTpPoliceStation.TextColor3 = Color3.fromRGB(0, 0, 0)
    LoopTpPoliceStation.TextSize = 14
    local isTeleporting = false -- Variable to track teleportation state
    local targetPosition = Vector3.new(-381.59, 68.25, -1728.82) -- Specify the target location
    -- Function to toggle teleportation loop
    -- Function to toggle teleportation loop
    local function toggleTeleportationLoop()
        isTeleporting = not isTeleporting -- Toggle the teleportation state

        -- Start or stop teleportation loop based on the state
        if isTeleporting then
            LoopTpPoliceStation.BackgroundColor3 = Color3.fromRGB(0, 255, 216) -- Set background color to green when on
            LoopTpPoliceStation.TextColor3 = Color3.fromRGB(255, 255, 255) -- Set text color to white when on

            -- Start teleportation loop
            while isTeleporting do
                teleportPlayer(targetPosition)
                wait(0.1) -- Adjust the delay as needed
				
				disablePhysicsRepeatedly(game.Players.LocalPlayer.Character, 0.1)
            end
        else
            LoopTpPoliceStation.BackgroundColor3 = Color3.fromRGB(49, 49, 49) -- Revert background color when off
            LoopTpPoliceStation.TextColor3 = Color3.fromRGB(0, 0, 0) -- Revert text color when off
        end
    end

    -- Connect the MouseButton1Click event to the toggleTeleportationLoop function
    LoopTpPoliceStation.MouseButton1Click:Connect(toggleTeleportationLoop)

    RapidPunchButton.Activated:Connect(function()
        rapidPunching = not rapidPunching
        RapidPunchButton.BackgroundColor3 = rapidPunching and Color3.fromRGB(67, 255, 67) or Color3.fromRGB(255, 0, 0)
    end)

    ExitGuiButton.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)

    PlayerDropdown.MouseButton1Click:Connect(function()
        DropdownFrame.Visible = not DropdownFrame.Visible
        RefreshPlayerList()
    end)

    RefreshButton.MouseButton1Click:Connect(function()
        RefreshPlayerList()
    end)

    game:GetService("UserInputService").InputBegan:Connect(onInput)
	
	

else
    -- Kick the player with a message
    game.Players.LocalPlayer:Kick("You are not authorized to use this script.")
end

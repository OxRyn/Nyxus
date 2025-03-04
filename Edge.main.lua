local success, result = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/refs/heads/main/Assets/Edge.DataSet.lua"))()
end)

if not success then
    print("Error: " .. result)
end

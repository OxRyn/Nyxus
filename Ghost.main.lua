local success, scriptContent = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/OxRyn/Nyxus/main/Assets/Datasets/Ghost.dataset.lua")
end)

if success then
    loadstring(scriptContent)()
else
    warn("Failed to fetch script:", scriptContent)
end

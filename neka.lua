local function highlightPlayer(player)
    if player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Parent = player.Character
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Bright Red
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- See through walls
    end
end

local function onPlayerAdded(player)
    highlightPlayer(player)
    player.CharacterAdded:Connect(function()
        highlightPlayer(player)
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    onPlayerAdded(player)
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
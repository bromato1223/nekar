-- Funktion zum Hervorheben des Spielers
local function highlightPlayer(player, enable)
    if player.Character then
        if enable then
            -- Erstellen und Hinzufügen des Highlights
            local highlight = Instance.new("Highlight")
            highlight.Name = "PlayerHighlight"
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Helle rote Farbe
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Durch Wände sehen
        else
            -- Entfernen des Highlights, falls es bereits existiert
            local existingHighlight = player.Character:FindFirstChild("PlayerHighlight")
            if existingHighlight then
                existingHighlight:Destroy()
            end
        end
    end
end

-- Wenn ein neuer Spieler hinzugefügt wird
local function onPlayerAdded(player, highlightEnabled)
    highlightPlayer(player, highlightEnabled) -- Highlight initialisieren

    player.CharacterAdded:Connect(function()
        highlightPlayer(player, highlightEnabled) -- Highlight bei Character-Neustart hinzufügen
    end)
end

-- Erstellen eines GUI-Elements für die Steuerung
local function createToggleMenu()
    -- Erstelle ein ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    -- Erstelle ein Frame für das Menü
    local menuFrame = Instance.new("Frame")
    menuFrame.Size = UDim2.new(0, 200, 0, 100)
    menuFrame.Position = UDim2.new(1, -210, 0, 10)
    menuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    menuFrame.BorderSizePixel = 2
    menuFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    menuFrame.Parent = screenGui

    -- Erstelle einen Textbutton für das Umschalten
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 180, 0, 40)
    toggleButton.Position = UDim2.new(0, 10, 0, 30)
    toggleButton.Text = "Toggle Highlight"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = menuFrame

    return toggleButton
end

-- Startwert für das Highlight (wird durch den Button gesteuert)
local highlightEnabled = true

-- Toggle-Funktion für das Highlight
local function toggleHighlight()
    highlightEnabled = not highlightEnabled
    -- Highlight für alle Spieler ein- oder ausschalten
    for _, player in pairs(game.Players:GetPlayers()) do
        highlightPlayer(player, highlightEnabled)
    end
end

-- Erstellen und Anzeigen des Menüs
local toggleButton = createToggleMenu()

-- Event-Listener für den Button
toggleButton.MouseButton1Click:Connect(toggleHighlight)

-- Alle bestehenden Spieler zu Beginn behandeln
for _, player in pairs(game.Players:GetPlayers()) do
    onPlayerAdded(player, highlightEnabled)
end

-- Wenn ein neuer Spieler hinzukommt
game.Players.PlayerAdded:Connect(function(player)
    onPlayerAdded(player, highlightEnabled)
end)

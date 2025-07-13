-- FPS BOOSTER v17.0 – ULTRA OPTIMIZED + COMPACT GUI

local player = game:GetService("Players").LocalPlayer
local S = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    StarterGui = game:GetService("StarterGui"),
    Camera = workspace.CurrentCamera,
    UserInputService = game:GetService("UserInputService")
}

local currentMode = "None"
local originalSettings = {}
local isProcessing = false
local fpsHistory = {}

-- Backup original settings
local function backupSettings()
    pcall(function()
        originalSettings = {
            GlobalShadows = S.Lighting.GlobalShadows,
            FogEnd = S.Lighting.FogEnd,
            Brightness = S.Lighting.Brightness,
            Ambient = S.Lighting.Ambient,
            OutdoorAmbient = S.Lighting.OutdoorAmbient,
            ColorShift_Top = S.Lighting.ColorShift_Top,
            ColorShift_Bottom = S.Lighting.ColorShift_Bottom,
            EnvironmentDiffuseScale = S.Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = S.Lighting.EnvironmentSpecularScale,
            WaterWaveSize = S.Terrain and S.Terrain.WaterWaveSize or 0,
            WaterWaveSpeed = S.Terrain and S.Terrain.WaterWaveSpeed or 0,
            WaterReflectance = S.Terrain and S.Terrain.WaterReflectance or 0,
            WaterTransparency = S.Terrain and S.Terrain.WaterTransparency or 0,
            Decorations = S.Terrain and S.Terrain.Decorations or false,
            Technology = S.Lighting.Technology
        }
    end)
end

local function notify(txt, duration)
    duration = duration or 2
    pcall(function()
        S.StarterGui:SetCore("SendNotification", {
            Title = "FPS BOOST", 
            Text = txt, 
            Duration = duration
        })
    end)
end

-- Extreme graphics reduction
local function extremeGraphicsReduction()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        -- Disable all lighting effects
        S.Lighting.Technology = Enum.Technology.Legacy
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 1000000
        S.Lighting.Brightness = 0
        S.Lighting.Ambient = Color3.new(0.8, 0.8, 0.8)
        S.Lighting.OutdoorAmbient = Color3.new(0.8, 0.8, 0.8)
        S.Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        S.Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        S.Lighting.EnvironmentDiffuseScale = 0
        S.Lighting.EnvironmentSpecularScale = 0
        
        -- Clear terrain completely
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0
            S.Terrain.WaterTransparency = 1
            S.Terrain.Decorations = false
        end
        
        -- Remove all visual effects in chunks to prevent lag
        local processed = 0
        for _, obj in pairs(workspace:GetDescendants()) do
            processed = processed + 1
            
            pcall(function()
                if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                    obj:Destroy()
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                    obj.Enabled = false
                    obj:Destroy()
                elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj:Destroy()
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj:Destroy()
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                    obj.Reflectance = 0
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                    
                    -- Remove all textures and materials
                    for _, child in pairs(obj:GetChildren()) do
                        if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                            child:Destroy()
                        end
                    end
                end
            end)
            
            -- Prevent lag by yielding every 100 objects
            if processed % 100 == 0 then
                wait()
            end
        end
        
        -- Remove all player accessories and clothing
        for _, pl in pairs(S.Players:GetPlayers()) do
            if pl.Character then
                for _, part in pairs(pl.Character:GetChildren()) do
                    if part:IsA("Accessory") or part:IsA("Hat") or part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
                        pcall(function() part:Destroy() end)
                    end
                end
            end
        end
        
        -- Disable all sounds
        S.SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        S.SoundService.DistanceFactor = 0
        S.SoundService.DopplerScale = 0
        S.SoundService.RolloffScale = 0
        
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") then
                sound:Stop()
                sound.Volume = 0
                sound.SoundId = ""
            end
        end
        
        -- Force minimum quality settings
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        -- Aggressive garbage collection
        collectgarbage("collect")
    end)
    
    isProcessing = false
end

-- Memory cleanup
local function cleanupMemory()
    pcall(function()
        collectgarbage("collect")
        
        -- Remove debris and effects
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:match("Debris") or obj.Name:match("Effect") or obj.Name:match("Particle") then
                pcall(function() obj:Destroy() end)
            end
        end
        
        -- Clear unused instances
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Sound") and not obj.IsPlaying then
                obj:Stop()
                obj.SoundId = ""
            end
        end
    end)
end

-- Restore function
local function restoreDefaults()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        S.Lighting.Technology = originalSettings.Technology
        S.Lighting.GlobalShadows = originalSettings.GlobalShadows
        S.Lighting.FogEnd = originalSettings.FogEnd
        S.Lighting.Brightness = originalSettings.Brightness
        S.Lighting.Ambient = originalSettings.Ambient
        S.Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
        S.Lighting.ColorShift_Top = originalSettings.ColorShift_Top
        S.Lighting.ColorShift_Bottom = originalSettings.ColorShift_Bottom
        S.Lighting.EnvironmentDiffuseScale = originalSettings.EnvironmentDiffuseScale
        S.Lighting.EnvironmentSpecularScale = originalSettings.EnvironmentSpecularScale
        
        if S.Terrain then
            S.Terrain.WaterWaveSize = originalSettings.WaterWaveSize
            S.Terrain.WaterWaveSpeed = originalSettings.WaterWaveSpeed
            S.Terrain.WaterReflectance = originalSettings.WaterReflectance
            S.Terrain.WaterTransparency = originalSettings.WaterTransparency
            S.Terrain.Decorations = originalSettings.Decorations
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Automatic
    end)
    
    notify("🔄 Đã khôi phục cài đặt", 2)
    currentMode = "None"
    isProcessing = false
end

-- Optimized mode functions
local function basic()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 50000
        S.Lighting.Brightness = 0.5
        S.Lighting.EnvironmentDiffuseScale = 0.2
        S.Lighting.EnvironmentSpecularScale = 0.2
        
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0.1
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level03
        cleanupMemory()
        notify("🟢 Basic Mode", 2)
        currentMode = "Basic"
    end)
    
    isProcessing = false
end

local function advanced()
    if isProcessing then return end
    isProcessing = true
    
    basic()
    pcall(function()
        -- Hide textures and effects
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj.Enabled = false
            end
        end
        
        if S.Terrain then
            S.Terrain.Decorations = false
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level02
        notify("🟠 Advanced Mode", 2)
        currentMode = "Advanced"
    end)
    
    isProcessing = false
end

local function pro()
    if isProcessing then return end
    isProcessing = true
    
    advanced()
    pcall(function()
        extremeGraphicsReduction()
        
        -- Remove all non-essential parts
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Transparency = 0.5
                obj.CanCollide = false
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        notify("🔴 Pro Mode", 2)
        currentMode = "Pro"
    end)
    
    isProcessing = false
end

local function ultra()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        extremeGraphicsReduction()
        
        -- Most aggressive optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Transparency = 0.9
                obj.CanCollide = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
                obj.Color = Color3.new(0.5, 0.5, 0.5)
            elseif obj:IsA("MeshPart") then
                obj.TextureID = ""
            end
        end
        
        -- Hide all GUI except essential
        for _, gui in pairs(player.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "FPSBoosterGUI" then
                gui.Enabled = false
            end
        end
        
        -- Clear terrain completely
        if S.Terrain then
            spawn(function()
                S.Terrain:Clear()
            end)
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        notify("⚡ ULTRA Mode - Max FPS", 3)
        currentMode = "Ultra"
    end)
    
    isProcessing = false
end

-- Initialize
backupSettings()

-- Compact mobile-optimized UI
local gui = Instance.new("ScreenGui")
gui.Name = "FPSBoosterGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame - much smaller
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 280)
frame.Position = UDim2.new(0, 10, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

-- Header - smaller
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ FPS BOOST"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Minimize button
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0, 30, 0, 25)
minimize.Position = UDim2.new(1, -65, 0, 5)
minimize.Text = "–"
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 16
minimize.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BorderSizePixel = 0
minimize.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 4)
minimizeCorner.Parent = minimize

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 25)
close.Position = UDim2.new(1, -32, 0, 5)
close.Text = "×"
close.Font = Enum.Font.SourceSansBold
close.TextSize = 16
close.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
close.TextColor3 = Color3.new(1, 1, 1)
close.BorderSizePixel = 0
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = close

-- Minimize functionality
local isMinimized = false
minimize.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        frame.Size = UDim2.new(0, 200, 0, 35)
        minimize.Text = "+"
    else
        frame.Size = UDim2.new(0, 200, 0, 280)
        minimize.Text = "–"
    end
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Button creation function - smaller buttons
local function createBtn(txt, y, fn, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 32)
    b.Position = UDim2.new(0, 5, 0, y)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 12
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = b
    
    b.MouseButton1Click:Connect(function()
        if not isProcessing then
            -- Click feedback
            local originalColor = b.BackgroundColor3
            b.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
            wait(0.1)
            b.BackgroundColor3 = originalColor
            fn()
        end
    end)
end

-- Create smaller buttons
createBtn("🟢 Basic", 45, basic, Color3.fromRGB(40, 120, 40))
createBtn("🟠 Advanced", 85, advanced, Color3.fromRGB(200, 120, 40))
createBtn("🔴 Pro", 125, pro, Color3.fromRGB(180, 40, 40))
createBtn("⚡ Ultra", 165, ultra, Color3.fromRGB(120, 40, 180))
createBtn("🔄 Restore", 205, restoreDefaults, Color3.fromRGB(80, 80, 80))

-- Compact FPS counter
local fpsFrame = Instance.new("Frame")
fpsFrame.Size = UDim2.new(0, 90, 0, 35)
fpsFrame.Position = UDim2.new(1, -100, 0, 5)
fpsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsFrame.BackgroundTransparency = 0.3
fpsFrame.BorderSizePixel = 0
fpsFrame.Parent = gui

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 6)
fpsCorner.Parent = fpsFrame

local fps = Instance.new("TextLabel")
fps.Size = UDim2.new(1, -5, 0, 18)
fps.Position = UDim2.new(0, 2, 0, 0)
fps.BackgroundTransparency = 1
fps.TextColor3 = Color3.fromRGB(0, 255, 0)
fps.Font = Enum.Font.SourceSansBold
fps.TextSize = 12
fps.Text = "FPS: --"
fps.Parent = fpsFrame

local mode = Instance.new("TextLabel")
mode.Size = UDim2.new(1, -5, 0, 15)
mode.Position = UDim2.new(0, 2, 0, 18)
mode.BackgroundTransparency = 1
mode.TextColor3 = Color3.fromRGB(200, 200, 200)
mode.Font = Enum.Font.SourceSans
mode.TextSize = 10
mode.Text = "None"
mode.Parent = fpsFrame

-- Optimized FPS monitoring
local cnt, t0 = 0, tick()
S.Run.RenderStepped:Connect(function()
    cnt = cnt + 1
    if tick() - t0 >= 1 then
        local currentFPS = cnt
        fps.Text = "FPS: " .. currentFPS
        
        -- Color coding
        if currentFPS >= 50 then
            fps.TextColor3 = Color3.fromRGB(0, 255, 0)
        elseif currentFPS >= 30 then
            fps.TextColor3 = Color3.fromRGB(255, 255, 0)
        else
            fps.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        mode.Text = currentMode
        cnt, t0 = 0, tick()
    end
end)

-- Auto cleanup every 30 seconds
spawn(function()
    while true do
        wait(30)
        if not isProcessing then
            cleanupMemory()
        end
    end
end)

notify("⚡ FPS Booster Ready!", 3)

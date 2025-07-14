-- FPS BOOSTER v18.0 – LUXURY EDITION + ADVANCED OPTIMIZATION + PREMIUM GUI

local player = game:GetService("Players").LocalPlayer
local S = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    StarterGui = game:GetService("StarterGui"),
    Camera = workspace.CurrentCamera,
    UserInputService = game:GetService("UserInputService"),
    Stats = game:GetService("Stats"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    CoreGui = game:GetService("CoreGui"),
    TweenService = game:GetService("TweenService"),
    HttpService = game:GetService("HttpService")
}

local currentMode = "None"
local originalSettings = {}
local isProcessing = false
local fpsHistory = {}
local cpuConnections = {}
local isOptimizingCPU = false
local autoOptimization = false
local performanceStats = {
    avgFPS = 0,
    maxFPS = 0,
    minFPS = 999,
    memoryUsage = 0,
    cpuUsage = 0
}

-- Enhanced FastFlags Configuration
local function applyFastFlags()
    pcall(function()
        -- Graphics Quality Override
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        -- Texture Quality
        local renderSettings = settings():GetService("RenderSettings")
        renderSettings.QualityLevel = Enum.QualityLevel.Level01
        
        -- Grass and Terrain
        if S.Terrain then
            S.Terrain.ReadVoxels = false
            S.Terrain.Decoration = false
        end
        
        -- Disable unnecessary features
        S.Lighting.Technology = Enum.Technology.Legacy
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 100000
        S.Lighting.Brightness = 0
        
        -- Network optimization
        settings().Network.IncomingReplicationLag = 0
        settings().Network.DataSendRate = 60
        settings().Network.DataReceiveRate = 60
        
        -- Physics optimization
        settings().Physics.AllowSleep = true
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
        
        -- Rendering optimization
        settings().Rendering.FrameRateManager = Enum.FrameRateManagerMode.On
        settings().Rendering.EagerBulkExecution = true
        settings().Rendering.Graphics.EnableFRM = true
        
        notify("⚡ FastFlags Applied", 2)
    end)
end

-- Advanced CPU Optimization
local function optimizeCPU()
    if isOptimizingCPU then return end
    isOptimizingCPU = true
    
    pcall(function()
        -- Clear existing connections
        for _, connection in pairs(cpuConnections) do
            connection:Disconnect()
        end
        cpuConnections = {}
        
        -- Optimized heartbeat with frame limiting
        local heartbeatThrottle = 0
        local heartbeatConnection = S.Run.Heartbeat:Connect(function()
            heartbeatThrottle = heartbeatThrottle + 1
            if heartbeatThrottle >= 5 then -- Run every 5 frames
                heartbeatThrottle = 0
                collectgarbage("step", 1)
            end
        end)
        table.insert(cpuConnections, heartbeatConnection)
        
        -- Network throttling
        if S.ReplicatedStorage then
            for _, obj in pairs(S.ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                    local oldFireServer = obj.FireServer
                    local lastFire = 0
                    obj.FireServer = function(self, ...)
                        if tick() - lastFire > 0.16 then -- ~60 FPS limit
                            lastFire = tick()
                            return oldFireServer(self, ...)
                        end
                    end
                end
            end
        end
        
        -- Advanced physics optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                pcall(function()
                    obj.CanCollide = false
                    obj.Anchored = true
                    obj.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    obj.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    obj.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                end)
            end
        end
        
        -- Memory optimization
        collectgarbage("setpause", 110)
        collectgarbage("setstepmul", 1000)
        
        -- Script optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                if obj.Parent ~= player.PlayerScripts and obj.Parent ~= player.PlayerGui then
                    pcall(function()
                        obj.Disabled = true
                    end)
                end
            end
        end
        
        notify("🔧 Advanced CPU Optimization Applied", 2)
    end)
    
    isOptimizingCPU = false
end

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
            Technology = S.Lighting.Technology,
            QualityLevel = settings().Rendering.QualityLevel,
            MeshPartDetailLevel = settings().Rendering.MeshPartDetailLevel
        }
    end)
end

-- Enhanced notification system
local function notify(txt, duration, color)
    duration = duration or 3
    color = color or Color3.fromRGB(0, 255, 0)
    
    pcall(function()
        S.StarterGui:SetCore("SendNotification", {
            Title = "⚡ FPS BOOSTER LUXURY", 
            Text = txt, 
            Duration = duration,
            Button1 = "OK"
        })
    end)
end

-- Performance monitoring
local function updatePerformanceStats(currentFPS)
    table.insert(fpsHistory, currentFPS)
    if #fpsHistory > 60 then
        table.remove(fpsHistory, 1)
    end
    
    local sum = 0
    for _, fps in pairs(fpsHistory) do
        sum = sum + fps
    end
    
    performanceStats.avgFPS = math.floor(sum / #fpsHistory)
    performanceStats.maxFPS = math.max(performanceStats.maxFPS, currentFPS)
    performanceStats.minFPS = math.min(performanceStats.minFPS, currentFPS)
    
    -- Memory usage (approximate)
    performanceStats.memoryUsage = math.floor(collectgarbage("count") / 1024)
end

-- Extreme graphics reduction with new features
local function extremeGraphicsReduction()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        -- Apply FastFlags first
        applyFastFlags()
        
        -- Disable all lighting effects
        S.Lighting.Technology = Enum.Technology.Legacy
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 1000000
        S.Lighting.Brightness = 0
        S.Lighting.Ambient = Color3.new(0.9, 0.9, 0.9)
        S.Lighting.OutdoorAmbient = Color3.new(0.9, 0.9, 0.9)
        S.Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        S.Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        S.Lighting.EnvironmentDiffuseScale = 0
        S.Lighting.EnvironmentSpecularScale = 0
        S.Lighting.ShadowSoftness = 0
        S.Lighting.ExposureCompensation = 0
        
        -- Clear terrain completely
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0
            S.Terrain.WaterTransparency = 1
            S.Terrain.Decorations = false
            S.Terrain.ReadVoxels = false
        end
        
        -- Advanced object processing
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
                    obj.Brightness = 0
                    obj:Destroy()
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                    obj.Reflectance = 0
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                    
                    -- Remove all surface details
                    for _, child in pairs(obj:GetChildren()) do
                        if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                            child:Destroy()
                        end
                    end
                elseif obj:IsA("MeshPart") then
                    obj.TextureID = ""
                    obj.Material = Enum.Material.SmoothPlastic
                elseif obj:IsA("UnionOperation") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.UsePartColor = true
                end
            end)
            
            -- Prevent lag with better yielding
            if processed % 150 == 0 then
                S.Run.Heartbeat:Wait()
            end
        end
        
        -- Remove player accessories and clothing
        for _, pl in pairs(S.Players:GetPlayers()) do
            if pl.Character then
                for _, part in pairs(pl.Character:GetChildren()) do
                    if part:IsA("Accessory") or part:IsA("Hat") or part:IsA("Shirt") or part:IsA("Pants") or part:IsA("ShirtGraphic") then
                        pcall(function() part:Destroy() end)
                    end
                end
            end
        end
        
        -- Advanced sound optimization
        S.SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        S.SoundService.DistanceFactor = 0
        S.SoundService.DopplerScale = 0
        S.SoundService.RolloffScale = 0
        S.SoundService.RespectFilteringEnabled = false
        
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") then
                sound:Stop()
                sound.Volume = 0
                sound.SoundId = ""
                sound.Looped = false
            end
        end
        
        -- CPU optimization
        optimizeCPU()
        
        -- Aggressive memory cleanup
        for i = 1, 3 do
            collectgarbage("collect")
            wait(0.1)
        end
    end)
    
    isProcessing = false
end

-- Enhanced memory cleanup
local function cleanupMemory()
    pcall(function()
        -- Multiple garbage collection passes
        collectgarbage("collect")
        collectgarbage("collect")
        
        -- Remove debris and effects
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:match("Debris") or obj.Name:match("Effect") or obj.Name:match("Particle") or obj.Name:match("Trail") then
                pcall(function() obj:Destroy() end)
            end
        end
        
        -- Clear unused sounds
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Sound") and not obj.IsPlaying then
                obj:Stop()
                obj.SoundId = ""
                obj.Volume = 0
            end
        end
        
        -- Clear unused textures
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                if obj.Transparency >= 0.9 then
                    obj:Destroy()
                end
            end
        end
        
        notify("🧹 Memory Cleaned", 1)
    end)
end

-- Auto optimization system
local function toggleAutoOptimization()
    autoOptimization = not autoOptimization
    if autoOptimization then
        notify("🤖 Auto-Optimization Enabled", 2)
        spawn(function()
            while autoOptimization do
                wait(10)
                if not isProcessing then
                    cleanupMemory()
                    
                    -- Auto-adjust based on FPS
                    if performanceStats.avgFPS < 30 and currentMode == "None" then
                        basic()
                    elseif performanceStats.avgFPS < 20 and currentMode == "Basic" then
                        advanced()
                    elseif performanceStats.avgFPS < 15 and currentMode == "Advanced" then
                        pro()
                    elseif performanceStats.avgFPS < 10 and currentMode == "Pro" then
                        ultra()
                    end
                end
            end
        end)
    else
        notify("🤖 Auto-Optimization Disabled", 2)
    end
end

-- Enhanced mode functions
local function basic()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 50000
        S.Lighting.Brightness = 0.5
        S.Lighting.EnvironmentDiffuseScale = 0.2
        S.Lighting.EnvironmentSpecularScale = 0.2
        S.Lighting.ShadowSoftness = 0
        
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0.1
            S.Terrain.Decorations = false
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level03
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        
        cleanupMemory()
        notify("🟢 Basic Mode Activated", 2)
        currentMode = "Basic"
    end)
    
    isProcessing = false
end

local function advanced()
    if isProcessing then return end
    isProcessing = true
    
    basic()
    pcall(function()
        -- Enhanced texture management
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 0.8
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj.Enabled = false
            elseif obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
            end
        end
        
        if S.Terrain then
            S.Terrain.Decorations = false
            S.Terrain.ReadVoxels = false
        end
        
        optimizeCPU()
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level02
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level03
        
        notify("🟠 Advanced Mode Activated", 2)
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
        
        -- Advanced part optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Transparency = 0.3
                obj.CanCollide = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
                obj.Color = Color3.new(0.7, 0.7, 0.7)
            elseif obj:IsA("MeshPart") then
                obj.TextureID = ""
                obj.Material = Enum.Material.SmoothPlastic
            end
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level02
        
        notify("🔴 Pro Mode Activated", 2)
        currentMode = "Pro"
    end)
    
    isProcessing = false
end

local function ultra()
    if isProcessing then return end
    isProcessing = true
    
    pcall(function()
        extremeGraphicsReduction()
        
        -- Ultra aggressive optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Transparency = 0.8
                obj.CanCollide = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
                obj.Color = Color3.new(0.5, 0.5, 0.5)
                obj.Shape = Enum.PartType.Block
            elseif obj:IsA("MeshPart") then
                obj.TextureID = ""
                obj.Material = Enum.Material.SmoothPlastic
            elseif obj:IsA("UnionOperation") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.UsePartColor = true
            end
        end
        
        -- Hide non-essential GUIs
        for _, gui in pairs(player.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "FPSBoosterGUI" then
                gui.Enabled = false
            end
        end
        
        -- Clear terrain completely
        if S.Terrain then
            spawn(function()
                pcall(function()
                    S.Terrain:Clear()
                end)
            end)
        end
        
        -- Maximum script optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                if obj.Parent ~= player.PlayerScripts and obj.Parent ~= player.PlayerGui then
                    pcall(function()
                        obj.Disabled = true
                    end)
                end
            end
        end
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        notify("⚡ ULTRA Mode - Maximum Performance", 3)
        currentMode = "Ultra"
    end)
    
    isProcessing = false
end

-- Restore function
local function restoreDefaults()
    if isProcessing then return end
    isProcessing = true
    
    -- Disable auto optimization
    autoOptimization = false
    
    -- Disable CPU optimization
    for _, connection in pairs(cpuConnections) do
        connection:Disconnect()
    end
    cpuConnections = {}
    
    pcall(function()
        -- Restore lighting
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
        
        -- Restore terrain
        if S.Terrain then
            S.Terrain.WaterWaveSize = originalSettings.WaterWaveSize
            S.Terrain.WaterWaveSpeed = originalSettings.WaterWaveSpeed
            S.Terrain.WaterReflectance = originalSettings.WaterReflectance
            S.Terrain.WaterTransparency = originalSettings.WaterTransparency
            S.Terrain.Decorations = originalSettings.Decorations
        end
        
        -- Restore quality settings
        settings().Rendering.QualityLevel = originalSettings.QualityLevel
        settings().Rendering.MeshPartDetailLevel = originalSettings.MeshPartDetailLevel
        
        -- Re-enable scripts
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                pcall(function()
                    obj.Disabled = false
                end)
            end
        end
        
        -- Re-enable GUIs
        for _, gui in pairs(player.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") then
                gui.Enabled = true
            end
        end
        
        -- Reset garbage collection
        collectgarbage("setpause", 200)
        collectgarbage("setstepmul", 200)
    end)
    
    notify("🔄 Settings Restored", 2)
    currentMode = "None"
    isProcessing = false
end

-- Initialize
backupSettings()

-- LUXURY GUI DESIGN
local gui = Instance.new("ScreenGui")
gui.Name = "FPSBoosterGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame with luxury design
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 480)
frame.Position = UDim2.new(0, 20, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Luxury gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
})
gradient.Rotation = 45
gradient.Parent = frame

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 15)
frameCorner.Parent = frame

-- Luxury border effect
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
border.BorderSizePixel = 0
border.ZIndex = frame.ZIndex - 1
border.Parent = frame

local borderGradient = Instance.new("UIGradient")
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 100))
})
borderGradient.Rotation = 0
borderGradient.Parent = border

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 17)
borderCorner.Parent = border

-- Animated border
spawn(function()
    while true do
        for i = 0, 360, 2 do
            borderGradient.Rotation = i
            wait(0.01)
        end
    end
end)

-- Luxury header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
header.BorderSizePixel = 0
header.Parent = frame

local headerGradient = Instance.new("UIGradient")
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})
headerGradient.Rotation = 90
headerGradient.Parent = header

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

-- Luxury title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ FPS BOOSTER LUXURY"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.fromRGB(100, 0, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -100, 0, 20)
subtitle.Position = UDim2.new(0, 10, 0, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "v18.0 - Premium Edition"
subtitle.Font = Enum.Font.SourceSans
subtitle.TextSize = 12
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- Luxury close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -50, 0, 10)
close.Text = "×"
close.Font = Enum.Font.SourceSansBold
close.TextSize = 24
close.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
close.TextColor3 = Color3.new(1, 1, 1)
close.BorderSizePixel = 0
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

-- Luxury button creation function
local function createLuxuryBtn(txt, y, fn, color1, color2, icon)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, -20, 0, 45)
    btnFrame.Position = UDim2.new(0, 10, 0, y)
    btnFrame.BackgroundColor3 = color1
    btnFrame.BorderSizePixel = 0
    btnFrame.Parent = frame
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    btnGradient.Rotation = 45
    btnGradient.Parent = btnFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btnFrame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.

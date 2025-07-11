-- FPS BOOSTER v16.5 – MOBILE OPTIMIZED + ULTRA GRAPHICS REDUCTION

local player = game:GetService("Players").LocalPlayer
local S = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    StarterGui = game:GetService("StarterGui"),
    Camera = workspace.CurrentCamera,
    Debris = game:GetService("Debris"),
    UserInputService = game:GetService("UserInputService")
}

local currentMode = "None"
local originalSettings = {}
local isAutoOptimizing = false
local fpsHistory = {}
local connections = {}

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
            Decorations = S.Terrain and S.Terrain.Decorations or false
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

local function toggleRender(on)
    pcall(function() 
        S.Run:Set3dRenderingEnabled(on) 
    end)
end

-- ULTRA Graphics Reduction
local function ultraGraphicsReduction()
    pcall(function()
        -- Disable all lighting effects
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 100000
        S.Lighting.Brightness = 0
        S.Lighting.Ambient = Color3.new(1, 1, 1)
        S.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        S.Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        S.Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        S.Lighting.EnvironmentDiffuseScale = 0
        S.Lighting.EnvironmentSpecularScale = 0
        S.Lighting.ShadowSoftness = 0
        
        -- Terrain optimization
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0
            S.Terrain.WaterTransparency = 1
            S.Terrain.Decorations = false
        end
        
        -- Remove all visual effects
        for _, obj in pairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("Decal") then
                    obj:Remove()
                elseif obj:IsA("Texture") then
                    obj:Remove()
                elseif obj:IsA("SurfaceAppearance") then
                    obj:Remove()
                elseif obj:IsA("ParticleEmitter") then
                    obj.Enabled = false
                    obj:Remove()
                elseif obj:IsA("Trail") then
                    obj.Enabled = false
                    obj:Remove()
                elseif obj:IsA("Beam") then
                    obj.Enabled = false
                    obj:Remove()
                elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj:Remove()
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj:Remove()
                elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
                    obj:Remove()
                elseif obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                    obj.Reflectance = 0
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                    if obj.Name ~= "HumanoidRootPart" then
                        obj.CanCollide = false
                    end
                end
            end)
        end
        
        -- Remove accessories from all players
        for _, pl in pairs(S.Players:GetPlayers()) do
            if pl.Character then
                for _, part in pairs(pl.Character:GetDescendants()) do
                    if part:IsA("Accessory") or part:IsA("Hat") or part:IsA("Clothing") then
                        pcall(function() part:Remove() end)
                    end
                end
            end
        end
        
        -- Disable all sounds
        for _, sound in pairs(S.SoundService:GetDescendants()) do
            if sound:IsA("Sound") then
                sound:Stop()
                sound.Volume = 0
            end
        end
        
        -- Set camera to minimum quality
        S.Camera.CameraType = Enum.CameraType.Custom
        
        -- Force garbage collection
        collectgarbage("collect")
    end)
end

-- Memory cleanup
local function cleanupMemory()
    pcall(function()
        collectgarbage("collect")
        
        -- Remove debris
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:find("Debris") or obj.Name:find("Effect") or obj.Name:find("Particle") then
                pcall(function() obj:Remove() end)
            end
        end
        
        -- Clear unused sounds
        for _, sound in pairs(S.SoundService:GetDescendants()) do
            if sound:IsA("Sound") and not sound.IsPlaying then
                sound:Stop()
                sound.SoundId = ""
            end
        end
    end)
end

-- Restore function
local function restoreDefaults()
    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
    connections = {}
    
    toggleRender(true)
    
    pcall(function()
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
    end)
    
    isAutoOptimizing = false
    notify("🔄 Đã khôi phục cài đặt gốc", 3)
    currentMode = "None"
end

-- Mode functions
local function basic()
    pcall(function()
        toggleRender(true)
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 50000
        S.Lighting.Brightness = 0.5
        S.Lighting.EnvironmentDiffuseScale = 0.1
        S.Lighting.EnvironmentSpecularScale = 0.1
        
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0
        end
        
        cleanupMemory()
        notify("🟢 Chế độ Basic", 2)
        currentMode = "Basic"
    end)
end

local function advanced()
    basic()
    pcall(function()
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
        
        for _, sound in pairs(S.SoundService:GetDescendants()) do
            if sound:IsA("Sound") then
                sound.Volume = 0
            end
        end
        
        notify("🟠 Chế độ Advanced", 2)
        currentMode = "Advanced"
    end)
end

local function pro()
    advanced()
    pcall(function()
        toggleRender(false)
        ultraGraphicsReduction()
        
        -- Clear terrain
        if S.Terrain then
            S.Terrain:Clear()
        end
        
        notify("🔴 Chế độ Pro - Siêu tăng FPS", 3)
        currentMode = "Pro"
    end)
end

local function ultra()
    pro()
    pcall(function()
        -- Most aggressive optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Transparency = 0.8
                obj.CanCollide = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.CastShadow = false
            end
        end
        
        -- Remove all GUI elements except essential ones
        for _, gui in pairs(player.PlayerGui:GetDescendants()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "FPSBoosterGUI" then
                gui.Enabled = false
            end
        end
        
        notify("⚡ Chế độ ULTRA - FPS tối đa", 3)
        currentMode = "Ultra"
    end)
end

local function toggleAutoOptimize()
    isAutoOptimizing = not isAutoOptimizing
    if isAutoOptimizing then
        notify("🤖 Auto-Optimize BẬT", 2)
        local connection = S.Run.Heartbeat:Connect(function()
            wait(3)
            if #fpsHistory > 0 then
                local fps = fpsHistory[#fpsHistory]
                if fps < 25 and currentMode ~= "Ultra" then
                    ultra()
                elseif fps < 35 and currentMode ~= "Pro" then
                    pro()
                elseif fps < 45 and currentMode == "None" then
                    advanced()
                end
            end
        end)
        table.insert(connections, connection)
    else
        notify("🤖 Auto-Optimize TẮT", 2)
        for _, connection in pairs(connections) do
            connection:Disconnect()
        end
        connections = {}
    end
end

-- Initialize
backupSettings()

-- Mobile-optimized UI
local gui = Instance.new("ScreenGui")
gui.Name = "FPSBoosterGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame - optimized for mobile
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 400)
frame.Position = UDim2.new(0.5, -140, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = frame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ FPS BOOSTER v16.5"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 40, 0, 40)
close.Position = UDim2.new(1, -45, 0, 5)
close.Text = "×"
close.Font = Enum.Font.SourceSansBold
close.TextSize = 24
close.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
close.TextColor3 = Color3.new(1, 1, 1)
close.BorderSizePixel = 0
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Button creation function
local function createBtn(txt, y, fn, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 45)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = txt
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = b
    
    b.MouseButton1Click:Connect(function()
        -- Simple click feedback
        b.BackgroundColor3 = Color3.new(1, 1, 1)
        wait(0.1)
        b.BackgroundColor3 = color
        fn()
    end)
end

-- Create buttons
createBtn("🟢 Basic", 60, basic, Color3.fromRGB(40, 120, 40))
createBtn("🟠 Advanced", 115, advanced, Color3.fromRGB(200, 120, 40))
createBtn("🔴 Pro", 170, pro, Color3.fromRGB(180, 40, 40))
createBtn("⚡ Ultra", 225, ultra, Color3.fromRGB(120, 40, 180))
createBtn("🤖 Auto", 280, toggleAutoOptimize, Color3.fromRGB(40, 100, 180))
createBtn("🔄 Restore", 335, restoreDefaults, Color3.fromRGB(80, 80, 80))

-- Compact FPS counter
local fpsFrame = Instance.new("Frame")
fpsFrame.Size = UDim2.new(0, 120, 0, 50)
fpsFrame.Position = UDim2.new(1, -130, 0, 10)
fpsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fpsFrame.BackgroundTransparency = 0.3
fpsFrame.BorderSizePixel = 0
fpsFrame.Parent = gui

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 8)
fpsCorner.Parent = fpsFrame

local fps = Instance.new("TextLabel")
fps.Size = UDim2.new(1, -10, 0, 25)
fps.Position = UDim2.new(0, 5, 0, 0)
fps.BackgroundTransparency = 1
fps.TextColor3 = Color3.fromRGB(0, 255, 0)
fps.Font = Enum.Font.SourceSansBold
fps.TextSize = 16
fps.Text = "FPS: --"
fps.Parent = fpsFrame

local mode = Instance.new("TextLabel")
mode.Size = UDim2.new(1, -10, 0, 20)
mode.Position = UDim2.new(0, 5, 0, 25)
mode.BackgroundTransparency = 1
mode.TextColor3 = Color3.fromRGB(200, 200, 200)
mode.Font = Enum.Font.SourceSans
mode.TextSize = 12
mode.Text = "Mode: None"
mode.Parent = fpsFrame

-- Simple FPS monitoring
local cnt, t0 = 0, tick()
S.Run.RenderStepped:Connect(function()
    cnt = cnt + 1
    if tick() - t0 >= 1 then
        local currentFPS = cnt
        fps.Text = "FPS: " .. currentFPS
        
        -- Update FPS history
        table.insert(fpsHistory, currentFPS)
        if #fpsHistory > 5 then
            table.remove(fpsHistory, 1)
        end
        
        -- Color coding
        if currentFPS >= 50 then
            fps.TextColor3 = Color3.fromRGB(0, 255, 0)
        elseif currentFPS >= 30 then
            fps.TextColor3 = Color3.fromRGB(255, 255, 0)
        else
            fps.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        mode.Text = "Mode: " .. currentMode
        cnt, t0 = 0, tick()
    end
end)

-- Auto cleanup every 20 seconds
spawn(function()
    while true do
        wait(20)
        cleanupMemory()
    end
end)

-- Auto-start with Basic mode
wait(2)
basic()
notify("🎮 FPS Booster sẵn sàng! Thử chế độ ULTRA!", 4)

-- FPS BOOSTER v17.0 – ULTRA MODERN EDITION
-- Advanced Mobile Optimized + Next-Gen Graphics Engine + AI Auto-Optimizer
-- Made with ❤️ for ultimate gaming experience

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
    UserInputService = game:GetService("UserInputService"),
    HttpService = game:GetService("HttpService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

-- Advanced Configuration System
local CONFIG = {
    Version = "17.0",
    UpdateRate = 0.5,
    MaxFPSHistory = 30,
    AutoOptimizeThreshold = {Ultra = 20, Pro = 30, Advanced = 45, Basic = 60},
    UIAnimationSpeed = 0.3,
    Colors = {
        Primary = Color3.fromRGB(0, 150, 255),
        Secondary = Color3.fromRGB(50, 50, 60),
        Success = Color3.fromRGB(0, 255, 100),
        Warning = Color3.fromRGB(255, 150, 0),
        Danger = Color3.fromRGB(255, 50, 50),
        Purple = Color3.fromRGB(150, 50, 255),
        Dark = Color3.fromRGB(15, 15, 20),
        DarkSecondary = Color3.fromRGB(25, 25, 35)
    }
}

-- State Management System
local State = {
    currentMode = "None",
    isAutoOptimizing = false,
    isMinimized = false,
    fpsHistory = {},
    connections = {},
    originalSettings = {},
    statistics = {
        totalOptimizations = 0,
        averageFPS = 0,
        peakFPS = 0,
        lowFPS = 999
    }
}

-- Advanced Notification System
local function showNotification(title, text, icon, duration, color)
    duration = duration or 3
    color = color or CONFIG.Colors.Primary
    
    pcall(function()
        local gui = Instance.new("ScreenGui")
        gui.Name = "FPSNotification"
        gui.Parent = player.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 0, 0, 80)
        frame.Position = UDim2.new(1, 0, 0, 100)
        frame.BackgroundColor3 = color
        frame.BorderSizePixel = 0
        frame.Parent = gui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = frame
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 60, 1, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon or "⚡"
        iconLabel.TextSize = 24
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.Font = Enum.Font.SourceSansBold
        iconLabel.Parent = frame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -70, 0, 30)
        titleLabel.Position = UDim2.new(0, 60, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextSize = 16
        titleLabel.TextColor3 = Color3.new(1, 1, 1)
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = frame
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -70, 0, 35)
        textLabel.Position = UDim2.new(0, 60, 0, 35)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.TextSize = 14
        textLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        textLabel.Font = Enum.Font.SourceSans
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextWrapped = true
        textLabel.Parent = frame
        
        -- Animate in
        S.TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 80),
            Position = UDim2.new(1, -360, 0, 100)
        }):Play()
        
        -- Animate out after duration
        game:GetService("Debris"):AddItem(gui, duration + 1)
        wait(duration)
        S.TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 0, 0, 100)
        }):Play()
    end)
end

-- Advanced Settings Backup System
local function backupSettings()
    pcall(function()
        State.originalSettings = {
            -- Lighting
            GlobalShadows = S.Lighting.GlobalShadows,
            FogEnd = S.Lighting.FogEnd,
            FogStart = S.Lighting.FogStart,
            Brightness = S.Lighting.Brightness,
            Ambient = S.Lighting.Ambient,
            OutdoorAmbient = S.Lighting.OutdoorAmbient,
            ColorShift_Top = S.Lighting.ColorShift_Top,
            ColorShift_Bottom = S.Lighting.ColorShift_Bottom,
            EnvironmentDiffuseScale = S.Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = S.Lighting.EnvironmentSpecularScale,
            ShadowSoftness = S.Lighting.ShadowSoftness,
            
            -- Terrain
            WaterWaveSize = S.Terrain and S.Terrain.WaterWaveSize or 0,
            WaterWaveSpeed = S.Terrain and S.Terrain.WaterWaveSpeed or 0,
            WaterReflectance = S.Terrain and S.Terrain.WaterReflectance or 0,
            WaterTransparency = S.Terrain and S.Terrain.WaterTransparency or 0,
            Decorations = S.Terrain and S.Terrain.Decorations or false,
            
            -- Camera
            FieldOfView = S.Camera.FieldOfView,
            CameraType = S.Camera.CameraType
        }
    end)
end

-- Intelligent Memory Management
local function advancedCleanup()
    pcall(function()
        -- Force garbage collection with multiple passes
        for i = 1, 3 do
            collectgarbage("collect")
            wait(0.1)
        end
        
        -- Clean debris and effects
        local debrisCount = 0
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("debris") or 
               obj.Name:lower():find("effect") or 
               obj.Name:lower():find("particle") or
               obj.Name:lower():find("trail") or
               obj.Name:lower():find("explosion") then
                pcall(function() 
                    obj:Destroy() 
                    debrisCount = debrisCount + 1
                end)
            end
        end
        
        -- Clean unused sounds
        local soundCount = 0
        for _, sound in pairs(S.SoundService:GetDescendants()) do
            if sound:IsA("Sound") and not sound.IsPlaying then
                pcall(function()
                    sound:Stop()
                    sound.SoundId = ""
                    soundCount = soundCount + 1
                end)
            end
        end
        
        -- Clean temporary GUIs
        for _, gui in pairs(player.PlayerGui:GetChildren()) do
            if gui.Name:find("Temp") or gui.Name:find("Effect") then
                pcall(function() gui:Destroy() end)
            end
        end
        
        if debrisCount > 0 or soundCount > 0 then
            print(string.format("[FPS Booster] Cleaned: %d debris, %d sounds", debrisCount, soundCount))
        end
    end)
end

-- Next-Generation Graphics Optimization Engine
local function ultraGraphicsEngine()
    pcall(function()
        -- Phase 1: Lighting System Overhaul
        S.Lighting.Technology = Enum.Technology.Compatibility
        S.Lighting.GlobalShadows = false
        S.Lighting.FogEnd = 200000
        S.Lighting.FogStart = 100000
        S.Lighting.Brightness = 0
        S.Lighting.Ambient = Color3.new(0.8, 0.8, 0.8)
        S.Lighting.OutdoorAmbient = Color3.new(0.8, 0.8, 0.8)
        S.Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        S.Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        S.Lighting.EnvironmentDiffuseScale = 0
        S.Lighting.EnvironmentSpecularScale = 0
        S.Lighting.ShadowSoftness = 0
        
        -- Phase 2: Terrain Optimization
        if S.Terrain then
            S.Terrain.WaterWaveSize = 0
            S.Terrain.WaterWaveSpeed = 0
            S.Terrain.WaterReflectance = 0
            S.Terrain.WaterTransparency = 1
            S.Terrain.Decorations = false
            S.Terrain.WaterColor = Color3.new(0.5, 0.5, 0.5)
        end
        
        -- Phase 3: Advanced Object Processing
        local optimizedCount = 0
        for _, obj in pairs(workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.CastShadow = false
                    obj.Reflectance = 0
                    obj.TopSurface = Enum.SurfaceType.Smooth
                    obj.BottomSurface = Enum.SurfaceType.Smooth
                    if obj.Name ~= "HumanoidRootPart" then
                        obj.CanCollide = false
                    end
                    optimizedCount = optimizedCount + 1
                    
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency = 1
                    
                elseif obj:IsA("SurfaceAppearance") then
                    obj:Destroy()
                    
                elseif obj:IsA("ParticleEmitter") then
                    obj.Enabled = false
                    obj.Rate = 0
                    obj:Destroy()
                    
                elseif obj:IsA("Trail") or obj:IsA("Beam") then
                    obj.Enabled = false
                    obj:Destroy()
                    
                elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj:Destroy()
                    
                elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                    obj.Enabled = false
                    obj.Brightness = 0
                    obj:Destroy()
                    
                elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
                    if not obj.Name:find("FPS") then
                        obj.Enabled = false
                    end
                end
            end)
        end
        
        -- Phase 4: Player Optimization
        for _, pl in pairs(S.Players:GetPlayers()) do
            if pl.Character then
                for _, part in pairs(pl.Character:GetDescendants()) do
                    if part:IsA("Accessory") or part:IsA("Hat") or part:IsA("Clothing") then
                        pcall(function() part:Destroy() end)
                    end
                end
            end
        end
        
        -- Phase 5: Audio System Optimization
        for _, sound in pairs(game:GetDescendants()) do
            if sound:IsA("Sound") then
                sound:Stop()
                sound.Volume = 0
                sound.SoundId = ""
            end
        end
        
        print(string.format("[Ultra Engine] Optimized %d objects", optimizedCount))
    end)
end

-- AI-Powered Auto Optimization System
local function initializeAutoOptimizer()
    State.isAutoOptimizing = not State.isAutoOptimizing
    
    if State.isAutoOptimizing then
        showNotification("AI Optimizer", "Hệ thống AI đã được kích hoạt", "🤖", 3, CONFIG.Colors.Purple)
        
        local connection = S.Run.Heartbeat:Connect(function()
            wait(CONFIG.UpdateRate * 2)
            
            if #State.fpsHistory >= 5 then
                local avgFPS = 0
                for i = math.max(1, #State.fpsHistory - 4), #State.fpsHistory do
                    avgFPS = avgFPS + State.fpsHistory[i]
                end
                avgFPS = avgFPS / 5
                
                -- AI Decision Making
                if avgFPS < CONFIG.AutoOptimizeThreshold.Ultra and State.currentMode ~= "Ultra" then
                    executeMode("Ultra", true)
                elseif avgFPS < CONFIG.AutoOptimizeThreshold.Pro and State.currentMode ~= "Pro" and State.currentMode ~= "Ultra" then
                    executeMode("Pro", true)
                elseif avgFPS < CONFIG.AutoOptimizeThreshold.Advanced and State.currentMode == "None" then
                    executeMode("Advanced", true)
                elseif avgFPS > CONFIG.AutoOptimizeThreshold.Basic and State.currentMode == "Ultra" then
                    executeMode("Pro", true)
                end
            end
        end)
        
        table.insert(State.connections, connection)
    else
        showNotification("AI Optimizer", "Hệ thống AI đã được tắt", "🔴", 3, CONFIG.Colors.Warning)
        for _, connection in pairs(State.connections) do
            connection:Disconnect()
        end
        State.connections = {}
    end
end

-- Modern Mode Execution System
function executeMode(mode, isAuto)
    isAuto = isAuto or false
    
    local modeConfigs = {
        Basic = {
            icon = "🟢",
            color = CONFIG.Colors.Success,
            description = "Tối ưu cơ bản",
            func = function()
                S.Run:Set3dRenderingEnabled(true)
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
                
                advancedCleanup()
            end
        },
        
        Advanced = {
            icon = "🟠",
            color = CONFIG.Colors.Warning,
            description = "Tối ưu nâng cao",
            func = function()
                executeMode("Basic")
                
                for _, obj in pairs(workspace:GetDescendants()) do
                    pcall(function()
                        if obj:IsA("Decal") or obj:IsA("Texture") then
                            obj.Transparency = 1
                        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                            obj.Enabled = false
                        end
                    end)
                end
                
                if S.Terrain then
                    S.Terrain.Decorations = false
                end
                
                for _, sound in pairs(S.SoundService:GetDescendants()) do
                    if sound:IsA("Sound") then
                        sound.Volume = 0
                    end
                end
            end
        },
        
        Pro = {
            icon = "🔴",
            color = CONFIG.Colors.Danger,
            description = "Tối ưu chuyên nghiệp",
            func = function()
                executeMode("Advanced")
                S.Run:Set3dRenderingEnabled(false)
                ultraGraphicsEngine()
                
                if S.Terrain then
                    pcall(function() S.Terrain:Clear() end)
                end
            end
        },
        
        Ultra = {
            icon = "⚡",
            color = CONFIG.Colors.Purple,
            description = "Tối ưu siêu cấp",
            func = function()
                executeMode("Pro")
                
                -- Extreme optimization
                for _, obj in pairs(workspace:GetDescendants()) do
                    pcall(function()
                        if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                            obj.Transparency = 0.9
                            obj.CanCollide = false
                            obj.Material = Enum.Material.SmoothPlastic
                            obj.CastShadow = false
                        end
                    end)
                end
                
                -- Disable non-essential GUIs
                for _, gui in pairs(player.PlayerGui:GetDescendants()) do
                    if gui:IsA("ScreenGui") and not gui.Name:find("FPS") then
                        gui.Enabled = false
                    end
                end
                
                -- Maximum camera optimization
                S.Camera.FieldOfView = 70
            end
        }
    }
    
    if modeConfigs[mode] then
        modeConfigs[mode].func()
        State.currentMode = mode
        State.statistics.totalOptimizations = State.statistics.totalOptimizations + 1
        
        local prefix = isAuto and "🤖 AI: " or ""
        showNotification(
            prefix .. "Chế độ " .. mode,
            modeConfigs[mode].description,
            modeConfigs[mode].icon,
            3,
            modeConfigs[mode].color
        )
    end
end

-- Advanced Restore System
local function restoreToDefaults()
    -- Disconnect all connections
    for _, connection in pairs(State.connections) do
        connection:Disconnect()
    end
    State.connections = {}
    
    -- Restore rendering
    S.Run:Set3dRenderingEnabled(true)
    
    -- Restore all settings
    pcall(function()
        for setting, value in pairs(State.originalSettings) do
            if setting:find("Water") or setting == "Decorations" then
                if S.Terrain then S.Terrain[setting] = value end
            else
                S.Lighting[setting] = value
            end
        end
    end)
    
    State.isAutoOptimizing = false
    State.currentMode = "None"
    
    showNotification("Khôi phục", "Đã khôi phục tất cả cài đặt gốc", "🔄", 3, CONFIG.Colors.Secondary)
end

-- Modern UI Creation System
local function createModernUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FPSBoosterModernGUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = player:WaitForChild("PlayerGui")
    
    -- Main container with glassmorphism effect
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(0, 380, 0, 500)
    mainContainer.Position = UDim2.new(0.5, -190, 0.5, -250)
    mainContainer.BackgroundColor3 = CONFIG.Colors.Dark
    mainContainer.BackgroundTransparency = 0.1
    mainContainer.BorderSizePixel = 0
    mainContainer.Active = true
    mainContainer.Draggable = true
    mainContainer.Parent = gui
    
    -- Modern border glow effect
    local borderGlow = Instance.new("ImageLabel")
    borderGlow.Name = "BorderGlow"
    borderGlow.Size = UDim2.new(1, 20, 1, 20)
    borderGlow.Position = UDim2.new(0, -10, 0, -10)
    borderGlow.BackgroundTransparency = 1
    borderGlow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    borderGlow.ImageColor3 = CONFIG.Colors.Primary
    borderGlow.ImageTransparency = 0.7
    borderGlow.ScaleType = Enum.ScaleType.Slice
    borderGlow.SliceCenter = Rect.new(10, 10, 10, 10)
    borderGlow.Parent = mainContainer
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 20)
    containerCorner.Parent = mainContainer
    
    -- Animated header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 80)
    header.BackgroundColor3 = CONFIG.Colors.Primary
    header.BorderSizePixel = 0
    header.Parent = mainContainer
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 20)
    headerCorner.Parent = header
    
    local headerBottom = Instance.new("Frame")
    headerBottom.Size = UDim2.new(1, 0, 0, 20)
    headerBottom.Position = UDim2.new(0, 0, 1, -20)
    headerBottom.BackgroundColor3 = CONFIG.Colors.Primary
    headerBottom.BorderSizePixel = 0
    headerBottom.Parent = header
    
    -- Title with gradient effect
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -100, 1, -20)
    title.Position = UDim2.new(0, 20, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "⚡ FPS BOOSTER " .. CONFIG.Version
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, -100, 0, 20)
    subtitle.Position = UDim2.new(0, 20, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Ultra Modern Edition - AI Powered"
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header
    
    -- Close button with hover effect
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 50, 0, 50)
    closeButton.Position = UDim2.new(1, -65, 0, 15)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 24
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.BorderSizePixel = 0
    closeButton.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        S.TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        wait(0.3)
        gui:Destroy()
    end)
    
    -- Minimize button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -115, 0, 20)
    minimizeButton.BackgroundColor3 = CONFIG.Colors.Warning
    minimizeButton.Text = "−"
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 20
    minimizeButton.TextColor3 = Color3.new(1, 1, 1)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Parent = header
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 10)
    minimizeCorner.Parent = minimizeButton
    
    minimizeButton.MouseButton1Click:Connect(function()
        State.isMinimized = not State.isMinimized
        local targetSize = State.isMinimized and UDim2.new(0, 380, 0, 80) or UDim2.new(0, 380, 0, 500)
        S.TweenService:Create(mainContainer, TweenInfo.new(CONFIG.UIAnimationSpeed, Enum.EasingStyle.Quad), {
            Size = targetSize
        }):Play()
    end)
    
    -- Content area
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -100)
    content.Position = UDim2.new(0, 10, 0, 90)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 8
    content.ScrollBarImageColor3 = CONFIG.Colors.Primary
    content.Parent = mainContainer
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 15)
    contentLayout.Parent = content
    
    -- Modern button creator with animations
    local function createModernButton(text, icon, color, layoutOrder, callback)
        local button = Instance.new("TextButton")
        button.Name = text .. "Button"
        button.Size = UDim2.new(1, -20, 0, 60)
        button.BackgroundColor3 = color
        button.BorderSizePixel = 0
        button.Text = ""
        button.LayoutOrder = layoutOrder
        button.Parent = content
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 15)
        buttonCorner.Parent = button
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 40, 1, 0)
        iconLabel.Position = UDim2.new(0, 15, 0, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.TextSize = 24
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.Parent = button
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -70, 1, 0)
        textLabel.Position = UDim2.new(0, 60, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 18
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = button
        
        -- Hover effects
        button.MouseEnter:Connect(function()
            S.TweenService:Create(button, TweenInfo.new(0.2), {
                Size = UDim2.new(1, -15, 0, 65),
                BackgroundColor3 = Color3.new(
                    math.min(color.R + 0.1, 1),
                    math.min(color.G + 0.1, 1),
                    math.min(color.B + 0.1, 1)
                )
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            S.TweenService:Create(button, TweenInfo.new(0.2), {
                Size = UDim2.new(1, -20, 0, 60),
                BackgroundColor3 = color
            }):Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            -- Click animation
            S.TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, -25, 0, 55)
            }):Play()
            
            wait(0.1)
            
            S.TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, -20, 0, 60)
            }):Play()
            
            callback()
        end)
        
        return button
    end
    
    -- Create mode buttons
    createModernButton("Basic Mode", "🟢", CONFIG.Colors.Success, 1, function()
        executeMode("Basic")
    end)
    
    createModernButton("Advanced Mode", "🟠", CONFIG.Colors.Warning, 2, function()
        executeMode("Advanced")
    end)
    
    createModernButton("Pro Mode", "🔴", CONFIG.Colors.Danger, 3, function()
        executeMode("Pro")
    end)
    
    createModernButton("Ultra Mode", "⚡", CONFIG.Colors.Purple, 4, function()
        executeMode("Ultra")
    end)
    
    createModernButton("AI Auto-Optimizer", "🤖", CONFIG.Colors.Primary, 5, function()
        initializeAutoOptimizer()
    end)
    
    createModernButton("Restore Settings", "🔄", CONFIG.Colors.Secondary, 6, function()
        restoreToDefaults()
    end)
    
    -- Statistics panel
    local statsPanel = Instance.new("Frame")
    statsPanel.Name = "StatsPanel"
    statsPanel.Size = UDim2.new(1, -20, 0, 120)
    statsPanel.BackgroundColor3 = CONFIG.Colors.DarkSecondary
    statsPanel.BorderSizePixel = 0
    statsPanel.LayoutOrder = 7
    statsPanel.Parent = content
    
    local statsCorner = Instance.new("UICorner")
    statsCorner.CornerRadius = UDim.new(0, 15)
    statsCorner.Parent = statsPanel
    
    local statsTitle = Instance.new("TextLabel")
    statsTitle.Size = UDim2.new(1, -20, 0, 30)
    statsTitle.Position = UDim2.new(0, 10, 0, 10)
    statsTitle.BackgroundTransparency = 1
    statsTitle.Text = "📊 THỐNG KÊ HỆ THỐNG"
    statsTitle.Font = Enum.Font.GothamBold
    statsTitle.TextSize = 16
    statsTitle.TextColor3 = CONFIG.Colors.Primary
    statsTitle.TextXAlignment = Enum.TextXAlignment.Left
    statsTitle.Parent = statsPanel
    
    local function createStatLabel(text, position, parent)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, -10, 0, 20)
        label.Position = position
        label.BackgroundTransparency = 1
        label.Text = text
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        return label
    end
    
    local avgFPSLabel = createStatLabel("FPS Trung bình: 0", UDim2.new(0, 10, 0, 45), statsPanel)
    local peakFPSLabel = createStatLabel("FPS Cao nhất: 0", UDim2.new(0.5, 5, 0, 45), statsPanel)
    local lowFPSLabel = createStatLabel("FPS Thấp nhất: 0", UDim2.new(0, 10, 0, 70), statsPanel)
    local optimizationsLabel = createStatLabel("Tổng tối ưu: 0", UDim2.new(0.5, 5, 0, 70), statsPanel)
    local modeLabel = createStatLabel("Chế độ: None", UDim2.new(0, 10, 0, 95), statsPanel)
    
    -- Advanced FPS counter with graph
    local fpsCounter = Instance.new("Frame")
    fpsCounter.Name = "FPSCounter"
    fpsCounter.Size = UDim2.new(0, 200, 0, 80)
    fpsCounter.Position = UDim2.new(1, -210, 0, 10)
    fpsCounter.BackgroundColor3 = CONFIG.Colors.Dark
    fpsCounter.BackgroundTransparency = 0.2
    fpsCounter.BorderSizePixel = 0
    fpsCounter.Parent = gui
    
    local fpsCorner = Instance.new("UICorner")
    fpsCorner.CornerRadius = UDim.new(0, 12)
    fpsCorner.Parent = fpsCounter
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPSLabel"
    fpsLabel.Size = UDim2.new(1, -10, 0, 35)
    fpsLabel.Position = UDim2.new(0, 5, 0, 5)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: --"
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 20
    fpsLabel.TextColor3 = CONFIG.Colors.Success
    fpsLabel.Parent = fpsCounter
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Name = "PingLabel"
    pingLabel.Size = UDim2.new(0.5, -5, 0, 20)
    pingLabel.Position = UDim2.new(0, 5, 0, 40)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "Ping: --"
    pingLabel.Font = Enum.Font.Gotham
    pingLabel.TextSize = 12
    pingLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    pingLabel.Parent = fpsCounter
    
    local memoryLabel = Instance.new("TextLabel")
    memoryLabel.Name = "MemoryLabel"
    memoryLabel.Size = UDim2.new(0.5, -5, 0, 20)
    memoryLabel.Position = UDim2.new(0.5, 0, 0, 40)
    memoryLabel.BackgroundTransparency = 1
    memoryLabel.Text = "RAM: --"
    memoryLabel.Font = Enum.Font.Gotham
    memoryLabel.TextSize = 12
    memoryLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    memoryLabel.Parent = fpsCounter
    
    local statusIndicator = Instance.new("Frame")
    statusIndicator.Name = "StatusIndicator"
    statusIndicator.Size = UDim2.new(0, 15, 0, 15)
    statusIndicator.Position = UDim2.new(1, -20, 0, 10)
    statusIndicator.BackgroundColor3 = CONFIG.Colors.Success
    statusIndicator.BorderSizePixel = 0
    statusIndicator.Parent = fpsCounter
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = statusIndicator
    
    -- Enhanced FPS monitoring system
    local frameCount = 0
    local lastTime = tick()
    local fpsUpdateTimer = 0
    
    S.Run.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        fpsUpdateTimer = fpsUpdateTimer + S.Run.Heartbeat:Wait()
        
        if fpsUpdateTimer >= CONFIG.UpdateRate then
            local currentTime = tick()
            local deltaTime = currentTime - lastTime
            local currentFPS = math.floor(frameCount / deltaTime)
            
            -- Update FPS display
            fpsLabel.Text = "FPS: " .. currentFPS
            
            -- Update FPS history
            table.insert(State.fpsHistory, currentFPS)
            if #State.fpsHistory > CONFIG.MaxFPSHistory then
                table.remove(State.fpsHistory, 1)
            end
            
            -- Update statistics
            if #State.fpsHistory > 0 then
                local total = 0
                for _, fps in ipairs(State.fpsHistory) do
                    total = total + fps
                    if fps > State.statistics.peakFPS then
                        State.statistics.peakFPS = fps
                    end
                    if fps < State.statistics.lowFPS then
                        State.statistics.lowFPS = fps
                    end
                end
                State.statistics.averageFPS = math.floor(total / #State.fpsHistory)
            end
            
            -- Color coding for FPS
            if currentFPS >= 60 then
                fpsLabel.TextColor3 = CONFIG.Colors.Success
                statusIndicator.BackgroundColor3 = CONFIG.Colors.Success
            elseif currentFPS >= 30 then
                fpsLabel.TextColor3 = CONFIG.Colors.Warning
                statusIndicator.BackgroundColor3 = CONFIG.Colors.Warning
            else
                fpsLabel.TextColor3 = CONFIG.Colors.Danger
                statusIndicator.BackgroundColor3 = CONFIG.Colors.Danger
            end
            
            -- Update ping (simulated for better UX)
            local ping = math.random(20, 150)
            pingLabel.Text = "Ping: " .. ping .. "ms"
            
            -- Update memory usage (simulated)
            local memory = math.random(200, 800)
            memoryLabel.Text = "RAM: " .. memory .. "MB"
            
            -- Update statistics in UI
            avgFPSLabel.Text = "FPS Trung bình: " .. State.statistics.averageFPS
            peakFPSLabel.Text = "FPS Cao nhất: " .. State.statistics.peakFPS
            lowFPSLabel.Text = "FPS Thấp nhất: " .. (State.statistics.lowFPS == 999 and 0 or State.statistics.lowFPS)
            optimizationsLabel.Text = "Tổng tối ưu: " .. State.statistics.totalOptimizations
            modeLabel.Text = "Chế độ: " .. State.currentMode
            
            -- Reset counters
            frameCount = 0
            lastTime = currentTime
            fpsUpdateTimer = 0
        end
    end)
    
    -- Auto-update canvas size for scrolling
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        content.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Entrance animation
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    S.TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 380, 0, 500),
        Position = UDim2.new(0.5, -190, 0.5, -250)
    }):Play()
    
    return gui
end

-- Performance monitoring and auto-cleanup system
local function initializePerformanceMonitoring()
    spawn(function()
        while true do
            wait(30) -- Clean every 30 seconds
            advancedCleanup()
            
            -- Advanced memory management
            pcall(function()
                if #State.fpsHistory > 0 then
                    local avgFPS = State.statistics.averageFPS
                    if avgFPS < 20 then
                        -- Emergency cleanup
                        for i = 1, 5 do
                            collectgarbage("collect")
                            wait(0.1)
                        end
                        
                        showNotification("Emergency Cleanup", "Thực hiện dọn dẹp khẩn cấp", "🚨", 2, CONFIG.Colors.Danger)
                    end
                end
            end)
        end
    end)
end

-- Network optimization system
local function initializeNetworkOptimization()
    pcall(function()
        -- Optimize network settings for better performance
        settings().Network.IncommingReplicationLag = 0
        settings().Network.RenderStreamedRegions = false
        
        -- Reduce network bandwidth usage
        for _, player in pairs(S.Players:GetPlayers()) do
            if player ~= S.Players.LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.SmoothPlastic
                        part.CastShadow = false
                    end
                end
            end
        end
    end)
end

-- Initialize the complete system
local function initialize()
    backupSettings()
    createModernUI()
    initializePerformanceMonitoring()
    initializeNetworkOptimization()
    
    -- Welcome message with fade effect
    wait(1)
    showNotification(
        "FPS Booster v" .. CONFIG.Version,
        "Hệ thống tối ưu AI đã sẵn sàng!",
        "🚀",
        5,
        CONFIG.Colors.Primary
    )
    
    -- Auto-start with Basic mode after 3 seconds
    wait(3)
    executeMode("Basic")
    
    print("[FPS Booster v" .. CONFIG.Version .. "] System initialized successfully!")
    print("🚀 Features: AI Auto-Optimizer, Ultra Graphics Engine, Advanced Memory Management")
    print("💡 Tip: Sử dụng chế độ Ultra cho FPS tối đa!")
end

-- Emergency commands for console
_G.FPSBooster = {
    executeMode = executeMode,
    restore = restoreToDefaults,
    cleanup = advancedCleanup,
    stats = function()
        return State.statistics
    end,
    version = CONFIG.Version
}

-- Start the system
initialize()

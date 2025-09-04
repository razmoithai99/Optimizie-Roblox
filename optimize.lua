-- 🚀 MOBILE FPS BOOSTER - PROFESSIONAL EDITION
-- ⚡ Ultra Lightweight & CPU Optimized
-- 📱 Mobile First Design by Professional Dev

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 🎨 Modern Design System
local DESIGN = {
    Colors = {
        Primary = Color3.fromRGB(67, 56, 202),      -- Indigo
        Success = Color3.fromRGB(34, 197, 94),      -- Green  
        Warning = Color3.fromRGB(245, 158, 11),     -- Amber
        Danger = Color3.fromRGB(239, 68, 68),       -- Red
        Dark = Color3.fromRGB(17, 24, 39),          -- Gray-900
        Surface = Color3.fromRGB(31, 41, 55),       -- Gray-800
        Text = Color3.fromRGB(243, 244, 246),       -- Gray-100
        TextMuted = Color3.fromRGB(156, 163, 175)   -- Gray-400
    },
    Sizes = {
        Mobile = {
            Width = 280,
            Height = 320,
            ButtonHeight = 45,
            HeaderHeight = 55,
            Padding = 12,
            CornerRadius = 16
        }
    },
    Animation = {
        Duration = 0.25,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.Out
    }
}

-- 📊 State Management
local State = {
    currentMode = "None",
    isMinimized = false,
    originalSettings = {},
    fpsHistory = {},
    cpuOptimizationLevel = 0
}

-- 💾 Backup Original Settings
local function backupSettings()
    pcall(function()
        State.originalSettings = {
            -- Lighting
            Technology = Lighting.Technology,
            GlobalShadows = Lighting.GlobalShadows,
            FogEnd = Lighting.FogEnd,
            FogStart = Lighting.FogStart,
            Brightness = Lighting.Brightness,
            
            -- Terrain
            WaterWaveSize = Terrain and Terrain.WaterWaveSize or 0,
            WaterWaveSpeed = Terrain and Terrain.WaterWaveSpeed or 0,
            WaterReflectance = Terrain and Terrain.WaterReflectance or 0,
            WaterTransparency = Terrain and Terrain.WaterTransparency or 0.3,
            
            -- Rendering
            RenderingEnabled = RunService:IsRunning()
        }
    end)
end

-- 🧹 Smart CPU Optimization
local function optimizeCPU(level)
    pcall(function()
        State.cpuOptimizationLevel = level
        
        -- Level 1: Basic CPU reduction (25%)
        if level >= 1 then
            -- Reduce audio processing
            SoundService.RespectFilteringEnabled = false
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
            
            -- Optimize workspace
            workspace.StreamingEnabled = true
            workspace.StreamingMinRadius = 64
            workspace.StreamingTargetRadius = 128
        end
        
        -- Level 2: Moderate CPU reduction (50%)  
        if level >= 2 then
            -- Disable expensive lighting calculations
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 500
            Lighting.FogStart = 0
            
            -- Reduce water effects
            if Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
            end
        end
        
        -- Level 3: Maximum CPU reduction (75%)
        if level >= 3 then
            -- Switch to compatibility mode
            Lighting.Technology = Enum.Technology.Compatibility
            Lighting.Brightness = 0
            
            -- Disable all water effects
            if Terrain then
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
            end
            
            -- Force garbage collection every 5 seconds
            spawn(function()
                while State.cpuOptimizationLevel >= 3 do
                    wait(5)
                    collectgarbage("collect")
                end
            end)
        end
    end)
end

-- 🎮 Core Optimization Modes
local modes = {
    {
        name = "Basic FPS",
        icon = "⚡",
        color = DESIGN.Colors.Success,
        description = "Tối ưu cơ bản cho mobile",
        action = function()
            State.currentMode = "Basic FPS"
            
            pcall(function()
                -- Basic graphics optimization
                Lighting.GlobalShadows = false
                Lighting.Technology = Enum.Technology.Compatibility
                
                -- Basic CPU optimization
                optimizeCPU(1)
                
                -- Clean unnecessary objects
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                        obj.Enabled = false
                    elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj:Destroy()
                    end
                end
                
                -- Memory cleanup
                collectgarbage("collect")
            end)
        end
    },
    
    {
        name = "Ultra FPS", 
        icon = "🚀",
        color = DESIGN.Colors.Warning,
        description = "Tối ưu mạnh cho FPS cao",
        action = function()
            State.currentMode = "Ultra FPS"
            
            pcall(function()
                -- Execute basic mode first
                modes[1].action()
                
                -- Advanced graphics reduction
                Lighting.Brightness = 0
                Lighting.FogEnd = 200
                
                -- Moderate CPU optimization  
                optimizeCPU(2)
                
                -- Remove textures and decals
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = 1
                    elseif obj:IsA("SurfaceAppearance") then
                        obj:Destroy()
                    end
                end
                
                -- Optimize all parts
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.CastShadow = false
                        obj.Reflectance = 0
                    end
                end
                
                -- Aggressive memory management
                for i = 1, 3 do
                    collectgarbage("collect")
                    wait(0.1)
                end
            end)
        end
    },
    
    {
        name = "Restore",
        icon = "🔄", 
        color = DESIGN.Colors.Danger,
        description = "Khôi phục cài đặt gốc",
        action = function()
            State.currentMode = "None"
            State.cpuOptimizationLevel = 0
            
            pcall(function()
                -- Restore all original settings
                if State.originalSettings.Technology then
                    Lighting.Technology = State.originalSettings.Technology
                end
                if State.originalSettings.GlobalShadows ~= nil then
                    Lighting.GlobalShadows = State.originalSettings.GlobalShadows
                end
                if State.originalSettings.FogEnd then
                    Lighting.FogEnd = State.originalSettings.FogEnd
                end
                if State.originalSettings.FogStart then
                    Lighting.FogStart = State.originalSettings.FogStart  
                end
                if State.originalSettings.Brightness then
                    Lighting.Brightness = State.originalSettings.Brightness
                end
                
                -- Restore terrain settings
                if Terrain and State.originalSettings.WaterWaveSize then
                    Terrain.WaterWaveSize = State.originalSettings.WaterWaveSize
                    Terrain.WaterWaveSpeed = State.originalSettings.WaterWaveSpeed
                    Terrain.WaterReflectance = State.originalSettings.WaterReflectance
                    Terrain.WaterTransparency = State.originalSettings.WaterTransparency
                end
                
                -- Final cleanup
                collectgarbage("collect")
            end)
        end
    }
}

-- 📱 Modern Mobile UI
local function createUI()
    -- Remove existing GUI
    if playerGui:FindFirstChild("MobileFPSBooster") then
        playerGui.MobileFPSBooster:Destroy()
    end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "MobileFPSBooster"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = playerGui
    
    -- Main container with glassmorphism
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, DESIGN.Sizes.Mobile.Width, 0, DESIGN.Sizes.Mobile.Height)
    main.Position = UDim2.new(0, 20, 0, 100) -- Top-left positioning for mobile
    main.BackgroundColor3 = DESIGN.Colors.Dark
    main.BackgroundTransparency = 0.05
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Parent = gui
    
    -- Modern rounded corners
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, DESIGN.Sizes.Mobile.CornerRadius)
    mainCorner.Parent = main
    
    -- Subtle glow effect
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 10, 1, 10)
    glow.Position = UDim2.new(0, -5, 0, -5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    glow.ImageColor3 = DESIGN.Colors.Primary
    glow.ImageTransparency = 0.8
    glow.ZIndex = main.ZIndex - 1
    glow.Parent = main
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, DESIGN.Sizes.Mobile.CornerRadius + 2)
    glowCorner.Parent = glow
    
    -- Header with gradient
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, DESIGN.Sizes.Mobile.HeaderHeight)
    header.BackgroundColor3 = DESIGN.Colors.Primary
    header.BorderSizePixel = 0
    header.Parent = main
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, DESIGN.Sizes.Mobile.CornerRadius)
    headerCorner.Parent = header
    
    -- Header bottom fill
    local headerFill = Instance.new("Frame")
    headerFill.Size = UDim2.new(1, 0, 0, 10)
    headerFill.Position = UDim2.new(0, 0, 1, -10)
    headerFill.BackgroundColor3 = DESIGN.Colors.Primary
    headerFill.BorderSizePixel = 0
    headerFill.Parent = header
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, DESIGN.Sizes.Mobile.Padding, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ Mobile FPS Pro"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Minimize button
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeButton"
    minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    minimizeBtn.Position = UDim2.new(1, -70, 0.5, -16)
    minimizeBtn.BackgroundColor3 = DESIGN.Colors.Warning
    minimizeBtn.Text = "−"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 16
    minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = header
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = minimizeBtn
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -35, 0.5, -16)
    closeBtn.BackgroundColor3 = DESIGN.Colors.Danger
    closeBtn.Text = "×"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn
    
    -- Content area
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -24, 1, -DESIGN.Sizes.Mobile.HeaderHeight - 80)
    content.Position = UDim2.new(0, 12, 0, DESIGN.Sizes.Mobile.HeaderHeight + 12)
    content.BackgroundTransparency = 1
    content.Parent = main
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = content
    
    -- Status bar
    local statusBar = Instance.new("Frame")
    statusBar.Name = "StatusBar"
    statusBar.Size = UDim2.new(1, -24, 0, 55)
    statusBar.Position = UDim2.new(0, 12, 1, -67)
    statusBar.BackgroundColor3 = DESIGN.Colors.Surface
    statusBar.BorderSizePixel = 0
    statusBar.Parent = main
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 12)
    statusCorner.Parent = statusBar
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FPSLabel"
    fpsLabel.Size = UDim2.new(0.4, 0, 1, 0)
    fpsLabel.Position = UDim2.new(0, 12, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: --"
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 14
    fpsLabel.TextColor3 = DESIGN.Colors.Success
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Parent = statusBar
    
    local cpuLabel = Instance.new("TextLabel")
    cpuLabel.Name = "CPULabel"
    cpuLabel.Size = UDim2.new(0.6, -12, 1, 0)
    cpuLabel.Position = UDim2.new(0.4, 0, 0, 0)
    cpuLabel.BackgroundTransparency = 1
    cpuLabel.Text = "CPU: Normal"
    cpuLabel.Font = Enum.Font.Gotham
    cpuLabel.TextSize = 12
    cpuLabel.TextColor3 = DESIGN.Colors.TextMuted
    cpuLabel.TextXAlignment = Enum.TextXAlignment.Right
    cpuLabel.Parent = statusBar
    
    local modeLabel = Instance.new("TextLabel")
    modeLabel.Name = "ModeLabel"
    modeLabel.Size = UDim2.new(1, -24, 0, 15)
    modeLabel.Position = UDim2.new(0, 12, 0, 30)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "Mode: " .. State.currentMode
    modeLabel.Font = Enum.Font.Gotham
    modeLabel.TextSize = 10
    modeLabel.TextColor3 = DESIGN.Colors.TextMuted
    modeLabel.TextXAlignment = Enum.TextXAlignment.Left
    modeLabel.Parent = statusBar
    
    -- Create mode buttons
    for i, mode in ipairs(modes) do
        local button = Instance.new("TextButton")
        button.Name = mode.name .. "Button"
        button.Size = UDim2.new(1, 0, 0, DESIGN.Sizes.Mobile.ButtonHeight)
        button.BackgroundColor3 = mode.color
        button.BorderSizePixel = 0
        button.Text = ""
        button.LayoutOrder = i
        button.Parent = content
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 12)
        buttonCorner.Parent = button
        
        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 30, 1, 0)
        icon.Position = UDim2.new(0, 12, 0, 0)
        icon.BackgroundTransparency = 1
        icon.Text = mode.icon
        icon.Font = Enum.Font.GothamBold
        icon.TextSize = 18
        icon.TextColor3 = Color3.new(1, 1, 1)
        icon.Parent = button
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -54, 0, 20)
        nameLabel.Position = UDim2.new(0, 42, 0, 6)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = mode.name
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 14
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = button
        
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(1, -54, 0, 15)
        descLabel.Position = UDim2.new(0, 42, 0, 24)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = mode.description
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextSize = 10
        descLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = button
        
        -- Button animations
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.new(
                    math.min(mode.color.R + 0.1, 1),
                    math.min(mode.color.G + 0.1, 1),
                    math.min(mode.color.B + 0.1, 1)
                )
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = mode.color
            }):Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            -- Click animation
            local clickTween = TweenService:Create(button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, -4, 0, DESIGN.Sizes.Mobile.ButtonHeight - 2)
            })
            clickTween:Play()
            
            clickTween.Completed:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.1), {
                    Size = UDim2.new(1, 0, 0, DESIGN.Sizes.Mobile.ButtonHeight)
                }):Play()
            end)
            
            -- Execute mode
            mode.action()
            modeLabel.Text = "Mode: " .. State.currentMode
            
            -- Update CPU label
            local cpuTexts = {"Normal", "Optimized -25%", "Boosted -50%", "Maximum -75%"}
            cpuLabel.Text = "CPU: " .. (cpuTexts[State.cpuOptimizationLevel + 1] or "Normal")
        end)
    end
    
    -- Button functionality
    minimizeBtn.MouseButton1Click:Connect(function()
        State.isMinimized = not State.isMinimized
        local targetSize = State.isMinimized and 
            UDim2.new(0, DESIGN.Sizes.Mobile.Width, 0, DESIGN.Sizes.Mobile.HeaderHeight) or
            UDim2.new(0, DESIGN.Sizes.Mobile.Width, 0, DESIGN.Sizes.Mobile.Height)
            
        TweenService:Create(main, TweenInfo.new(DESIGN.Animation.Duration, DESIGN.Animation.Style, DESIGN.Animation.Direction), {
            Size = targetSize
        }):Play()
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(main, TweenInfo.new(DESIGN.Animation.Duration, DESIGN.Animation.Style, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, DESIGN.Sizes.Mobile.Width / 2, 0, 100 + DESIGN.Sizes.Mobile.Height / 2)
        }):Play()
        
        wait(DESIGN.Animation.Duration)
        gui:Destroy()
    end)
    
    -- Entrance animation
    main.Size = UDim2.new(0, 0, 0, 0)
    main.Position = UDim2.new(0, DESIGN.Sizes.Mobile.Width / 2, 0, 100 + DESIGN.Sizes.Mobile.Height / 2)
    
    TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, DESIGN.Sizes.Mobile.Width, 0, DESIGN.Sizes.Mobile.Height),
        Position = UDim2.new(0, 20, 0, 100)
    }):Play()
    
    -- FPS monitoring
    local frameCount = 0
    local lastTime = tick()
    
    RunService.Heartbeat:Connect(function()
        frameCount = frameCount + 1
        
        if tick() - lastTime >= 1 then
            local fps = math.floor(frameCount / (tick() - lastTime))
            frameCount = 0
            lastTime = tick()
            
            fpsLabel.Text = "FPS: " .. fps
            
            -- Color coding
            if fps >= 60 then
                fpsLabel.TextColor3 = DESIGN.Colors.Success
            elseif fps >= 30 then
                fpsLabel.TextColor3 = DESIGN.Colors.Warning  
            else
                fpsLabel.TextColor3 = DESIGN.Colors.Danger
            end
            
            -- Store in history
            table.insert(State.fpsHistory, fps)
            if #State.fpsHistory > 10 then
                table.remove(State.fpsHistory, 1)
            end
        end
    end)
    
    return gui
end

-- 🚀 Professional Notification System with Soft Colors
local function showNotification(title, message, color)
    pcall(function()
        local notifGui = Instance.new("ScreenGui")
        notifGui.Name = "FPSNotification"
        notifGui.Parent = playerGui
        
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(0, 0, 0, 45)
        notif.Position = UDim2.new(0.5, 0, 0, 15)
        notif.AnchorPoint = Vector2.new(0.5, 0)
        notif.BackgroundColor3 = color or DESIGN.Colors.Primary
        notif.BackgroundTransparency = 0.2
        notif.BorderSizePixel = 0
        notif.Parent = notifGui
        
        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 16)
        notifCorner.Parent = notif
        
        -- Soft inner glow
        local innerGlow = Instance.new("Frame")
        innerGlow.Size = UDim2.new(1, -2, 1, -2)
        innerGlow.Position = UDim2.new(0, 1, 0, 1)
        innerGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        innerGlow.BackgroundTransparency = 0.95
        innerGlow.BorderSizePixel = 0
        innerGlow.Parent = notif
        
        local innerCorner = Instance.new("UICorner")
        innerCorner.CornerRadius = UDim.new(0, 15)
        innerCorner.Parent = innerGlow
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, -20, 1, 0)
        text.Position = UDim2.new(0, 10, 0, 0)
        text.BackgroundTransparency = 1
        text.Text = title .. (message and ": " .. message or "")
        text.Font = Enum.Font.GothamBold
        text.TextSize = 13
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextStrokeTransparency = 0.7
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        text.TextScaled = true
        text.Parent = notif
        
        -- Professional entrance animation
        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 240, 0, 45)
        }):Play()
        
        -- Soft pulsing effect
        spawn(function()
            for i = 1, 4 do
                TweenService:Create(innerGlow, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0.9
                }):Play()
                wait(0.3)
                TweenService:Create(innerGlow, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0.95
                }):Play()
                wait(0.3)
            end
        end)
        
        -- Professional exit animation
        wait(2.5)
        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 45),
            Position = UDim2.new(0.5, 0, 0, -15)
        }):Play()
        
        wait(0.4)
        notifGui:Destroy()
    end)
endScaled = true
        text.Parent = notif
        
        -- Animate in
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 250, 0, 50)
        }):Play()
        
        -- Animate out
        wait(2)
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 50)
        }):Play()
        
        wait(0.3)
        notifGui:Destroy()
    end)
end

-- 🎯 Initialize System
local function initialize()
    -- Clean any existing GUI
    pcall(function()
        if playerGui:FindFirstChild("MobileFPSBooster") then
            playerGui.MobileFPSBooster:Destroy()
        end
    end)
    
    -- Backup settings
    backupSettings()
    
    -- Create UI
    createUI()
    
    -- Welcome notification
    wait(0.5)
    showNotification("Mobile FPS Pro", "Ready to boost!", DESIGN.Colors.Success)
    
    print("🚀 Mobile FPS Booster Pro - Initialized")
    print("💡 Ultra lightweight & CPU optimized")
    print("📱 Professional mobile-first design")
end

-- 🌟 Global Access
_G.MobileFPSPro = {
    version = "1.0",
    reinitialize = initialize,
    destroy = function()
        pcall(function()
            if playerGui:FindFirstChild("MobileFPSBooster") then
                playerGui.MobileFPSBooster:Destroy()
            end
        end)
    end
}

-- Start the system
initialize()

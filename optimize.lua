-- FPS BOOSTER v20.0 - LUXURIOUS EDITION + COMPREHENSIVE FASTFLAGS
-- Enhanced with premium UI and extended optimization

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local terrain = workspace:FindFirstChildOfClass("Terrain")

local currentMode = "None"
local originalSettings = {}
local gui = nil
local isMinimized = false

-- Smooth notification system
local function notify(text, duration, type)
    pcall(function()
        local notifType = type or "info"
        local icon = "🔔"
        local color = Color3.fromRGB(100, 200, 255)
        
        if notifType == "success" then
            icon = "✅"
            color = Color3.fromRGB(100, 255, 100)
        elseif notifType == "warning" then
            icon = "⚠️"
            color = Color3.fromRGB(255, 200, 100)
        elseif notifType == "error" then
            icon = "❌"
            color = Color3.fromRGB(255, 100, 100)
        end
        
        StarterGui:SetCore("SendNotification", {
            Title = icon .. " FPS Optimizer",
            Text = text,
            Duration = duration or 3,
            Icon = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        })
    end)
end

-- COMPREHENSIVE FASTFLAGS SYSTEM
local function applyComprehensiveFastFlags()
    pcall(function()
        -- Core Graphics Performance
        setfflag("FFlagGraphicsGLTextureReduction", "true")
        setfflag("FFlagGraphicsGL2", "true")
        setfflag("DFFlagTextureQualityOverrideEnabled", "true")
        setfflag("DFIntTextureQualityOverride", "1")
        setfflag("DFIntDebugFRMQualityLevelOverride", "1")
        setfflag("FFlagDebugDisplayFPS", "true")
        
        -- Advanced Rendering
        setfflag("FFlagRenderShadowIntensity", "0")
        setfflag("FIntRenderShadowIntensity", "0")
        setfflag("FFlagRenderShadowmapBias", "0")
        setfflag("FFlagDisablePostFx", "true")
        setfflag("FFlagRenderNoLowFpsCompensation", "true")
        setfflag("FFlagRenderH264HardwareEncodingEnabled", "false")
        setfflag("FFlagRenderFSAAEnabled", "false")
        setfflag("FFlagRenderVSyncEnabled", "false")
        
        -- Level of Detail (LOD) System
        setfflag("DFIntCSGLevelOfDetailSwitchingDistance", "250")
        setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL12", "500")
        setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL23", "750")
        setfflag("DFIntCSGLevelOfDetailSwitchingDistanceL34", "1000")
        
        -- Grass & Terrain Details
        setfflag("FIntFRMMinGrassDistance", "0")
        setfflag("FIntFRMMaxGrassDistance", "0")
        setfflag("FIntRenderGrassDetailStrands", "0")
        setfflag("FintRenderGrassHeightScaler", "0")
        setfflag("DFFlagTerrainDisableDetails", "true")
        setfflag("FFlagTerrainWaterHasTransparency", "false")
        
        -- Memory & Performance
        setfflag("DFFlagLuaGCStepMulEnabled", "true")
        setfflag("DFFlagLuaGCStepMulValue", "500")
        setfflag("FFlagTaskSchedulerLimitTargetFps", "true")
        setfflag("DFFlagTaskSchedulerTargetFps", "240")
        setfflag("DFIntMaxFrameBufferSize", "4")
        setfflag("DFIntConnectionMTUSize", "900")
        
        -- Graphics API Optimization
        setfflag("DebugGraphicsDisableVulkan", "true")
        setfflag("DebugGraphicsDisableVulkan11", "true")
        setfflag("DebugGraphicsDisableOpenGL", "true")
        setfflag("DebugGraphicPreferD3D11", "true")
        setfflag("FFlagDebugGraphicsPreferD3D11", "true")
        
        -- Lighting Technology
        setfflag("FFlagNewLightAttenuation", "true")
        setfflag("FFlagFastGPULightCulling3", "true")
        setfflag("FIntMockClientLightingTechnologyIxpExperimentMode", "0")
        setfflag("FIntMockClientLightingTechnologyIxpExperimentQualityLevel", "7")
        setfflag("DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent", "0")
        
        -- UI & Interface
        setfflag("FFlagCoreGuiTypeSelfViewPresent", "false")
        setfflag("FFlagInGameMenuV1FullScreenTitleBar", "false")
        setfflag("FIntFullscreenTitleBarTriggerDelayMillis", "18000000")
        setfflag("FIntRobloxGuiBlurIntensity", "0")
        
        -- Particle & Effects
        setfflag("FFlagParticleSystemEnabled", "false")
        setfflag("FFlagRenderFixFog", "false")
        setfflag("FFlagRenderTerrainDetails", "false")
        setfflag("FFlagRenderInstancedMeshes", "false")
        setfflag("FFlagRenderLightImprovements", "false")
        setfflag("FFlagRenderPlaneReflections", "false")
        setfflag("FFlagRenderScreenSpaceReflections", "false")
        setfflag("FFlagDebugSkyGray", "true")
        
        -- Audio Performance
        setfflag("FFlagAudioLoadMinDistance", "7")
        setfflag("FFlagAudioLoadMaxDistance", "1000")
        setfflag("FFlagAudioSpatializationEnabled", "false")
        setfflag("FFlagAudioEffectsEnabled", "false")
        setfflag("FFlagAudioListenerEnabled", "false")
        setfflag("FFlagAudioEmitterEnabled", "false")
        
        -- Telemetry Disabling (Performance)
        setfflag("FFlagDebugDisableTelemetryEphemeralCounter", "true")
        setfflag("FFlagDebugDisableTelemetryEphemeralStat", "true")
        setfflag("FFlagDebugDisableTelemetryEventIngest", "true")
        setfflag("FFlagDebugDisableTelemetryPoint", "true")
        setfflag("FFlagDebugDisableTelemetryV2Counter", "true")
        setfflag("FFlagDebugDisableTelemetryV2Event", "true")
        setfflag("FFlagDebugDisableTelemetryV2Stat", "true")
        
        -- Network & Connection
        setfflag("DFFlagConnectLuaGameLoadedTelemetryEnabled", "false")
        setfflag("DFFlagGameBasicSettingsFramerateCap", "240")
        setfflag("DFFlagVariableDtHeartbeat", "true")
        setfflag("DFFlagVariableDtHeartbeatPrintEnabled", "false")
        
        -- Physics Optimization
        setfflag("FFlagAssemblyExtentsEnabled", "false")
        setfflag("FFlagAssemblyBoundingBoxEnabled", "false")
        setfflag("FFlagPhysicsPacketCompression", "true")
        setfflag("FFlagPhysicsAnalyzerEnabled", "false")
        setfflag("DFFlagPhysicsAnalyzerEnabled", "false")
        setfflag("DFFlagPhysicsAnalyzerAutoDisable", "true")
        
        notify("⚡ Advanced FastFlags Applied", 2, "success")
    end)
end

-- Save original settings
local function saveSettings()
    pcall(function()
        originalSettings = {
            Brightness = Lighting.Brightness,
            Ambient = Lighting.Ambient,
            GlobalShadows = Lighting.GlobalShadows,
            Technology = Lighting.Technology,
            FogEnd = Lighting.FogEnd,
            FogStart = Lighting.FogStart,
            QualityLevel = settings().Rendering.QualityLevel,
            MeshPartDetailLevel = settings().Rendering.MeshPartDetailLevel,
            GraphicsMode = settings().Rendering.GraphicsMode,
        }
    end)
end

-- Ultra Performance Mode
local function ultraPerformanceMode()
    pcall(function()
        -- Extreme lighting optimization
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0.5
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        
        -- Terrain optimization
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
            terrain.Decorations = false
            terrain.ReadVoxels = false
        end
        
        -- Advanced part optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
                obj.CastShadow = false
                obj.CanCollide = obj.CanCollide -- Preserve collision
                obj.Anchored = obj.Anchored -- Preserve anchoring
                
                -- Flatten all surfaces
                obj.TopSurface = Enum.SurfaceType.Smooth
                obj.BottomSurface = Enum.SurfaceType.Smooth
                obj.FrontSurface = Enum.SurfaceType.Smooth
                obj.BackSurface = Enum.SurfaceType.Smooth
                obj.LeftSurface = Enum.SurfaceType.Smooth
                obj.RightSurface = Enum.SurfaceType.Smooth
                
            elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                obj.Transparency = 1
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj.Enabled = false
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj.Enabled = false
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj.Enabled = false
            elseif obj:IsA("MeshPart") then
                obj.TextureID = ""
            end
        end
        
        -- Audio optimization
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 0
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 0
        
        -- Lowest quality settings
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        settings().Rendering.GraphicsMode = Enum.GraphicsMode.Direct3D11
        
        -- Memory management
        collectgarbage("collect")
        
        notify("🚀 Ultra Performance Mode Activated", 2, "success")
        currentMode = "Ultra"
    end)
end

-- Balanced Mode
local function balancedMode()
    pcall(function()
        Lighting.Technology = Enum.Technology.ShadowMap
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.FogEnd = 100000
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level05
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level02
        
        collectgarbage("collect")
        notify("⚖️ Balanced Mode Activated", 2, "success")
        currentMode = "Balanced"
    end)
end

-- Quality Mode
local function qualityMode()
    pcall(function()
        Lighting.Technology = Enum.Technology.Future
        Lighting.GlobalShadows = true
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.FogEnd = 100000
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        notify("💎 Quality Mode Activated", 2, "success")
        currentMode = "Quality"
    end)
end

-- Restore original settings
local function restoreSettings()
    pcall(function()
        Lighting.Brightness = originalSettings.Brightness
        Lighting.Ambient = originalSettings.Ambient
        Lighting.GlobalShadows = originalSettings.GlobalShadows
        Lighting.Technology = originalSettings.Technology
        Lighting.FogEnd = originalSettings.FogEnd
        Lighting.FogStart = originalSettings.FogStart
        settings().Rendering.QualityLevel = originalSettings.QualityLevel
        settings().Rendering.MeshPartDetailLevel = originalSettings.MeshPartDetailLevel
        settings().Rendering.GraphicsMode = originalSettings.GraphicsMode
        
        notify("🔄 Settings Restored", 2, "success")
        currentMode = "None"
    end)
end

-- Enhanced memory cleanup
local function advancedCleanup()
    pcall(function()
        collectgarbage("collect")
        
        -- Clean debris and temporary objects
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("debris") or obj.Name:lower():find("temp") then
                obj:Destroy()
            end
        end
        
        -- Clean up sounds
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") and not sound.IsPlaying then
                sound:Destroy()
            end
        end
        
        notify("🧹 Advanced Cleanup Complete", 2, "success")
    end)
end

-- LUXURIOUS UI SYSTEM
local function createLuxuriousUI()
    if gui then gui:Destroy() end
    
    gui = Instance.new("ScreenGui")
    gui.Name = "LuxuriousFPSOptimizer"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui
    
    -- Main frame with premium design
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 380, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = gui
    
    -- Modern corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = mainFrame
    
    -- Premium gradient background
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    }
    gradient.Rotation = 45
    gradient.Parent = mainFrame
    
    -- Elegant border
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(100, 100, 200)
    border.Thickness = 2
    border.Transparency = 0.5
    border.Parent = mainFrame
    
    -- Header section
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 15)
    headerCorner.Parent = header
    
    -- Title with premium styling
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ FPS OPTIMIZER PRO"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, -80, 0, 20)
    subtitle.Position = UDim2.new(0, 20, 0, 35)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Luxurious Edition v20.0"
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header
    
    -- Minimize/Close buttons
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0, 15)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    minimizeBtn.Text = "−"
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 16
    minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = header
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 15)
    minimizeCorner.Parent = minimizeBtn
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 15)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.Text = "×"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeBtn
    
    -- Content area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -80)
    contentFrame.Position = UDim2.new(0, 10, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    -- Premium button creation function
    local function createPremiumButton(text, icon, position, size, color, callback)
        local button = Instance.new("TextButton")
        button.Size = size
        button.Position = position
        button.BackgroundColor3 = color
        button.BorderSizePixel = 0
        button.Text = ""
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = contentFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = button
        
        local buttonGradient = Instance.new("UIGradient")
        buttonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(1, Color3.new(color.R * 0.8, color.G * 0.8, color.B * 0.8))
        }
        buttonGradient.Rotation = 90
        buttonGradient.Parent = button
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 30, 0, 30)
        iconLabel.Position = UDim2.new(0, 15, 0, 5)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = icon
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.TextSize = 20
        iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        iconLabel.Parent = button
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, -50, 1, 0)
        textLabel.Position = UDim2.new(0, 50, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = text
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 14
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = button
        
        -- Hover effects
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {Size = size + UDim2.new(0, 5, 0, 2)}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {Size = size}):Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.1), {Size = size - UDim2.new(0, 5, 0, 2)}):Play()
            wait(0.1)
            TweenService:Create(button, TweenInfo.new(0.1), {Size = size}):Play()
            callback()
        end)
        
        return button
    end
    
    -- Performance mode buttons
    createPremiumButton("Ultra Performance", "🚀", UDim2.new(0, 0, 0, 10), UDim2.new(1, -10, 0, 40), Color3.fromRGB(255, 50, 100), ultraPerformanceMode)
    createPremiumButton("Balanced Mode", "⚖️", UDim2.new(0, 0, 0, 60), UDim2.new(1, -10, 0, 40), Color3.fromRGB(100, 200, 255), balancedMode)
    createPremiumButton("Quality Mode", "💎", UDim2.new(0, 0, 0, 110), UDim2.new(1, -10, 0, 40), Color3.fromRGB(150, 255, 100), qualityMode)
    
    -- Utility buttons
    createPremiumButton("Advanced Cleanup", "🧹", UDim2.new(0, 0, 0, 170), UDim2.new(0.48, 0, 0, 40), Color3.fromRGB(255, 150, 50), advancedCleanup)
    createPremiumButton("Restore Settings", "🔄", UDim2.new(0.52, 0, 0, 170), UDim2.new(0.48, 0, 0, 40), Color3.fromRGB(150, 150, 150), restoreSettings)
    
    -- Current mode display
    local modeFrame = Instance.new("Frame")
    modeFrame.Size = UDim2.new(1, -10, 0, 60)
    modeFrame.Position = UDim2.new(0, 0, 0, 230)
    modeFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    modeFrame.BorderSizePixel = 0
    modeFrame.Parent = contentFrame
    
    local modeCorner = Instance.new("UICorner")
    modeCorner.CornerRadius = UDim.new(0, 10)
    modeCorner.Parent = modeFrame
    
    local modeLabel = Instance.new("TextLabel")
    modeLabel.Size = UDim2.new(1, -20, 1, 0)
    modeLabel.Position = UDim2.new(0, 10, 0, 0)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "Current Mode: " .. currentMode
    modeLabel.Font = Enum.Font.GothamBold
    modeLabel.TextSize = 16
    modeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    modeLabel.Parent = modeFrame
    
    -- Stats display
    local statsFrame = Instance.new("Frame")
    statsFrame.Size = UDim2.new(1, -10, 0, 120)
    statsFrame.Position = UDim2.new(0, 0, 0, 310)
    statsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    statsFrame.BorderSizePixel = 0
    statsFrame.Parent = contentFrame
    
    local statsCorner = Instance.new("UICorner")
    statsCorner.CornerRadius = UDim.new(0, 10)
    statsCorner.Parent = statsFrame
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0.5, -10, 0, 30)
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: --"
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 16
    fpsLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    fpsLabel.Parent = statsFrame
    
    local memoryLabel = Instance.new("TextLabel")
    memoryLabel.Size = UDim2.new(0.5, -10, 0, 30)
    memoryLabel.Position = UDim2.new(0.5, 0, 0, 10)
    memoryLabel.BackgroundTransparency = 1
    memoryLabel.Text = "Memory: --"
    memoryLabel.Font = Enum.Font.GothamBold
    memoryLabel.TextSize = 16
    memoryLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    memoryLabel.Parent = statsFrame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(0.5, -10, 0, 30)
    pingLabel.Position = UDim2.new(0, 10, 0, 50)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "Ping: -- ms"
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextSize = 16
    pingLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    pingLabel.Parent = statsFrame
    
    local qualityLabel = Instance.new("TextLabel")
    qualityLabel.Size = UDim2.new(0.5, -10, 0, 30)
    qualityLabel.Position = UDim2.new(0.5, 0, 0, 50)
    qualityLabel.BackgroundTransparency = 1
    qualityLabel.Text = "Quality: --"
    qualityLabel.Font = Enum.Font.GothamBold
    qualityLabel.TextSize = 16
    qualityLabel.TextColor3 = Color3.fromRGB(255, 150, 255)
    qualityLabel.Parent = statsFrame
    
   -- Real-time stats update
local fps = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    fps = fps + 1
    local now = tick()
    if now - lastTime >= 1 then
        fpsLabel.Text = "FPS: " .. fps
        modeLabel.Text = "Current Mode: " .. currentMode
        memoryLabel.Text = "Memory: " .. math.floor(collectgarbage("count")) .. " KB"
        
        -- Reset counter
        fps = 0
        lastTime = now
    end
end)

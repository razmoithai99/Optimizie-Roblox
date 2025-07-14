-- FPS BOOSTER v19.0 - ULTRA COMPACT + MAXIMUM FASTFLAGS

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local terrain = workspace:FindFirstChildOfClass("Terrain")

local currentMode = "None"
local originalSettings = {}
local gui = nil

-- Notification
local function notify(text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "FPS",
            Text = text,
            Duration = duration or 2
        })
    end)
end

-- MAXIMUM FASTFLAGS (Like YouTubers use)
local function applyMaxFastFlags()
    pcall(function()
        -- Graphics Performance
        setfflag("FFlagGraphicsGLTextureReduction", "true")
        setfflag("FFlagGraphicsGL2", "true")
        setfflag("DFFlagTextureQualityOverrideEnabled", "true")
        setfflag("DFFlagTextureQualityOverrideValue", "1")
        setfflag("FFlagRenderShadowIntensity", "0")
        setfflag("FFlagRenderShadowmapBias", "0")
        setfflag("DFFlagDebugRenderForceTechnologyVoxel", "false")
        setfflag("DFFlagDebugGraphicsDisableMetal", "true")
        setfflag("DFFlagDebugGraphicsPreferVulkan", "false")
        setfflag("FFlagDebugGraphicsPreferD3D11", "false")
        setfflag("FFlagDebugGraphicsPreferOpenGL", "true")
        
        -- Memory & Performance
        setfflag("DFFlagLuaGCStepMulEnabled", "true")
        setfflag("DFFlagLuaGCStepMulValue", "400")
        setfflag("FFlagLuaDebuggerBreakOnError", "false")
        setfflag("DFFlagPhysicsAnalyzerEnabled", "false")
        setfflag("DFFlagPhysicsAnalyzerAutoDisable", "true")
        setfflag("FFlagTaskSchedulerLimitTargetFps", "true")
        setfflag("DFFlagTaskSchedulerTargetFps", "240")
        
        -- Rendering Optimization
        setfflag("FFlagRenderNoLowFpsCompensation", "true")
        setfflag("FFlagRenderH264HardwareEncodingEnabled", "false")
        setfflag("FFlagRenderFSAAEnabled", "false")
        setfflag("FFlagRenderVSyncEnabled", "false")
        setfflag("FFlagRenderDebugCheckRenderView", "false")
        setfflag("FFlagRenderDebugCullEverything", "false")
        setfflag("FFlagRenderOptimizeBufferUpdates", "true")
        
        -- Particle & Effects
        setfflag("FFlagParticleSystemEnabled", "false")
        setfflag("FFlagRenderFixFog", "false")
        setfflag("FFlagRenderTerrainDetails", "false")
        setfflag("FFlagRenderInstancedMeshes", "false")
        setfflag("FFlagRenderLightImprovements", "false")
        setfflag("FFlagRenderPlaneReflections", "false")
        setfflag("FFlagRenderScreenSpaceReflections", "false")
        
        -- Audio Performance
        setfflag("FFlagAudioLoadMinDistance", "7")
        setfflag("FFlagAudioLoadMaxDistance", "1000")
        setfflag("FFlagAudioSpatializationEnabled", "false")
        setfflag("FFlagAudioEffectsEnabled", "false")
        setfflag("FFlagAudioListenerEnabled", "false")
        setfflag("FFlagAudioEmitterEnabled", "false")
        
        -- Network & Connection
        setfflag("DFFlagConnectLuaGameLoadedTelemetryEnabled", "false")
        setfflag("DFFlagGameBasicSettingsFramerateCap", "240")
        setfflag("DFFlagVariableDtHeartbeat", "true")
        setfflag("DFFlagVariableDtHeartbeatPrintEnabled", "false")
        
        -- UI & Interface
        setfflag("FFlagGuiInsetsBoundsByParent", "false")
        setfflag("FFlagGuiTextBounds", "false")
        setfflag("FFlagGuiObjectBounds", "false")
        setfflag("FFlagStudioEnableGameAnimationsTab", "false")
        
        -- Camera & Movement
        setfflag("FFlagUserCameraToggle", "false")
        setfflag("FFlagUserRotateCamera", "false")
        setfflag("FFlagUserPanCamera", "false")
        setfflag("FFlagUserZoomCamera", "false")
        
        -- Terrain & Environment
        setfflag("FFlagTerrainTools", "false")
        setfflag("FFlagTerrainHasDefaultMaterial", "false")
        setfflag("DFFlagTerrainDisableDetails", "true")
        setfflag("FFlagTerrainWaterHasTransparency", "false")
        
        -- Physics
        setfflag("FFlagAssemblyExtentsEnabled", "false")
        setfflag("FFlagAssemblyBoundingBoxEnabled", "false")
        setfflag("FFlagPhysicsPacketCompression", "true")
        setfflag("FFlagPhysicsAnalyzerEnabled", "false")
        
        notify("✅ MAX FLAGS", 1)
    end)
end

-- Save settings
local function saveSettings()
    pcall(function()
        originalSettings = {
            Brightness = Lighting.Brightness,
            Ambient = Lighting.Ambient,
            GlobalShadows = Lighting.GlobalShadows,
            Technology = Lighting.Technology,
            FogEnd = Lighting.FogEnd,
            QualityLevel = settings().Rendering.QualityLevel,
            MeshPartDetailLevel = settings().Rendering.MeshPartDetailLevel,
        }
    end)
end

-- Ultra minimal graphics
local function ultraMinimal()
    pcall(function()
        -- Extreme lighting
        Lighting.Technology = Enum.Technology.Legacy
        Lighting.GlobalShadows = false
        Lighting.Brightness = 0
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.FogEnd = 9e9
        
        -- Terrain
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
            terrain.Decorations = false
        end
        
        -- Everything flat & simple
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= player.Character then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
                obj.CastShadow = false
                obj.Color = Color3.fromRGB(128, 128, 128)
                obj.Transparency = math.min(obj.Transparency + 0.2, 0.8)
                
                -- Flat surfaces
                obj.TopSurface = Enum.SurfaceType.Smooth
                obj.BottomSurface = Enum.SurfaceType.Smooth
                obj.FrontSurface = Enum.SurfaceType.Smooth
                obj.BackSurface = Enum.SurfaceType.Smooth
                obj.LeftSurface = Enum.SurfaceType.Smooth
                obj.RightSurface = Enum.SurfaceType.Smooth
            elseif obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj:Destroy()
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj:Destroy()
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            elseif obj:IsA("MeshPart") then
                obj.TextureID = ""
            end
        end
        
        -- Remove accessories
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _, item in pairs(p.Character:GetChildren()) do
                    if item:IsA("Accessory") or item:IsA("Hat") then
                        item:Destroy()
                    elseif item:IsA("Shirt") or item:IsA("Pants") or item:IsA("ShirtGraphic") then
                        item:Destroy()
                    end
                end
            end
        end
        
        -- Audio off
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 0
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 0
        
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") then
                sound:Stop()
                sound.Volume = 0
            end
        end
        
        -- Lowest quality
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        
        -- Memory
        collectgarbage("collect")
        
        notify("⚡ ULTRA", 1)
        currentMode = "Ultra"
    end)
end

-- Restore
local function restore()
    pcall(function()
        Lighting.Brightness = originalSettings.Brightness
        Lighting.Ambient = originalSettings.Ambient
        Lighting.GlobalShadows = originalSettings.GlobalShadows
        Lighting.Technology = originalSettings.Technology
        Lighting.FogEnd = originalSettings.FogEnd
        settings().Rendering.QualityLevel = originalSettings.QualityLevel
        settings().Rendering.MeshPartDetailLevel = originalSettings.MeshPartDetailLevel
        
        notify("🔄 RESTORE", 1)
        currentMode = "None"
    end)
end

-- Memory cleanup
local function cleanup()
    pcall(function()
        collectgarbage("collect")
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("debris") then
                obj:Destroy()
            end
        end
        notify("🧹 CLEAN", 1)
    end)
end

-- ULTRA COMPACT UI
local function createCompactUI()
    if gui then gui:Destroy() end
    
    gui = Instance.new("ScreenGui")
    gui.Name = "FPSBoost"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui
    
    -- Main frame - super compact
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 160, 0, 140)
    frame.Position = UDim2.new(0, 5, 0.5, -70)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    
    -- No rounded corners - flat like YouTubers
    
    -- Header - minimal
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    header.BorderSizePixel = 0
    header.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ FPS"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 12
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Close button - flat
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 20, 0, 20)
    close.Position = UDim2.new(1, -22, 0, 2)
    close.Text = "×"
    close.Font = Enum.Font.SourceSansBold
    close.TextSize = 14
    close.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    close.TextColor3 = Color3.new(1, 1, 1)
    close.BorderSizePixel = 0
    close.Parent = header
    
    -- Button function - flat design
    local function btn(text, y, color, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -6, 0, 22)
        b.Position = UDim2.new(0, 3, 0, y)
        b.Text = text
        b.Font = Enum.Font.SourceSansBold
        b.TextSize = 11
        b.TextColor3 = Color3.new(1, 1, 1)
        b.BackgroundColor3 = color
        b.BorderSizePixel = 0
        b.Parent = frame
        
        b.MouseButton1Click:Connect(function()
            b.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
            wait(0.05)
            b.BackgroundColor3 = color
            callback()
        end)
    end
    
    -- Compact buttons
    btn("⚡ ULTRA", 30, Color3.fromRGB(150, 30, 200), ultraMinimal)
    btn("🧹 CLEAN", 57, Color3.fromRGB(30, 150, 200), cleanup)
    btn("🔄 RESTORE", 84, Color3.fromRGB(100, 100, 100), restore)
    
    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
end

-- FPS Counter - minimal
local function createFPSCounter()
    local fpsGui = Instance.new("ScreenGui")
    fpsGui.Name = "FPS"
    fpsGui.ResetOnSpawn = false
    fpsGui.Parent = player.PlayerGui
    
    local fpsFrame = Instance.new("Frame")
    fpsFrame.Size = UDim2.new(0, 80, 0, 30)
    fpsFrame.Position = UDim2.new(1, -85, 0, 5)
    fpsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    fpsFrame.BackgroundTransparency = 0.3
    fpsFrame.BorderSizePixel = 0
    fpsFrame.Parent = fpsGui
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, 0, 0, 18)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: --"
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextSize = 12
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.Parent = fpsFrame
    
    local modeLabel = Instance.new("TextLabel")
    modeLabel.Size = UDim2.new(1, 0, 0, 12)
    modeLabel.Position = UDim2.new(0, 0, 0, 18)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "None"
    modeLabel.Font = Enum.Font.SourceSans
    modeLabel.TextSize = 10
    modeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    modeLabel.Parent = fpsFrame
    
    -- FPS calc
    local fps = 0
    local lastTime = tick()
    
    RunService.RenderStepped:Connect(function()
        fps = fps + 1
        local now = tick()
        if now - lastTime >= 1 then
            fpsLabel.Text = "FPS: " .. fps
            modeLabel.Text = currentMode
            
            if fps >= 50 then
                fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            elseif fps >= 30 then
                fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
            
            fps = 0
            lastTime = now
        end
    end)
end

-- Init
saveSettings()
applyMaxFastFlags()
createCompactUI()
createFPSCounter()

-- Auto cleanup
spawn(function()
    while true do
        wait(30)
        cleanup()
    end
end)

notify("⚡ READY", 2)

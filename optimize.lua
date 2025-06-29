-- [==[ FPS BOOSTER v10.10 – EXTREME EXPANDED EDITION ]==]
-- Gộp mọi tối ưu: FlagStyle, FastFlag Presets, DeepOptimizer, World BestPractices,
-- IdleThrottle, FPSCounter, Telemetry OFF, thêm benchmark và SuperBoost.

local Services = {
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    RunService = game:GetService("RunService"),
    SoundService = game:GetService("SoundService"),
    StarterGui = game:GetService("StarterGui"),
    Chat = game:FindService("Chat"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService")
}
local player = Services.Players.LocalPlayer

-- Variables
local frameCount = 0
local fpsHistory = {}
local idleTime = 0
local lastPos = nil
local minimized = false
local benchmarkBefore, benchmarkAfter = nil, nil

-- FastFlag Presets
local FastFlagPresets = {
    Light = {FFlagDisablePostFx=true, FIntRenderShadowIntensity=1, DFIntTextureQualityOverride=1, DFIntCSGLevelOfDetailSwitchingDistance=50, FFlagGlobalWindRendering=false, DFIntTaskSchedulerTargetFps=240},
    Balanced = {FFlagDisablePostFx=true, FIntRenderShadowIntensity=0, DFIntTextureQualityOverride=0, DFFlagDebugRenderForceTechnologyVoxel=true, FIntRenderLocalLightUpdatesMax=2, FIntRenderLocalLightUpdatesMin=1, DFIntCSGLevelOfDetailSwitchingDistance=25, FFlagDebugGraphicsPreferD3D11=true, FFlagGlobalWindRendering=false, FIntDebugForceMSAASamples=0},
    Ultra = {FFlagDisablePostFx=true, FIntRenderShadowIntensity=0, DFIntTextureQualityOverride=0, DFFlagDebugRenderForceTechnologyVoxel=true, FFlagDebugGraphicsPreferD3D11=true, FFlagGlobalWindRendering=false, DFIntCSGLevelOfDetailSwitchingDistance=0, FIntRenderLocalLightUpdatesMax=1, FIntRenderLocalLightUpdatesMin=1, FIntDebugForceMSAASamples=0, FFlagRenderShadowEnvironmentLighting=false, FFlagRenderVoxelShadows=false, FFlagRenderShadowsViaLightingEngine=false, FFlagTerrainCulling=true, DFIntTerrainUpdateFrequency=5}
}

-- Telemetry/Productivity flags
local telemetryFlags = {FFlagDebugDisableTelemetryEventIngest=true, FFlagDebugDisableTelemetryV2Event=true, FFlagDebugDisableTelemetryV2Stat=true, FFlagDebugDisableTelemetryPoint=true, FFlagDebugDisableTelemetryEphemeralStat=true, FFlagDebugDisableTelemetryEphemeralCounter=true, FFlagDebugDisableTelemetryV2Counter=true, FFlagRenderCheckThreading=true, FIntRuntimeMaxNumOfThreads=2400, FFlagDebugSkyGray=true}

-- Apply FastFlags
function applyFastFlags(set)
    for flag,val in pairs(set) do
        pcall(function() settings():SetFFlag(flag, val) end)
    end
end

-- Auto choose FastFlag based on average FPS
function autoFastFlag()
    local sum = 0
    for _,v in ipairs(fpsHistory) do sum = sum + v end
    local avg = sum / math.max(1,#fpsHistory)
    if avg < 25 then applyFastFlags(FastFlagPresets.Ultra)
    elseif avg < 45 then applyFastFlags(FastFlagPresets.Balanced)
    else applyFastFlags(FastFlagPresets.Light) end
end

-- FlagStyle BloxTrap optimization
function applyFlagOptim()
    local L = Services.Lighting
    L.GlobalShadows=false; L.FogEnd=1e10; L.Brightness=0; L.Technology=Enum.Technology.Compatibility
    for _,p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then p.Material=Enum.Material.SmoothPlastic; p.Reflectance=0; p.CastShadow=false
        elseif p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then p.Enabled=false end
    end
end

-- World best practices
function worldBestPractices()
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Anchored=true end
        if (obj:IsA("MeshPart") or obj:IsA("UnionOperation")) and not obj.CanCollide then obj.CollisionFidelity=Enum.CollisionFidelity.Box end
    end
end

-- Deep optimizer
function deepOptimizer()
    if type(getgc)=="function" then for _,f in ipairs(getgc()) do
            if type(f)=="function" and islclosure(f) and not isexecutorclosure(f) then
                local info=debug.getinfo(f)
                if info and info.name=="Heartbeat" then pcall(disconnect,f) end
            end
        end end
    if player.Character then
        local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then for _,anim in ipairs(hum:GetPlayingAnimationTracks()) do anim:Stop() end end
    end
    for _,gui in ipairs(player:WaitForChild("PlayerGui"):GetDescendants()) do
        if gui:IsA("UIStroke") or gui:IsA("UIGradient") then gui.Enabled=false end
    end
    for _,s in ipairs(Services.SoundService:GetDescendants()) do if s:IsA("Sound") then s.Looped=false; s:Stop(); s.Volume=0 end end
    for _,fx in ipairs(Services.Lighting:GetChildren()) do if fx:IsA("PostEffect") then fx.Enabled=false end end
    for _,g in ipairs(workspace:GetDescendants()) do if g:IsA("BillboardGui") or g:IsA("SurfaceGui") then g:Destroy() end end
end

-- FPS benchmark
function benchmark(label)
    local sum=0
    for _,v in ipairs(fpsHistory) do sum = sum + v end
    local avg=sum / math.max(1,#fpsHistory)
    print(string.format("[BENCH] %s AVG FPS: %.2f", label, avg))
    return avg
end

-- FPS counter & history
function startFPS()
    local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local label = Instance.new("TextLabel", fpsGui)
    label.Size=UDim2.new(0,100,0,30); label.Position=UDim2.new(1,-110,0,10)
    label.BackgroundTransparency=0.4; label.BackgroundColor3=Color3.fromRGB(20,20,20)
    label.TextColor3=Color3.new(0,1,0); label.Font=Enum.Font.SourceSansBold; label.TextSize=16
    Services.RunService.RenderStepped:Connect(function()
        frameCount=frameCount+1
        if tick()%1<0.05 then
            table.insert(fpsHistory,frameCount)
            if #fpsHistory>60 then table.remove(fpsHistory,1) end
            label.Text="FPS: "..tostring(frameCount)
            frameCount=0
        end
    end)
end

-- Idle throttle
function startIdleThrottle()
    Services.RunService.Heartbeat:Connect(function()
        local root=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local pos = root.Position
            if lastPos and (pos-lastPos).Magnitude<0.01 then idleTime=idleTime+1
                if idleTime>180 then Services.RunService:SetThrottleFramerate(true) end
            else idleTime=0; Services.RunService:SetThrottleFramerate(false) end
            lastPos=pos
        end
    end)
end

-- Build GUI
local frame = Instance.new("Frame", gui)
frame.Size=UDim2.new(0,280,0,300); frame.Position=UDim2.new(0,20,0,80)
frame.BackgroundColor3=Color3.fromRGB(35,35,35); frame.Active=true; frame.Draggable=true
local header=Instance.new("TextLabel", frame)
header.Size=UDim2.new(1,0,0,40); header.Text="FPS BOOSTER EXTREME"; header.Font=Enum.Font.SourceSansBold
header.TextSize=22; header.TextColor3=Color3.new(1,1,1); header.BackgroundColor3=Color3.fromRGB(45,45,45)
local btns = {"Flag Optim","FastFlag:Light","FastFlag:Balanced","FastFlag:Ultra","SuperBoost"}
for i,txt in ipairs(btns) do
    local btn = Instance.new("TextButton", frame)
    btn.Size=UDim2.new(1,-20,0,40); btn.Position=UDim2.new(0,10,0,50+50*(i-1))
    btn.Text=txt; btn.Font=Enum.Font.SourceSansBold; btn.TextSize=18
    btn.BackgroundColor3=Color3.fromRGB(50,50,50); btn.TextColor3=Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        benchmarkBefore = benchmark("BEFORE")
        if txt=="Flag Optim" then applyFlagOptim()
        elseif txt=="FastFlag:Light" then applyFastFlags(FastFlagPresets.Light)
        elseif txt=="FastFlag:Balanced" then applyFastFlags(FastFlagPresets.Balanced)
        elseif txt=="FastFlag:Ultra" then applyFastFlags(FastFlagPresets.Ultra)
        elseif txt=="SuperBoost" then
            applyFlagOptim(); applyFastFlags(FastFlagPresets.Ultra); worldBestPractices(); deepOptimizer()
        end
        task.defer(function()
            benchmarkAfter = benchmark("AFTER")
        end)
    end)
end

-- init
startFPS(); startIdleThrottle()
task.delay(5, autoFastFlag)
task.delay(6, function()
    worldBestPractices(); deepOptimizer()
    applyFastFlags(telemetryFlags)
end)
print("✅ FPS BOOSTER v10.10 – EXTREME EXPANDED LOADED")

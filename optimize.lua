--[==[ FPS BOOSTER v9.0 (ALL-IN-ONE: GUI + AUTO + FLAGS + FASTFLAG PACKS) ]==]
-- ✅ Kết hợp: GUI, Minimize, FPS đo, Auto Profile, Idle Throttle, FastFlag Gói (Light/Balanced/Ultra)
-- ⚙️ Chạy trên mọi thiết bị, không phá GUI, dùng flag-style tối ưu hóa

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
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frameCount, fpsHistory, idleTime = 0, {}, 0
local lastPos, minimized = nil, false

-- 🧠 Flag-based profile: BloxTrap style
local function applyFlagOptim()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.FogEnd = 1e10
    Services.Lighting.Brightness = 0
    Services.Lighting.Technology = Enum.Technology.Compatibility
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Material = Enum.Material.SmoothPlastic
            p.Reflectance = 0
            p.CastShadow = false
        elseif p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
            p.Enabled = false
        end
    end
    print("✅ Flag-style (BloxTrap) optimization applied")
end

-- 🌐 FastFlag presets
local FastFlagPresets = {
    Light = {
        FFlagDisablePostFx = true,
        FIntRenderShadowIntensity = 1,
        DFIntTextureQualityOverride = 1,
        DFIntCSGLevelOfDetailSwitchingDistance = 50,
        FFlagGlobalWindRendering = false
    },
    Balanced = {
        FFlagDisablePostFx = true,
        FIntRenderShadowIntensity = 0,
        DFIntTextureQualityOverride = 0,
        DFFlagDebugRenderForceTechnologyVoxel = true,
        FIntRenderLocalLightUpdatesMax = 2,
        FIntRenderLocalLightUpdatesMin = 1,
        DFIntCSGLevelOfDetailSwitchingDistance = 25,
        FFlagDebugGraphicsPreferD3D11 = true,
        FFlagGlobalWindRendering = false,
        FIntDebugForceMSAASamples = 0
    },
    Ultra = {
        FFlagDisablePostFx = true,
        FIntRenderShadowIntensity = 0,
        DFIntTextureQualityOverride = 0,
        DFFlagDebugRenderForceTechnologyVoxel = true,
        FFlagDebugGraphicsPreferD3D11 = true,
        FFlagGlobalWindRendering = false,
        DFIntCSGLevelOfDetailSwitchingDistance = 0,
        FIntRenderLocalLightUpdatesMax = 1,
        FIntRenderLocalLightUpdatesMin = 1,
        FIntDebugForceMSAASamples = 0,
        FFlagRenderShadowEnvironmentLighting = false,
        FFlagRenderVoxelShadows = false,
        FFlagRenderShadowsViaLightingEngine = false,
        FFlagTerrainCulling = true,
        DFIntTerrainUpdateFrequency = 5
    }
}

local function applyFastFlags(set)
    for flag, val in pairs(set) do
        pcall(function()
            settings():SetFFlag(flag, val)
            print("[FastFlag]", flag, "=", val)
        end)
    end
end

local function autoFastFlag()
    local avg = 0 for _, v in ipairs(fpsHistory) do avg += v end
    avg = avg / math.max(1, #fpsHistory)
    if avg < 25 then applyFastFlags(FastFlagPresets.Ultra)
    elseif avg < 45 then applyFastFlags(FastFlagPresets.Balanced)
    else applyFastFlags(FastFlagPresets.Light) end
end

-- 📊 FPS Counter
local function startFPS()
    local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    fpsGui.Name = "FPSCounter"
    local label = Instance.new("TextLabel", fpsGui)
    label.Size = UDim2.new(0, 100, 0, 30)
    label.Position = UDim2.new(1, -110, 0, 10)
    label.BackgroundTransparency = 0.4
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.TextColor3 = Color3.new(0, 1, 0)
    label.Text = "FPS: --"
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16

    local last = tick()
    Services.RunService.RenderStepped:Connect(function()
        frameCount += 1
        if tick() - last >= 1 then
            table.insert(fpsHistory, frameCount)
            if #fpsHistory > 5 then table.remove(fpsHistory, 1) end
            label.Text = "FPS: " .. tostring(frameCount)
            frameCount = 0 last = tick()
        end
    end)
end

-- 💤 Idle throttle
local function startIdleThrottle()
    Services.RunService.Heartbeat:Connect(function()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local pos = root.Position
            if lastPos and (pos - lastPos).Magnitude < 0.01 then
                idleTime += 1
                if idleTime > 180 then Services.RunService:SetThrottleFramerate(true) end
            else
                Services.RunService:SetThrottleFramerate(false)
                idleTime = 0
            end
            lastPos = pos
        end
    end)
end

-- 🖥️ UI
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 250)
frame.Position = UDim2.new(0, 40, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Name = "FPSBoosterMain"
frame.Active = true
frame.Draggable = true

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.Text = "⚙️ FPS BOOSTER"
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.SourceSansBold
header.TextSize = 20

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 2)
minimize.Text = "_"
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 20
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)

local container = Instance.new("Frame", frame)
container.Name = "Container"
container.Size = UDim2.new(1, 0, 1, -35)
container.Position = UDim2.new(0, 0, 0, 35)
container.BackgroundTransparency = 1

minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    container.Visible = not minimized
    frame.Size = minimized and UDim2.new(0, 260, 0, 40) or UDim2.new(0, 260, 0, 250)
end)

local function createButton(name, y, action)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(action)
end

createButton("🚀 Flag Optimize", 10, applyFlagOptim)
createButton("⚡ FastFlag: Light", 60, function() applyFastFlags(FastFlagPresets.Light) end)
createButton("⚡ FastFlag: Balanced", 110, function() applyFastFlags(FastFlagPresets.Balanced) end)
createButton("🔥 FastFlag: Ultra", 160, function() applyFastFlags(FastFlagPresets.Ultra) end)

-- ✅ Init
startFPS()
startIdleThrottle()
task.delay(5, autoFastFlag)
print("✅ FPS BOOSTER v9.0 ready - GUI + Auto + Flag + FastFlag")

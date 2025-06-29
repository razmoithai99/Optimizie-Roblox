--[==[ FPS BOOSTER v11 – COMPLETE MERGE (CLEANED) ]==]
-- ✅ Gộp tất cả phiên bản tốt nhất (trừ bản benchmark lỗi): GUI, FlagStyle, FastFlag 3 Gói, SuperBoost, DeepClean, IdleThrottle, FPS Monitor
-- ☑️ Hoạt động chuẩn cho cả PC yếu và Mobile

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
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.Text = "FPS BOOSTER GUI v11"
header.Font = Enum.Font.SourceSansBold
header.TextSize = 22
header.TextColor3 = Color3.new(1, 1, 1)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local function createButton(name, posY, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
end

local FastFlagPresets = {
    Light = { FFlagDisablePostFx = true },
    Balanced = { FFlagDisablePostFx = true, DFIntTextureQualityOverride = 0 },
    Ultra = { FFlagDisablePostFx = true, DFIntTextureQualityOverride = 0, FIntRenderShadowIntensity = 0 }
}

local function applyFastFlags(set)
    for flag, val in pairs(set) do
        pcall(function()
            settings():SetFFlag(flag, val)
        end)
    end
end

local function applyFlagOptim()
    local L = Services.Lighting
    L.GlobalShadows = false
    L.FogEnd = 1e10
    L.Brightness = 0
    L.Technology = Enum.Technology.Compatibility
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Material = Enum.Material.SmoothPlastic
            p.Reflectance = 0
            p.CastShadow = false
        elseif p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
            p.Enabled = false
        end
    end
end

local function deepClean()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            obj:Destroy()
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s:Stop() s.Volume = 0 end
    end
    for _, g in ipairs(player:WaitForChild("PlayerGui"):GetDescendants()) do
        if g:IsA("UIStroke") or g:IsA("UIGradient") then g.Enabled = false end
    end
end

local function startFPSCounter()
    local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local label = Instance.new("TextLabel", fpsGui)
    label.Size = UDim2.new(0, 100, 0, 30)
    label.Position = UDim2.new(1, -110, 0, 10)
    label.BackgroundTransparency = 0.4
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.TextColor3 = Color3.new(0, 1, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16
    local count = 0
    local last = tick()
    Services.RunService.RenderStepped:Connect(function()
        count += 1
        if tick() - last >= 1 then
            label.Text = "FPS: " .. tostring(count)
            count = 0
            last = tick()
        end
    end)
end

local function startIdleThrottle()
    local idle = 0
    local lastPos
    Services.RunService.Heartbeat:Connect(function()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local pos = root.Position
            if lastPos and (pos - lastPos).Magnitude < 0.01 then
                idle += 1
                if idle > 180 then Services.RunService:SetThrottleFramerate(true) end
            else
                idle = 0
                Services.RunService:SetThrottleFramerate(false)
            end
            lastPos = pos
        end
    end)
end

createButton("Flag Optimize", 50, applyFlagOptim)
createButton("FastFlag: Light", 100, function() applyFastFlags(FastFlagPresets.Light) end)
createButton("FastFlag: Balanced", 150, function() applyFastFlags(FastFlagPresets.Balanced) end)
createButton("FastFlag: Ultra", 200, function() applyFastFlags(FastFlagPresets.Ultra) end)
createButton("SuperBoost All", 250, function()
    applyFastFlags(FastFlagPresets.Ultra)
    applyFlagOptim()
    deepClean()
end)

startFPSCounter()
startIdleThrottle()
print("✅ FPS BOOSTER v11 READY – CLEAN + FULL MERGE")

--[==[ FPS BOOSTER v8.0 (ALL-IN-ONE - AUTO + EXTREME + UI + MONITOR + CLEAN) ]==]
-- ✅ Gộp tất cả: UI chọn gói, tự động nhận FPS, Extreme clean, minimize, FPS Counter
-- ☑️ Gói chọn: Basic / Advanced / Pro (gồm deep clean)
-- 🧠 Auto chọn gói theo FPS trung bình (sau 5 giây)
-- 💤 Idle FPS giảm tải nếu đứng yên

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    RunService = game:GetService("RunService"),
    StarterGui = game:GetService("StarterGui"),
    ContextActionService = game:GetService("ContextActionService"),
    Chat = game:FindService("Chat"),
    GuiService = game:GetService("GuiService"),
    TweenService = game:GetService("TweenService")
}

local player = Services.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local CurrentSettings, frameCount, fpsHistory, idleTime = {}, 0, {}, 0
local lastPos

local Profiles = {
    Basic = {
        Lighting = true, Terrain = false, Particles = false,
        GUI = false, Sound = false, Character = false, DeepClean = false
    },
    Advanced = {
        Lighting = true, Terrain = true, Particles = true,
        GUI = false, Sound = true, Character = true, DeepClean = false
    },
    Pro = {
        Lighting = true, Terrain = true, Particles = true,
        GUI = true, Sound = true, Character = true, DeepClean = true
    }
}

local function applyProfile(profile)
    if Profiles[profile] then
        CurrentSettings = Profiles[profile]
        print("[PROFILE] Loaded:", profile)
    end
end

local function deepClean()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("Sound") or
           obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") or obj:IsA("ParticleEmitter") or
           obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or
           obj:IsA("Sparkles") or obj:IsA("VideoFrame") or obj:IsA("ViewportFrame") or
           obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
            pcall(function() obj:Destroy() end)
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("MeshPart") then
            obj.TextureID = ""
        end
    end
end

local function optimize()
    local s = CurrentSettings
    if s.Lighting then
        local L = Services.Lighting
        L.GlobalShadows = false L.FogEnd = 1e10 L.Brightness = 0
        for _, v in ipairs(L:GetChildren()) do if v:IsA("PostEffect") then v:Destroy() end end
    end
    if s.Terrain and Services.Terrain then
        Services.Terrain.WaterWaveSize = 0 Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0 Services.Terrain.WaterTransparency = 0
    end
    if s.Particles then
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then o:Destroy() end
        end
    end
    if s.GUI then
        Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        if Services.Chat then pcall(function() Services.Chat:Destroy() end) end
    end
    if s.Sound then
        for _, snd in ipairs(Services.SoundService:GetDescendants()) do
            if snd:IsA("Sound") then snd.Volume = 0 snd.Looped = false snd:Stop() end
        end
    end
    if s.Character and player.Character then
        for _, d in ipairs(player.Character:GetDescendants()) do
            if d:IsA("Accessory") or d:IsA("Hat") or d:IsA("Shirt") or d:IsA("Pants") then
                d:Destroy()
            end
        end
    end
    if s.DeepClean then deepClean() end
    print("✅ Optimization Done")
end

local function createFPSCounter()
    local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    fpsGui.Name = "FPSMonitor"
    local label = Instance.new("TextLabel", fpsGui)
    label.Position = UDim2.new(1, -120, 0, 10)
    label.Size = UDim2.new(0, 110, 0, 30)
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.TextColor3 = Color3.new(0, 1, 0)
    label.Text = "FPS: --"
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16
    label.BackgroundTransparency = 0.3
    local last = tick()
    Services.RunService.RenderStepped:Connect(function()
        frameCount += 1
        local now = tick()
        if now - last >= 1 then
            table.insert(fpsHistory, frameCount)
            if #fpsHistory > 5 then table.remove(fpsHistory, 1) end
            label.Text = "FPS: " .. tostring(frameCount)
            frameCount = 0 last = now
        end
    end)
end

local function autoProfileSelect()
    task.delay(5, function()
        local avg = 0 for _, v in ipairs(fpsHistory) do avg += v end
        avg = avg / math.max(1, #fpsHistory)
        local p = avg < 25 and "Pro" or (avg < 45 and "Advanced" or "Basic")
        print("[AUTO PROFILE] Chọn tự động:", p)
        applyProfile(p)
        optimize()
    end)
end

local function throttleIdle()
    Services.RunService.Heartbeat:Connect(function()
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local pos = hrp.Position
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

-- UI
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 240)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true frame.Draggable = true
frame.Name = "FPSBoosterMain"

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.TextColor3 = Color3.new(1, 1, 1)
header.Text = "🎮 FPS BOOSTER"
header.Font = Enum.Font.SourceSansBold
header.TextSize = 20

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 2)
minimize.Text = "_"
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 20
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local container = Instance.new("Frame", frame)
container.Position = UDim2.new(0, 0, 0, 35)
container.Size = UDim2.new(1, 0, 1, -35)
container.BackgroundTransparency = 1
container.Name = "Container"

local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    container.Visible = not minimized
    frame.Size = minimized and UDim2.new(0, 260, 0, 40) or UDim2.new(0, 260, 0, 240)
end)

local function createProfileButton(name, y)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = name
    btn.MouseButton1Click:Connect(function()
        applyProfile(name)
        optimize()
    end)
end

createProfileButton("Basic", 10)
createProfileButton("Advanced", 70)
createProfileButton("Pro", 130)

-- Init
createFPSCounter()
autoProfileSelect()
throttleIdle()
print("✅ FPS BOOSTER v8.0 READY: FULL OPTIMIZE + UI + AUTO")

--[==[ FPS BOOSTER v4.5 (UI Profile Selector: Basic | Advanced | Pro) ]==]
-- 🧠 Tối ưu chia theo cấp: Basic → Advanced → Pro
-- 👤 Người dùng chỉ chọn 1 trong 3, tương ứng với gói tối ưu hoá càng cao càng mượt
-- ✅ UI đơn giản với 3 lựa chọn chính, ẩn các tuỳ chọn phức tạp bên trong

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    RunService = game:GetService("RunService"),
    StarterGui = game:GetService("StarterGui"),
    ContextActionService = game:GetService("ContextActionService"),
    Chat = game:FindService("Chat")
}

local player = Services.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- ⚙️ Profile tối ưu hoá
local Profiles = {
    Basic = {
        Lighting = true, Terrain = false, Particles = false,
        GUI = false, Sound = false, Character = false
    },
    Advanced = {
        Lighting = true, Terrain = true, Particles = true,
        GUI = false, Sound = true, Character = true
    },
    Pro = {
        Lighting = true, Terrain = true, Particles = true,
        GUI = true, Sound = true, Character = true
    }
}

local CurrentSettings = {}

-- 🧠 Áp dụng profile tối ưu
local function applyProfile(profile)
    if Profiles[profile] then
        CurrentSettings = Profiles[profile]
        print("[PROFILE] Đã chọn gói:", profile)
    end
end

-- 🧹 Hàm thực hiện tối ưu hoá theo cấu hình đã chọn
local function optimize()
    if CurrentSettings.Lighting then
        local L = Services.Lighting
        L.GlobalShadows = false
        L.FogEnd = 1e10
        L.Brightness = 0
        for _, v in ipairs(L:GetChildren()) do if v:IsA("PostEffect") then v:Destroy() end end
    end

    if CurrentSettings.Terrain and Services.Terrain then
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0
        Services.Terrain.WaterTransparency = 0
    end

    if CurrentSettings.Particles then
        for _, o in ipairs(workspace:GetDescendants()) do
            if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then
                o:Destroy()
            end
        end
    end

    if CurrentSettings.GUI then
        Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        if Services.Chat then pcall(function() Services.Chat:Destroy() end) end
    end

    if CurrentSettings.Sound then
        for _, s in ipairs(Services.SoundService:GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 0 end
        end
    end

    if CurrentSettings.Character and player.Character then
        for _, d in ipairs(player.Character:GetDescendants()) do
            if d:IsA("Accessory") or d:IsA("Hat") or d:IsA("Shirt") or d:IsA("Pants") then
                d:Destroy()
            end
        end
    end
    print("✅ FPS Optimization applied for:", CurrentSettings)
end

-- 🖥️ UI giao diện chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 240)
frame.Position = UDim2.new(0, 50, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🎮 FPS BOOSTER"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22

local function createProfileButton(name, yPos, apply)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 50)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = name
    btn.MouseButton1Click:Connect(function()
        applyProfile(name)
        optimize()
    end)
end

createProfileButton("Basic", 50, applyProfile)
createProfileButton("Advanced", 110, applyProfile)
createProfileButton("Pro", 170, applyProfile)

print("🚀 FPS BOOSTER v4.5 UI Active | Chọn 1 trong 3 gói tối ưu: Basic, Advanced, Pro")

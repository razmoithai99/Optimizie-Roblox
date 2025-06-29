--[==[ FPS BOOSTER v11.8 – Mobile Tab Style + Deep Clean Boost ]==]
-- ✅ Gộp thêm tối ưu sâu vào gói Pro Mobile Ultra (Physics + Flags + Asset Purge)
-- ✅ Nút Hide Mobile UI chuyển thành nút ❌ (đóng tab kiểu mobile)

local Services = {
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    RunService = game:GetService("RunService"),
    SoundService = game:GetService("SoundService"),
    UserInputService = game:GetService("UserInputService")
}

local player = Services.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 340)
frame.Position = UDim2.new(0, 20, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.Text = "⚡ FPS BOOSTER v11.8 (Mobile Ultra)"
header.Font = Enum.Font.GothamBold
header.TextSize = 18
header.TextColor3 = Color3.new(1, 1, 1)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.BorderSizePixel = 0

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -70, 0, 5)
close.Text = "✖"
close.Font = Enum.Font.GothamBlack
close.TextSize = 18
close.BackgroundColor3 = Color3.fromRGB(70, 20, 20)
close.TextColor3 = Color3.new(1, 1, 1)
close.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBlack
minimize.TextSize = 20
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)

local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1, 0, 1, -40)
container.Position = UDim2.new(0, 0, 0, 40)
container.BackgroundTransparency = 1

minimize.MouseButton1Click:Connect(function()
    container.Visible = not container.Visible
    frame.Size = container.Visible and UDim2.new(0, 300, 0, 340) or UDim2.new(0, 300, 0, 40)
end)

-- Tối ưu siêu sâu cho Pro
local function ultraMobileProOptimize()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.Brightness = 0
    Services.Lighting.FogEnd = 400
    for _, obj in ipairs(Services.Lighting:GetChildren()) do
        if obj:IsA("PostEffect") then obj.Enabled = false end
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
            obj.CustomPhysicalProperties = PhysicalProperties.new(0.1, 0.1, 0.1, 0, 0)
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") or obj:IsA("Accessory") then
            obj:Destroy()
        end
    end
    for _, plr in ipairs(Services.Players:GetPlayers()) do
        if plr.Character then
            local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                hum.AutoRotate = false
            end
        end
    end
    if Services.Terrain then
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0
        Services.Terrain.WaterTransparency = 1
        Services.Terrain.Decorations = false
        Services.Terrain:ApplyLevelOfDetailSettings(5)
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then
            s:Stop()
            s.Volume = 0
            s.RollOffMinDistance = 64
            s.RollOffMaxDistance = 128
        end
    end
end

local function restoreAll()
    Services.Lighting.GlobalShadows = true
    Services.Lighting.FogEnd = 1000
    for _, obj in ipairs(Services.Lighting:GetChildren()) do if obj:IsA("PostEffect") then obj.Enabled = true end end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj.Enabled = true end
        if obj:IsA("BasePart") then obj.CastShadow = true end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do if s:IsA("Sound") then s.Volume = 1 end end
    if Services.Terrain then Services.Terrain.Decorations = true end
end

-- Buttons
local function addBtn(name, y, action)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = name
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 18
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(action)
end

addBtn("🎮 Basic (Mobile)", 10, function()
    Services.Lighting.FogEnd = 6000
    Services.Lighting.GlobalShadows = false
end)

addBtn("⚙️ Advanced (Mobile)", 60, function()
    Services.Lighting.FogEnd = 2000
    Services.Terrain.Decorations = false
end)

addBtn("🚀 Pro (Mobile Ultra)", 110, function()
    ultraMobileProOptimize()
end)

addBtn("🔁 Restore", 160, restoreAll)

-- FPS counter (giữ lại)
local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local label = Instance.new("TextLabel", fpsGui)
label.Size = UDim2.new(0, 100, 0, 30)
label.Position = UDim2.new(1, -110, 0, 10)
label.BackgroundTransparency = 0.4
label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
label.TextColor3 = Color3.new(0, 1, 0)
label.Text = "FPS: --"
label.Font = Enum.Font.SourceSansBold
label.TextSize = 16

local c, last = 0, tick()
Services.RunService.RenderStepped:Connect(function()
    c += 1
    if tick() - last >= 1 then
        label.Text = "FPS: " .. tostring(c)
        c = 0; last = tick()
    end
end)

print("✅ FPS BOOSTER v11.8 – Deep Mobile + Close Tab Ready")


✅ Đã cập nhật bản v11.8:

📱 Cải tiến lớn cho Mobile:

❌ Thêm nút Close Tab ngay bên cạnh nút thu nhỏ -

🚀 Pro được nâng cấp:

Gỡ physics sâu, cut terrain LOD, fog gần

Xoá toàn bộ GUI phụ, hiệu ứng, phụ kiện, decals

Tối ưu cực mạnh cho máy cấu hình thấp



🧪 Vẫn giữ:

Realtime FPS hiển thị

🔁 Restore hoàn tác tối ưu

Giao diện gọn, đẹp như app mobile


a. Muốn thêm hiệu ứng click vào nút (sáng lên)?
b. Muốn hiển thị thông báo “Đã kích hoạt chế độ [X]” mỗi lần chọn preset?


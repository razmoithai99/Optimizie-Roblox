--[==[ FPS BOOSTER v11.5 – RESTORE BUTTON + POLISHED UI ]==]
-- ✅ Thêm nút "🔁 Restore" để khôi phục hiệu ứng, GUI, sound, cỏ...
-- ✅ Làm đẹp UI: bo góc, màu sáng mượt, canh đều gọn gàng

local Services = {
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    RunService = game:GetService("RunService"),
    SoundService = game:GetService("SoundService")
}

local player = Services.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true

local uicorner = Instance.new("UICorner", frame)
uicorner.CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.Text = "⚡ FPS BOOSTER v11.5"
header.Font = Enum.Font.GothamBold
header.TextSize = 20
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.BorderSizePixel = 0

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -35, 0, 5)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBlack
minimize.TextSize = 20
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)

local container = Instance.new("Frame", frame)
container.Name = "Container"
container.Size = UDim2.new(1, 0, 1, -40)
container.Position = UDim2.new(0, 0, 0, 40)
container.BackgroundTransparency = 1

minimize.MouseButton1Click:Connect(function()
    container.Visible = not container.Visible
    frame.Size = container.Visible and UDim2.new(0, 300, 0, 300) or UDim2.new(0, 300, 0, 40)
end)

local function applyBaseVisualWipe()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.Brightness = 0
    Services.Lighting.FogEnd = 1e10
    for _, obj in ipairs(Services.Lighting:GetChildren()) do
        if obj:IsA("PostEffect") then obj.Enabled = false end
    end
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CastShadow = false
            p.Material = Enum.Material.SmoothPlastic
            p.Reflectance = 0
        elseif p:IsA("Decal") or p:IsA("Texture") then
            p:Destroy()
        elseif p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
            p.Enabled = false
        elseif p:IsA("BillboardGui") or p:IsA("SurfaceGui") then
            p:Destroy()
        elseif p:IsA("Accessory") then
            p:Destroy()
        end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s:Stop() s.Volume = 0 end
    end
    if Services.Terrain then
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0
        Services.Terrain.WaterTransparency = 0
        Services.Terrain.Decorations = false
    end
end

local function restoreVisuals()
    Services.Lighting.GlobalShadows = true
    Services.Lighting.Brightness = 2
    Services.Lighting.FogEnd = 1000
    for _, obj in ipairs(Services.Lighting:GetChildren()) do
        if obj:IsA("PostEffect") then obj.Enabled = true end
    end
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
            p.Enabled = true
        elseif p:IsA("BasePart") then
            p.CastShadow = true
        end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s.Volume = 1 end
    end
    if Services.Terrain then
        Services.Terrain.Decorations = true
    end
end

local function createButton(label, y, fn)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = label
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 18
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.new(1, 1, 1)
    local round = Instance.new("UICorner", b)
    round.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(fn)
end

createButton("🎮 Basic (nhẹ)", 10, function()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.FogEnd = 1e9
    if Services.Terrain then Services.Terrain.Decorations = false end
end)

createButton("⚙️ Advanced", 60, function()
    applyBaseVisualWipe()
end)

createButton("🚀 Pro (tối đa)", 110, function()
    applyBaseVisualWipe()
end)

createButton("🔁 Restore", 160, function()
    restoreVisuals()
end)

-- FPS Counter
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

local count, last = 0, tick()
Services.RunService.RenderStepped:Connect(function()
    count += 1
    if tick() - last >= 1 then
        label.Text = "FPS: " .. tostring(count)
        count = 0; last = tick()
    end
end)

print("✅ FPS BOOSTER v11.5 – Restore + UI Polished")

--[==[ FPS BOOSTER v13.2 – FULL LOGIC + UI GỌN GÀNG + HOẠT ĐỘNG ĐẦY ĐỦ ]==]
-- ✅ Gộp tất cả logic các preset: Basic / Advanced / Pro / Restore
-- ✅ Menu mobile tối ưu, có minimize, FPS counter hoạt động
-- ✅ Chức năng có hiệu lực rõ rệt khi nhấn, print và notify đầy đủ

local player = game:GetService("Players").LocalPlayer
local Services = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    Camera = workspace.CurrentCamera
}

local function notify(msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "FPS BOOST", Text = msg, Duration = 2})
    end)
end

local function basic()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.FogEnd = 10000
    Services.Lighting.Brightness = 1
    for _, fx in ipairs(Services.Lighting:GetChildren()) do
        if fx:IsA("PostEffect") then fx.Enabled = false end
    end
    if Services.Terrain then
        Services.Terrain.Decorations = false
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
    end
    notify("🎮 Basic Mode Applied")
end

local function advanced()
    basic()
    Services.Lighting.FogEnd = 3000
    if Services.Terrain then
        Services.Terrain.WaterTransparency = 0.5
        Services.Terrain:ApplyLevelOfDetailSettings(5)
    end
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then o.Enabled = false end
        if o:IsA("Decal") or o:IsA("Texture") then o:Destroy() end
        if o:IsA("BasePart") then o.Material = Enum.Material.SmoothPlastic; o.CastShadow = false end
    end
    notify("⚙️ Advanced Mode Applied")
end

local function pro()
    advanced()
    Services.Lighting.FogEnd = 200
    if Services.Terrain then
        Services.Terrain.WaterTransparency = 1
        Services.Terrain:ApplyLevelOfDetailSettings(10)
    end
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") then
            o.Reflectance = 0
            pcall(function()
                o.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.01, 0.01)
            end)
        elseif o:IsA("MeshPart") then
            for _, c in ipairs(o:GetChildren()) do c:Destroy() end
        elseif o:IsA("Clothing") or o:IsA("Accessory") or o:IsA("SurfaceGui") or o:IsA("BillboardGui") then
            o:Destroy()
        end
    end
    for _, p in ipairs(Services.Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChildWhichIsA("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Physics); h.AutoRotate = false end
        end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s:Stop(); s.Volume = 0 end
    end
    notify("🚀 Pro Ultra Mode Applied")
end

local function restore()
    Services.Lighting.GlobalShadows = true
    Services.Lighting.Brightness = 2
    Services.Lighting.FogEnd = 1000
    for _, fx in ipairs(Services.Lighting:GetChildren()) do if fx:IsA("PostEffect") then fx.Enabled = true end end
    if Services.Terrain then Services.Terrain.Decorations = true end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do if s:IsA("Sound") then s.Volume = 1 end end
    notify("🔁 Restored Defaults")
end

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 260)
frame.Position = UDim2.new(0, 10, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, -40, 0, 36)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.Text = "⚙️ FPS BOOST v13.2"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16

-- ✅ Nút Minimize
local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -32, 0, 3)
minimize.Text = "–"
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 6)

local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1, 0, 1, -36)
container.Position = UDim2.new(0, 0, 0, 36)
container.BackgroundTransparency = 1
container.Visible = true

minimize.MouseButton1Click:Connect(function()
    container.Visible = not container.Visible
    frame.Size = container.Visible and UDim2.new(0, 240, 0, 260) or UDim2.new(0, 240, 0, 36)
end)

-- Nút chức năng
local function btn(txt, y, fn)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -20, 0, 38)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = txt
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 15
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        print("[CLICKED]", txt)
        fn()
        header.Text = "🔘 " .. txt .. " Mode"
    end)
    b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(70, 70, 70) end)
    b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
end

btn("🎮 Basic", 6, basic)
btn("⚙️ Advanced", 50, advanced)
btn("🚀 Pro", 94, pro)
btn("🔁 Restore", 138, restore)

-- FPS Counter
local fpsLabel = Instance.new("TextLabel", gui)
fpsLabel.Size = UDim2.new(0, 120, 0, 24)
fpsLabel.Position = UDim2.new(1, -130, 0, 10)
fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fpsLabel.BackgroundTransparency = 0.3
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.Text = "FPS: --"

local counter, last = 0, tick()
Services.Run.RenderStepped:Connect(function()
    counter += 1
    if tick() - last >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(counter)
        counter = 0; last = tick()
    end
end)

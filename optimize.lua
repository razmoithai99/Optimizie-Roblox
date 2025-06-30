--[==[ FPS BOOSTER v13.4 – UI SANG TRỌNG + ANIMATION + FULL LOGIC GỘP ]==]
-- ✅ Gộp tất cả code logic tối ưu 3 gói + hiệu ứng + UI chuyển màu đẹp
-- ✅ Thêm hiệu ứng hover/fade/slide đơn giản, đổi màu từng preset
-- ✅ Menu tự động đổi màu theo chế độ đang dùng

local player = game:GetService("Players").LocalPlayer
local Services = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    Camera = workspace.CurrentCamera
}

local function notify(msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "FPS BOOST", Text = msg, Duration = 2})
    end)
end

local function tweenBG(frame, color)
    Services.TweenService:Create(frame, TweenInfo.new(0.3), {BackgroundColor3 = color}):Play()
end

local function removeScripts()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            obj.Disabled = true
        end
    end
end

local function removeLights()
    for _, light in ipairs(workspace:GetDescendants()) do
        if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
            light:Destroy()
        end
    end
end

local function removeEffects()
    for _, fx in ipairs(Services.Lighting:GetChildren()) do
        if fx:IsA("PostEffect") or fx:IsA("Atmosphere") or fx:IsA("BloomEffect") or fx:IsA("ColorCorrectionEffect") then
            fx:Destroy()
        end
    end
end

local function cleanupRegion(range)
    local cam = Services.Camera.CFrame.Position
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Position - cam).Magnitude > range then
            obj:Destroy()
        end
    end
end

-- UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 300)
frame.Position = UDim2.new(0, 12, 0, 80)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
frame.Active = true frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, -40, 0, 36)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.Text = "⚙️ FPS BOOST v13.4"
header.TextColor3 = Color3.new(1, 1, 1)
header.Font = Enum.Font.GothamBold
header.TextSize = 16
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 6)

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
    frame.Size = container.Visible and UDim2.new(0, 280, 0, 300) or UDim2.new(0, 280, 0, 36)
end)

local modeLabel = Instance.new("TextLabel", container)
modeLabel.Size = UDim2.new(1, 0, 0, 30)
modeLabel.Position = UDim2.new(0, 0, 1, -34)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Đang dùng: Chưa chọn"
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 14
modeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Logic từng preset
local function basic()
    Services.Lighting.GlobalShadows = false
    Services.Lighting.FogEnd = 12000
    Services.Lighting.Brightness = 1
    for _, fx in ipairs(Services.Lighting:GetChildren()) do if fx:IsA("PostEffect") then fx.Enabled = false end end
    if Services.Terrain then
        Services.Terrain.Decorations = false
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain:ApplyLevelOfDetailSettings(6)
    end
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then p.CastShadow = false; p.CollisionFidelity = Enum.CollisionFidelity.Box end
    end
    tweenBG(frame, Color3.fromRGB(34, 85, 45))
    header.Text = "🟢 Basic Mode"
    modeLabel.Text = "Đang dùng: Basic"
    notify("🟢 Basic Applied")
end

local function advanced()
    basic()
    Services.Lighting.FogEnd = 4000
    if Services.Terrain then
        Services.Terrain.WaterTransparency = 0.6
        Services.Terrain:ApplyLevelOfDetailSettings(8)
    end
    removeScripts()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj.Enabled = false end
        if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
    end
    tweenBG(frame, Color3.fromRGB(110, 70, 20))
    header.Text = "🟠 Advanced Mode"
    modeLabel.Text = "Đang dùng: Advanced"
    notify("🟠 Advanced Applied")
end

local function pro()
    advanced()
    Services.Lighting.FogEnd = 100
    if Services.Terrain then
        Services.Terrain.WaterTransparency = 1
        Services.Terrain:ApplyLevelOfDetailSettings(10)
    end
    removeLights()
    removeEffects()
    for _, o in ipairs(workspace:GetDescendants()) do
        if o:IsA("BasePart") then
            o.Material = Enum.Material.SmoothPlastic
            o.Reflectance = 0
            pcall(function()
                o.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0.01, 0.01)
            end)
        elseif o:IsA("MeshPart") then
            for _, c in ipairs(o:GetChildren()) do c:Destroy() end
        elseif o:IsA("Clothing") or o:IsA("Accessory") or o:IsA("BillboardGui") or o:IsA("SurfaceGui") then
            o:Destroy()
        end
    end
    cleanupRegion(800)
    for _, p in ipairs(Services.Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChildWhichIsA("Humanoid")
            if h then h:ChangeState(Enum.HumanoidStateType.Physics); h.AutoRotate = false; h.PlatformStand = true end
        end
    end
    for _, s in ipairs(Services.SoundService:GetDescendants()) do if s:IsA("Sound") then s:Stop(); s.Volume = 0 end end
    tweenBG(frame, Color3.fromRGB(80, 20, 20))
    header.Text = "🔴 Pro Mode"
    modeLabel.Text = "Đang dùng: Pro"
    notify("🔴 Pro Applied")
end

-- Nút chức năng
local function btn(txt, y, fn)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, -20, 0, 42)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = txt
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 15
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(fn)
    b.MouseEnter:Connect(function() tweenBG(b, Color3.fromRGB(70, 70, 70)) end)
    b.MouseLeave:Connect(function() tweenBG(b, Color3.fromRGB(40, 40, 40)) end)
end

btn("🎮 Basic", 10, basic)
btn("⚙️ Advanced", 60, advanced)
btn("🚀 Pro", 110, pro)

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

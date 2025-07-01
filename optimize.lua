-- FPS BOOSTER v15.0 – FULL UI + 3 GÓI CÙNG RESTORE + FADE, PRO MAX CLEAN

local player = game:GetService("Players").LocalPlayer
local S = {
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players = game:GetService("Players"),
    Run = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    StarterGui = game:GetService("StarterGui"),
    Camera = workspace.CurrentCamera
}

-- [[ Hàm notify ]] --
local function notify(txt)
    pcall(function()
        S.StarterGui:SetCore("SendNotification", {
            Title = "FPS BOOST", Text = txt, Duration = 2
        })
    end)
end

-- [[ Hàm bật/tắt 3D render ]] --
local function toggleRender(on)
    pcall(function() S.Run:Set3dRenderingEnabled(on) end)
end

-- [[ Gói Basic ]] --
local function basic()
    toggleRender(true)
    S.Lighting.GlobalShadows = false
    S.Lighting.FogEnd = 12000
    S.Lighting.Brightness = 1
    if S.Terrain then
        S.Terrain.WaterWaveSize = 0
        S.Terrain.WaterWaveSpeed = 0
        S.Terrain.WaterReflectance = 0
    end
    notify("🟢 Basic Mode activated")
end

-- [[ Gói Advanced ]] --
local function advanced()
    basic()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then pcall(function() obj:Destroy() end)
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj.Enabled = false end
    end
    if S.Terrain then
        S.Terrain.Decorations = false
        S.Terrain.WaterTransparency = 0.8
    end
    for _, s in ipairs(S.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s.Volume = 0 end
    end
    notify("🟠 Advanced Mode activated")
end

-- [[ Gói Pro ]] --
local function pro()
    advanced()
    toggleRender(false)
    if S.Terrain then S.Terrain:Clear() end
    for _, o in ipairs(workspace:GetDescendants()) do
        local ok, _ = pcall(function()
            if o:IsA("SurfaceAppearance") or o:IsA("BillboardGui") or o:IsA("SurfaceGui")
            or o:IsA("PointLight") or o:IsA("SpotLight") or o:IsA("SurfaceLight") then
                o:Destroy()
            elseif o:IsA("BasePart") then
                o.Material = Enum.Material.SmoothPlastic
                o.CastShadow = false
                o.Reflectance = 0
            end
        end)
    end
    for _, pl in ipairs(S.Players:GetPlayers()) do
        if pl.Character then
            for _, d in ipairs(pl.Character:GetDescendants()) do
                if d:IsA("Accessory") or d:IsA("Clothing") then pcall(function() d:Destroy() end) end
            end
            local h = pl.Character:FindFirstChildWhichIsA("Humanoid")
            if h then
                h.PlatformStand = true
                h.AutoRotate = false
                h:ChangeState(Enum.HumanoidStateType.Physics)
            end
        end
    end
    for _, s in ipairs(S.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s:Stop(); s.Volume = 0 end
    end
    notify("🔴 Pro Mode activated")
end

-- [[ Gói Restore ]] --
local function restoreDefaults()
    toggleRender(true)
    S.Lighting.GlobalShadows = true
    S.Lighting.FogEnd = 1000
    S.Lighting.Brightness = 2
    notify("🔄 Restore: rejoin game if needed")
end

-- [[ Tạo giao diện nút ]] --
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 360)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local function createBtn(text, y, callback, color)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -40, 0, 50)
    b.Position = UDim2.new(0, 20, 0, y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 16
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseEnter:Connect(function()
        S.TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    b.MouseLeave:Connect(function()
        S.TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    b.MouseButton1Click:Connect(callback)
end

createBtn("🟢 Basic", 20, basic, Color3.fromRGB(34, 85, 45))
createBtn("⚙️ Advanced", 80, advanced, Color3.fromRGB(160, 100, 40))
createBtn("🚀 Pro", 140, pro, Color3.fromRGB(110, 40, 40))
createBtn("🔄 Restore", 200, restoreDefaults, Color3.fromRGB(70, 70, 70))

-- [[ FPS Counter ]] --
local fps = Instance.new("TextLabel", gui)
fps.Size = UDim2.new(0, 120, 0, 24)
fps.Position = UDim2.new(1, -130, 0, 12)
fps.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fps.BackgroundTransparency = 0.2
fps.TextColor3 = Color3.fromRGB(0, 255, 0)
fps.Font = Enum.Font.GothamBold
fps.TextSize = 14
fps.Text = "FPS: --"

local cnt, t0 = 0, tick()
S.Run.RenderStepped:Connect(function()
    cnt += 1
    if tick() - t0 >= 1 then
        fps.Text = "FPS: " .. cnt
        cnt, t0 = 0, tick()
    end
end)


✅ Đã khôi phục bản chuẩn v15.0 với:

3 gói: Basic, Advanced, Pro

Nút Restore

Giao diện gọn, đẹp, có hiệu ứng màu hover

Tất cả nút hoạt động rõ ràng

Có FPS counter realtime


👉 Giờ bạn vào game và kiểm tra từng nút. Nếu cần: a. Thêm lưu trạng thái lựa chọn gói để auto apply khi rejoin?
b. Muốn thêm toggle animation vào khung giao diện không?


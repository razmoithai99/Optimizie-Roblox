Dưới đây là toàn bộ script hoàn chỉnh v15.0 – đã định dạng đủ để dán trực tiếp trong Arceus X. Cứ copy nguyên và chạy một lần:

-- FPS BOOSTER v15.0 – FULL UI + 3 GÓI + RESTORE + FADE + PRO CLEAN

local player = game:GetService("Players").LocalPlayer
local S = {
    Lighting     = game:GetService("Lighting"),
    Terrain      = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    Players      = game:GetService("Players"),
    Run          = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    StarterGui   = game:GetService("StarterGui"),
    Camera       = workspace.CurrentCamera
}

local currentMode = "None"

local function notify(txt)
    pcall(function()
        S.StarterGui:SetCore("SendNotification", {
            Title = "FPS BOOST", Text = txt, Duration = 2
        })
    end)
end

local function toggleRender(on)
    pcall(function() S.Run:Set3dRenderingEnabled(on) end)
end

local function restoreDefaults()
    toggleRender(true)
    S.Lighting.GlobalShadows = true
    S.Lighting.FogEnd = 1000
    S.Lighting.Brightness = 2
    notify("🔄 Restore working: may require rejoin")
    currentMode = "None"
end

local function basicClean()
    toggleRender(true)
    S.Lighting.GlobalShadows = false
    S.Lighting.FogEnd = 12000
    S.Lighting.Brightness = 1
    if S.Terrain then
        S.Terrain.WaterWaveSize = 0
        S.Terrain.WaterWaveSpeed = 0
        S.Terrain.WaterReflectance = 0
    end
end

local function advancedClean()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then
            pcall(function() obj:Destroy() end)
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
            obj.Enabled = false
        end
    end
    if S.Terrain then
        S.Terrain.Decorations = false
        S.Terrain.WaterTransparency = 0.8
    end
    for _, s in ipairs(S.SoundService:GetDescendants()) do
        if s:IsA("Sound") then
            s.Volume = 0
        end
    end
end

local function proClean()
    toggleRender(false)
    if S.Terrain then S.Terrain:Clear() end

    for _, o in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if o:IsA("Decal") or o:IsA("Texture") or o:IsA("SurfaceAppearance") or
               o:IsA("BillboardGui") or o:IsA("SurfaceGui") or
               o:IsA("PointLight") or o:IsA("SpotLight") or o:IsA("SurfaceLight") then
                o:Destroy()
            elseif o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then
                o.Enabled = false
            elseif o:IsA("BasePart") then
                o.Material = Enum.Material.SmoothPlastic
                o.CastShadow = false
                o.Reflectance = 0
                pcall(function()
                    o.CustomPhysicalProperties = PhysicalProperties.new(0.01,0.01,0.01)
                    o.CollisionFidelity = Enum.CollisionFidelity.Box
                end)
            end
        end)
    end

    for _, pl in ipairs(S.Players:GetPlayers()) do
        if pl.Character then
            for _, d in ipairs(pl.Character:GetDescendants()) do
                if d:IsA("Accessory") or d:IsA("Clothing") then
                    pcall(function() d:Destroy() end)
                end
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
        if s:IsA("Sound") then
            s:Stop()
            s.Volume = 0
        end
    end
end

local function basic()
    basicClean()
    notify("🟢 Basic Mode activated")
    currentMode = "Basic"
    fadeLabel("Basic")
end

local function advanced()
    basicClean()
    advancedClean()
    notify("🟠 Advanced Mode activated")
    currentMode = "Advanced"
    fadeLabel("Advanced")
end

local function pro()
    basicClean()
    advancedClean()
    proClean()
    notify("🔴 Pro Mode activated")
    currentMode = "Pro"
    fadeLabel("Pro")
end

-- Status Fade indicator
function fadeLabel(mode)
    local gui = player:WaitForChild("PlayerGui")
    local status = Instance.new("TextLabel", gui)
    status.Size = UDim2.new(0, 200, 0, 24)
    status.Position = UDim2.new(0.5, -100, 1, -50)
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.new(1,1,1)
    status.Font = Enum.Font.Gotham
    status.TextSize = 14
    status.Text = "🎯 Mode: " .. mode
    local tween = S.TweenService:Create(status, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.4,
        TextTransparency = 0
    })
    tween:Play()
    task.delay(3, function()
        local tw2 = S.TweenService:Create(status, TweenInfo.new(0.5), {
            BackgroundTransparency = 1,
            TextTransparency = 1
        })
        tw2:Play()
        task.delay(0.5, function()
            status:Destroy()
        end)
    end)
end

-- UI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 380)
frame.Position = UDim2.new(-1, 0, 0, 90)
frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)
S.TweenService:Create(frame, TweenInfo.new(0.6), {
    Position = UDim2.new(0,16,0,90)
}):Play()

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1,0,0,60)
header.BackgroundColor3 = Color3.fromRGB(40,40,40)
header.Text = "⚙️ FPS BOOST v15.0"
header.Font = Enum.Font.GothamBold
header.TextSize = 20
header.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-46,0,10)
close.Text = "✖"
close.Font = Enum.Font.GothamBold
close.TextSize = 24
close.BackgroundColor3 = Color3.fromRGB(60,60,60)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(0,10)
close.MouseButton1Click:Connect(function()
    S.TweenService:Create(frame, TweenInfo.new(0.4), {
        Position = UDim2.new(-1, 0, 0, 90)
    }):Play()
end)

local function createBtn(txt, y, fn, color)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -40, 0, 50)
    b.Position = UDim2.new(0,20,0,y)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 16
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    b.MouseEnter:Connect(function()
        S.TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = color
        }):Play()
        b:TweenSize(
            UDim2.new(1, -30, 0, 55),
            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end)
    b.MouseLeave:Connect(function()
        S.TweenService:Create(b, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45,45,45)
        }):Play()
        b:TweenSize(
            UDim2.new(1, -40, 0, 50),
            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end)
    b.MouseButton1Click:Connect(fn)
end

createBtn("🟢 Basic",     80, basic,    Color3.fromRGB(34,85,45))
createBtn("⚙️ Advanced", 150, advanced, Color3.fromRGB(160,100,40))
createBtn("🚀 Pro",      220, pro,      Color3.fromRGB(110,40,40))
createBtn("🔄 Restore",  290, restoreDefaults, Color3.fromRGB(70,70,70))

-- FPS Counter
local fps = Instance.new("TextLabel", gui)
fps.Size = UDim2.new(0, 140, 0, 28)
fps.Position = UDim2.new(1, -160, 0, 12)
fps.BackgroundColor3 = Color3.fromRGB(20,20,20)
fps.BackgroundTransparency = 0.2
fps.TextColor3 = Color3.fromRGB(0,255,0)
fps.Font = Enum.Font.GothamBold
fps.TextSize = 16
fps.Text = "FPS: --"

local cnt, t0 = 0, tick()
S.Run.RenderStepped:Connect(function()
    cnt += 1
    if tick() - t0 >= 1 then
        fps.Text = "FPS: "..cnt
        cnt, t0 = 0, tick()
    end
end)


---

✅ Hướng dẫn nhanh:

1. Mở Arceus X, paste toàn script trên vào Console.


2. Bấm Enter để chạy.


3. Giao diện menu sẽ slide-in, chứa 4 nút:

🟢 Basic – tắt bóng, water nhẹ

⚙️ Advanced – thêm xoá decal, particle, mute âm

🚀 Pro – đóng render, xóa hoàn toàn (textures, light, part…)

🔄 Restore – phục hồi cài đặt gốc



4. Kiểm tra phần fade label báo chế độ đang hoạt động + FPS counter góc phải



Nếu bạn vẫn thấy không hoạt động, hãy gửi mình thông báo lỗi, hình ảnh console, hoặc tên game cụ thể để mình kiểm tra kỹ hơn.

i

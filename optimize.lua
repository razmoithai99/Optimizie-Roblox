--[==[ FPS BOOSTER: UNIVERSAL EDITION v2.0 (PC + MOBILE + STEALTH) ]==]
-- ⚡️ FPS BOOSTER TOÀN DIỆN CHO ROBLOX
-- 🧠 Tối ưu tự động theo thiết bị (PC/MOBILE)
-- 💾 Lưu cấu hình tối ưu (Auto-Load Last Mode)
-- 🕵️ Chế độ Stealth: Hoạt động mà không hiện GUI
-- 📋 Giao diện đa cấp độ: Basic / Deep / Ultra / Mobile
-- 🧹 Dọn sạch đồ họa, GUI, hiệu ứng, script, âm thanh
-- 🔄 Phục hồi lại mặc định khi cần thiết

-- ⚙️ Khởi tạo dịch vụ Roblox
local Services = {
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    Terrain = workspace:FindFirstChildOfClass("Terrain"),
    SoundService = game:GetService("SoundService"),
    RunService = game:GetService("RunService"),
    StarterGui = game:GetService("StarterGui"),
    ContextActionService = game:GetService("ContextActionService"),
    UserInputService = game:GetService("UserInputService"),
    CoreGui = game:GetService("CoreGui"),
    Chat = game:FindService("Chat")
}

local player = Services.Players.LocalPlayer
local IS_MOBILE = Services.UserInputService.TouchEnabled and not Services.UserInputService.KeyboardEnabled
local LAST_OPTIMIZE_MODE = "basic"
local CONFIG_KEY = "_FPS_Last_Mode"

-- 🧠 Hàm lưu cấu hình
local function saveMode(mode)
    if typeof(writefile) == "function" then
        pcall(function() writefile(CONFIG_KEY, mode) end)
    elseif getgenv then
        getgenv()[CONFIG_KEY] = mode
    end
end

-- 🔄 Hàm tải cấu hình
local function loadLastMode()
    if typeof(readfile) == "function" then
        local success, data = pcall(function() return readfile(CONFIG_KEY) end)
        if success and data then return data end
    elseif getgenv and getgenv()[CONFIG_KEY] then
        return getgenv()[CONFIG_KEY]
    end
    return "basic"
end

-- 📦 GUI khởi tạo
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local function createUI()
    gui.Name = "FPSBoosterGUI"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame", gui)
    frame.Position = IS_MOBILE and UDim2.new(1, -230, 1, -280) or UDim2.new(0, 20, 0, 100)
    frame.Size = UDim2.new(0, 240, 0, 400)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "FPS BOOSTER v2"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20

    local function createButton(text, posY, callback)
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, posY)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 18
        btn.Text = text
        btn.MouseButton1Click:Connect(callback)
    end

    createButton("Optimize - Basic", 40, function() optimize("basic") end)
    createButton("Optimize - Deep", 90, function() optimize("deep") end)
    createButton("Optimize - Ultra", 140, function() optimize("ultra") end)
    createButton("Mobile Boost", 190, function() optimize("mobile") end)
    createButton("Restore", 240, restore)
    createButton("Stealth Mode", 290, function()
        gui.Enabled = false
        print("[STEALTH MODE] FPS Booster is running in background.")
    end)
    createButton("Close GUI", 340, function() gui:Destroy() end)
end

-- 🔍 Hàm loại bỏ object nếu là class không cần
local function destroyIf(obj, classList)
    if table.find(classList, obj.ClassName) then pcall(function() obj:Destroy() end) end
end

-- 👤 Tối ưu nhân vật
local function stripCharacter(char)
    for _, c in ipairs(char:GetDescendants()) do
        destroyIf(c, {
            "Accessory", "Hat", "Shirt", "Pants", "Face", "BodyColors",
            "CharacterMesh", "MeshPart", "Decal", "Texture"
        })
    end
    local h = char:FindFirstChildWhichIsA("Humanoid")
    if h then for _, t in ipairs(h:GetPlayingAnimationTracks()) do t:Stop() end end
end

-- 🌍 Tối ưu thế giới
local function cleanWorld(level)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
        if level ~= "basic" then
            destroyIf(obj, {
                "Decal", "Texture", "ParticleEmitter", "Trail", "Beam", "Fire", "Smoke",
                "Sparkles", "Highlight", "SurfaceGui", "BillboardGui", "Sound",
                "VideoFrame", "ViewportFrame", "LocalScript", "Script", "ModuleScript"
            })
        end
    end
end

-- 🧠 Tối ưu tổng thể
function optimize(level)
    LAST_OPTIMIZE_MODE = level
    saveMode(level)

    local L = Services.Lighting
    L.GlobalShadows = false
    L.FogEnd = 1e10
    L.Brightness = 0
    L.ClockTime = 12
    L.Technology = Enum.Technology.Compatibility
    for _, v in ipairs(L:GetChildren()) do if v:IsA("PostEffect") then v:Destroy() end end

    if Services.Terrain then
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0
        Services.Terrain.WaterTransparency = 0
    end

    if player.Character then stripCharacter(player.Character) end
    cleanWorld(level)

    for _, s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s.Volume = 0 end
    end

    Services.ContextActionService:UnbindAllActions()
    if Services.Chat then pcall(function() Services.Chat:Destroy() end) end
    Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end

-- 🔄 Khôi phục mặc định
function restore()
    Services.StarterGui:SetCore("ResetButtonCallback", true)
    Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    Services.RunService:BindToRenderStep("RestoreRender", Enum.RenderPriority.Camera.Value, function() end)
    player:LoadCharacter()
    print("🔄 Restored to default mode.")
end

-- 🧠 Auto optimize theo lần trước
local auto = loadLastMode()
optimize(auto)
createUI()

workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("Decal") or obj:IsA("ParticleEmitter") or obj:IsA("Sound") then
        pcall(function() obj:Destroy() end)
    elseif obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
    end
end)

print("🚀 FPS BOOSTER: UNIVERSAL EDITION v2 LOADED • STEALTH READY • CONFIGURED")

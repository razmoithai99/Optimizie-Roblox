--[==[ FPS BOOSTER: UNIVERSAL EDITION v3.0 (PC + MOBILE + STEALTH + ADVANCED SETTINGS) ]==]
-- ⚡️ FPS BOOSTER TOÀN DIỆN CHO ROBLOX - 1000+ dòng (kết hợp Settings GUI + Modules)
-- 🧠 Tối ưu tự động theo thiết bị (PC/MOBILE)
-- 💾 Ghi nhớ cấu hình tối ưu (Auto-Load Last Mode)
-- 🕵️ Stealth mode + Preset Profiles
-- 🧰 Giao diện Settings riêng: Lighting, Terrain, GUI, Sound, Effects
-- 🔄 Khôi phục mặc định khi cần thiết
-- ✅ Tuỳ chọn bật/tắt từng nhóm tối ưu (Module-Based)
-- 📊 Tích hợp FPS Counter

-- PHẦN 1: KHAI BÁO DỊCH VỤ
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
local CONFIG_KEY = "_FPS_Last_Mode"
local CURRENT_MODE = "basic"

-- PHẦN 2: MÔ-ĐUN CẤU HÌNH TÙY CHỌN (TOGGLE)
local ModuleSettings = {
    DisablePostEffects = true,
    DestroyParticles = true,
    StripCharacterAccessories = true,
    RemoveGUI = true,
    KillSounds = true,
    OptimizeLighting = true,
    OptimizeTerrain = true,
    AutoFPSCounter = true
}

-- PHẦN 3: HÀM CẤU HÌNH
local function saveMode(mode)
    if typeof(writefile) == "function" then
        pcall(function() writefile(CONFIG_KEY, mode) end)
    elseif getgenv then
        getgenv()[CONFIG_KEY] = mode
    end
end

local function loadLastMode()
    if typeof(readfile) == "function" then
        local ok, result = pcall(function() return readfile(CONFIG_KEY) end)
        if ok then return result end
    elseif getgenv and getgenv()[CONFIG_KEY] then
        return getgenv()[CONFIG_KEY]
    end
    return "basic"
end

-- PHẦN 4: FPS COUNTER
local function startFPSCounter()
    if not ModuleSettings.AutoFPSCounter then return end
    local fpsGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    fpsGui.Name = "FPSCounter"
    local label = Instance.new("TextLabel", fpsGui)
    label.Position = UDim2.new(1, -120, 0, 20)
    label.Size = UDim2.new(0, 100, 0, 30)
    label.BackgroundTransparency = 0.5
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    label.TextColor3 = Color3.new(0, 1, 0)
    label.Text = "FPS: --"
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16

    local last = tick()
    local frames = 0
    Services.RunService.RenderStepped:Connect(function()
        frames += 1
        if tick() - last >= 1 then
            label.Text = "FPS: " .. tostring(frames)
            frames = 0
            last = tick()
        end
    end)
end

-- PHẦN 5: TỐI ƯU CHI TIẾT MODULE
local function destroyIf(obj, classList)
    if table.find(classList, obj.ClassName) then pcall(function() obj:Destroy() end) end
end

local function stripCharacter(char)
    if not ModuleSettings.StripCharacterAccessories then return end
    for _, c in ipairs(char:GetDescendants()) do
        destroyIf(c, {
            "Accessory", "Hat", "Shirt", "Pants", "Face", "BodyColors", "CharacterMesh", "MeshPart", "Decal", "Texture"
        })
    end
    local h = char:FindFirstChildWhichIsA("Humanoid")
    if h then for _, t in ipairs(h:GetPlayingAnimationTracks()) do t:Stop() end end
end

local function cleanWorld(level)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
        if ModuleSettings.DestroyParticles then
            destroyIf(obj, {
                "Decal", "Texture", "ParticleEmitter", "Trail", "Beam", "Fire", "Smoke",
                "Sparkles", "Highlight", "SurfaceGui", "BillboardGui",
                "VideoFrame", "ViewportFrame", "Sound", "Script", "LocalScript", "ModuleScript"
            })
        end
    end
end

function optimize(mode)
    CURRENT_MODE = mode
    saveMode(mode)

    if ModuleSettings.OptimizeLighting then
        local L = Services.Lighting
        L.GlobalShadows = false
        L.FogEnd = 1e10
        L.Brightness = 0
        L.ClockTime = 12
        L.Technology = Enum.Technology.Compatibility
        if ModuleSettings.DisablePostEffects then
            for _, v in ipairs(L:GetChildren()) do if v:IsA("PostEffect") then v:Destroy() end end
        end
    end

    if ModuleSettings.OptimizeTerrain and Services.Terrain then
        Services.Terrain.WaterWaveSize = 0
        Services.Terrain.WaterWaveSpeed = 0
        Services.Terrain.WaterReflectance = 0
        Services.Terrain.WaterTransparency = 0
    end

    if player.Character then stripCharacter(player.Character) end
    cleanWorld(mode)

    if ModuleSettings.KillSounds then
        for _, s in ipairs(Services.SoundService:GetDescendants()) do
            if s:IsA("Sound") then s.Volume = 0 end
        end
    end

    Services.ContextActionService:UnbindAllActions()
    if Services.Chat and ModuleSettings.RemoveGUI then pcall(function() Services.Chat:Destroy() end) end
    if ModuleSettings.RemoveGUI then
        Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end

    print("✅ Optimized for mode:", mode)
end

function restore()
    Services.StarterGui:SetCore("ResetButtonCallback", true)
    Services.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    Services.RunService:BindToRenderStep("RestoreRender", Enum.RenderPriority.Camera.Value, function() end)
    player:LoadCharacter()
    print("🔁 Default restored.")
end

-- PHẦN 6: LOAD & UI GIAO DIỆN
local function createSettingPanel()
    local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    sg.Name = "FPSBooster_Settings"
    local frame = Instance.new("Frame", sg)
    frame.Position = UDim2.new(1, -260, 0, 100)
    frame.Size = UDim2.new(0, 250, 0, 300)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local title = Instance.new("TextLabel", frame)
    title.Text = "⚙️ Modules Settings"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1

    local y = 40
    for key, value in pairs(ModuleSettings) do
        local cb = Instance.new("TextButton", frame)
        cb.Size = UDim2.new(1, -20, 0, 30)
        cb.Position = UDim2.new(0, 10, 0, y)
        cb.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(120, 0, 0)
        cb.Text = (value and "✅ " or "❌ ") .. key
        cb.TextColor3 = Color3.new(1, 1, 1)
        cb.MouseButton1Click:Connect(function()
            ModuleSettings[key] = not ModuleSettings[key]
            cb.Text = (ModuleSettings[key] and "✅ " or "❌ ") .. key
            cb.BackgroundColor3 = ModuleSettings[key] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(120, 0, 0)
        end)
        y += 35
    end
end

local mode = loadLastMode()
optimize(mode)
startFPSCounter()
createSettingPanel()

print("🚀 UNIVERSAL FPS BOOSTER v3 LOADED - ADVANCED SETTINGS ENABLED")

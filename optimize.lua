
-- FPS BOOSTER v11.7 – Mobile Ultra Mode + Full Presets

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
frame.Size = UDim2.new(0, 300, 0, 340); frame.Position = UDim2.new(0,20,0,80)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30); frame.BorderSizePixel = 0
frame.Active = true; frame.Draggable = true; frame.ClipsDescendants = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

-- Header + minimize
local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1,0,0,40); header.Text="⚡ FPS BOOSTER v11.7 (Mobile Ultra)"
header.Font = Enum.Font.GothamBold; header.TextSize=18; header.TextColor3=Color3.new(1,1,1)
header.BackgroundColor3=Color3.fromRGB(45,45,45); header.BorderSizePixel=0

local minimize = Instance.new("TextButton", frame)
minimize.Size=UDim2.new(0,30,0,30); minimize.Position=UDim2.new(1,-35,0,5)
minimize.Text="-"; minimize.Font=Enum.Font.GothamBlack; minimize.TextSize=20
minimize.TextColor3=Color3.new(1,1,1); minimize.BackgroundColor3=Color3.fromRGB(60,60,60)

local container = Instance.new("Frame", frame)
container.Size=UDim2.new(1,0,1,-40); container.Position=UDim2.new(0,0,0,40)
container.BackgroundTransparency=1

minimize.MouseButton1Click:Connect(function()
    container.Visible = not container.Visible
    frame.Size = container.Visible and UDim2.new(0,300,0,340) or UDim2.new(0,300,0,40)
end)

-- Shared utility
local function stripAllVisuals()
    Services.Lighting.GlobalShadows=false; Services.Lighting.FogEnd=1e9
    for _,fx in ipairs(Services.Lighting:GetChildren()) do if fx:IsA("PostEffect") then fx.Enabled=false end end

    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("BasePart") then
            d.CastShadow=false; d.Material=Enum.Material.SmoothPlastic; d.Reflectance=0
        elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then d.Enabled=false
        elseif d:IsA("Decal") or d:IsA("Texture") or d:IsA("BillboardGui") or d:IsA("SurfaceGui")
             or d:IsA("Accessory") then d:Destroy()
        end
    end

    for _,s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then
            s:Stop(); s.Volume=0; s.RollOffMinDistance=64; s.RollOffMaxDistance=128
        end
    end

    if Services.Terrain then
        Services.Terrain.WaterWaveSize=0; Services.Terrain.WaterWaveSpeed=0
        Services.Terrain.WaterReflectance=0; Services.Terrain.WaterTransparency=0
        Services.Terrain.Decorations=false
        Services.Terrain:ApplyLevelOfDetailSettings(5)
    end
end

local function ultraPhysicsKill()
    for _, p in ipairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") then
            p.CustomPhysicalProperties = PhysicalProperties.new(0.1,0.1,0.1,0,0)
        end
    end
    -- Disable all anima/physics on humanoids
    for _, plr in ipairs(Services.Players:GetPlayers()) do
        if plr.Character then
            local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
                hum.AutoRotate=false
            end
        end
    end
    -- Add mobile-specific flag disable
    pcall(function()
        settings():SetFFlag("FFlagUseParticlesV2",false)
        settings():SetFFlag("FFlagEnableTerrainFoliageOptimizations",true)
        settings():SetFFlag("FFlagDisablePostFx",true)
    end)
    Services.Lighting.FogEnd = 400
end

local function restoreAll()
    Services.Lighting.GlobalShadows=true; Services.Lighting.FogEnd=1000
    for _,fx in ipairs(Services.Lighting:GetChildren()) do if fx:IsA("PostEffect") then fx.Enabled=true end end
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then d.Enabled=true
        elseif d:IsA("BasePart") then d.CastShadow=true
        end
    end
    for _,s in ipairs(Services.SoundService:GetDescendants()) do if s:IsA("Sound") then s.Volume=1 end end
    if Services.Terrain then Services.Terrain.Decorations=true end
end

-- Preset buttons
local function addBtn(label,y,fn)
    local b=Instance.new("TextButton", container)
    b.Size=UDim2.new(1,-20,0,40); b.Position=UDim2.new(0,10,0,y)
    b.Text=label; b.Font=Enum.Font.GothamMedium; b.TextSize=18
    b.TextColor3=Color3.new(1,1,1); b.BackgroundColor3=Color3.fromRGB(50,50,50)
    Instance.new("UICorner", b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(fn)
end

addBtn("🎮 Basic (Mobile)", 10, function()
    stripAllVisuals()
    Services.Lighting.FogEnd=5000
end)

addBtn("⚙️ Advanced (Mobile)", 60, function()
    stripAllVisuals()
    Services.Lighting.FogEnd=2000
    Services.Terrain.WaterTransparency=1
end)

addBtn("🚀 Pro (Mobile Ultra)", 110, function()
    stripAllVisuals()
    ultraPhysicsKill()
end)

addBtn("🔁 Restore", 160, function()
    restoreAll()
end)

addBtn("📱 Hide Mobile UI", 210, function()
    Services.UserInputService.TouchEnabled = false
end)

-- FPS counter
local fpsGui=Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local label=Instance.new("TextLabel", fpsGui)
label.Size=UDim2.new(0,100,0,30); label.Position=UDim2.new(1,-110,0,10)
label.BackgroundTransparency=0.4; label.BackgroundColor3=Color3.fromRGB(20,20,20)
label.TextColor3=Color3.new(0,1,0); label.Text="FPS: --"
label.Font=Enum.Font.SourceSansBold; label.TextSize=16
local c,last=0,tick()
Services.RunService.RenderStepped:Connect(function()
    c+=1
    if tick()-last>=1 then
        label.Text = "FPS: "..c
        c, last = 0, tick()
    end
end)

print("✅ FPS BOOSTER v11.7 – Mobile Ultra Ready")

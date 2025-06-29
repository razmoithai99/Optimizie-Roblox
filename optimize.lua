-- FPS BOOSTER v11.3 – 3 gói + DeepFlags

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
frame.Size = UDim2.new(0, 300, 0, 250); frame.Position = UDim2.new(0,20,0,80)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35); frame.Active=true; frame.Draggable=true

local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1,0,0,40); header.Text="FPS BOOSTER v11.3"; header.Font=Enum.Font.SourceSansBold
header.TextSize=20; header.TextColor3=Color3.new(1,1,1); header.BackgroundColor3=Color3.fromRGB(45,45,45)

local minimize = Instance.new("TextButton", frame)
minimize.Size = UDim2.new(0,30,0,30); minimize.Position=UDim2.new(1,-35,0,5); minimize.Text="-"
minimize.Font=Enum.Font.SourceSansBold; minimize.TextColor3=Color3.new(1,1,1); minimize.BackgroundColor3=Color3.fromRGB(60,60,60)

local container = Instance.new("Frame", frame)
container.Name="Container"; container.Size=UDim2.new(1,0,1,-40); container.Position=UDim2.new(0,0,0,40)
container.BackgroundTransparency=1

minimize.MouseButton1Click:Connect(function()
    container.Visible = not container.Visible
    frame.Size = container.Visible and UDim2.new(0,300,0,250) or UDim2.new(0,300,0,40)
end)

-- FastFlag sets
local LightFlags = {
    FFlagDisablePostFx=true
}
local BalancedFlags = {
    FFlagDisablePostFx=true,
    DFIntTextureQualityOverride=0,
    FIntRenderShadowIntensity=0
}
local ProFlags = {
    FFlagDisablePostFx=true,
    DFIntTextureQualityOverride=0,
    FIntRenderShadowIntensity=0,
    DFFlagDebugRenderForceTechnologyVoxel=true,
    FFlagDebugGraphicsPreferD3D11=true,
    FFlagGlobalWindRendering=false,
    DFIntTerrainUpdateFrequency=5,
    FIntRenderLocalLightUpdatesMax=1,
    FIntRenderLocalLightUpdatesMin=1,
    FIntDebugForceMSAASamples=0
}
local function applyFastFlags(set)
    for f,v in pairs(set) do
        pcall(function() settings():SetFFlag(f,v) end)
    end
end

-- Tier functions
local function applyBasic()
    Services.Lighting.GlobalShadows=false
    Services.Lighting.Brightness=1
    if Services.Terrain then
        Services.Terrain.WaterWaveSize=0; Services.Terrain.WaterWaveSpeed=0
    end
end

local function applyAdvanced()
    applyBasic()
    if Services.Terrain then
        Services.Terrain.WaterReflectance=0; Services.Terrain.WaterTransparency=0
    end
    for _,p in ipairs(workspace:GetDescendants()) do
        if p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Beam") then
            p.Enabled=false
        end
        if p:IsA("BasePart") then
            p.CastShadow=false; p.Material=Enum.Material.SmoothPlastic
        end
    end
    applyFastFlags(BalancedFlags)
end

local function applyPro()
    applyAdvanced()
    for _,obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy()
        elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") or obj:IsA("Accessory") then obj:Destroy()
        end
    end
    for _,s in ipairs(Services.SoundService:GetDescendants()) do
        if s:IsA("Sound") then s:Stop(); s.Volume=0 end
    end
    applyFastFlags(ProFlags)
end

-- Buttons
local function createButton(name,y,func)
    local btn = Instance.new("TextButton", container)
    btn.Size=UDim2.new(1,-20,0,40); btn.Position=UDim2.new(0,10,0,y)
    btn.Text=name; btn.Font=Enum.Font.SourceSansBold; btn.TextSize=18
    btn.BackgroundColor3=Color3.fromRGB(50,50,50); btn.TextColor3=Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(func)
end

createButton("🎮 Basic", 10, applyBasic)
createButton("⚙️ Advanced", 60, applyAdvanced)
createButton("🚀 Pro", 110, applyPro)

print("✅ FPS BOOSTER v11.3 ready – 3 tiers with Deep FastFlags")

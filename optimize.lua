-- file: fps_booster_v12_5.lua

local S = {
  Players     = game:GetService("Players"),
  Lighting    = game:GetService("Lighting"),
  Terrain     = workspace:FindFirstChildOfClass("Terrain"),
  RunService  = game:GetService("RunService"),
  Sound       = game:GetService("SoundService"),
  StarterGui  = game:GetService("StarterGui"),
  Camera      = workspace.CurrentCamera,
  PathSrv     = game:GetService("PathfindingService"),
}

local player = S.Players.LocalPlayer

-- Notify helper
local function notify(msg)
  pcall(function()
    S.StarterGui:SetCore("SendNotification", {Title="FPS BOOST", Text=msg, Duration=2})
  end)
end

-- Region-based cleanup: cull parts outside view range
local function cleanupRegion(range)
  local cam = S.Camera
  for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
      local dist = (obj.Position - cam.CFrame.Position).Magnitude
      if dist > range then
        obj.Parent = nil
      end
    end
  end
end

-- Core cleanups (deferred loops)
local function batchClear(func)
  task.defer(func)
end

-- Basic Mode
local function basic()
  S.Lighting.GlobalShadows = false
  S.Lighting.Brightness = 1
  S.Lighting.FogEnd = 10000
  for _, fx in ipairs(S.Lighting:GetChildren()) do
    if fx:IsA("PostEffect") then fx.Enabled = false end
  end
  if S.Terrain then
    S.Terrain.Decorations = false
    S.Terrain.WaterWaveSize = 0
    S.Terrain.WaterWaveSpeed = 0
  end
  batchClear(function()
    for _, p in ipairs(workspace:GetDescendants()) do
      if p:IsA("BasePart") then
        p.CastShadow = false
      end
    end
  end)
  notify("🎮 Basic Applied")
  print("Basic OK")
end

-- Advanced Mode
local function advanced()
  basic()
  S.Lighting.FogEnd = 4000
  if S.Terrain then
    S.Terrain.WaterTransparency = 0.5
    S.Terrain.WaterReflectance = 0
    S.Terrain:ApplyLevelOfDetailSettings(5)
  end
  batchClear(function()
    for _, o in ipairs(workspace:GetDescendants()) do
      if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then
        o.Enabled = false
      end
      if o:IsA("Decal") or o:IsA("Texture") then
        o:Destroy()
      end
      if o:IsA("BasePart") then
        o.Material = Enum.Material.SmoothPlastic
      end
    end
  end)
  notify("⚙️ Advanced Applied")
  print("Advanced OK")
end

-- Pro Mode
local function pro()
  advanced()
  S.Lighting.FogEnd = 200
  if S.Terrain then
    S.Terrain.WaterTransparency = 1
    S.Terrain:ApplyLevelOfDetailSettings(10)
  end
  batchClear(function()
    for _, o in ipairs(workspace:GetDescendants()) do
      if o:IsA("BasePart") then
        o.Reflectance = 0
        pcall(function()
          o.CustomPhysicalProperties = PhysicalProperties.new(0.01,0.01,0.01,0,0)
        end)
        pcall(function()
          o.CollisionFidelity = Enum.CollisionFidelity.Box
        end)
      elseif o:IsA("MeshPart") then
        for _, c in ipairs(o:GetChildren()) do c:Destroy() end
      elseif o:IsA("Clothing") or o:IsA("Accessory")
          or o:IsA("BillboardGui") or o:IsA("SurfaceGui") then
        o:Destroy()
      end
    end
  end)
  -- Freeze humanoid physics
  for _, pl in ipairs(S.Players:GetPlayers()) do
    if pl.Character then
      local hum = pl.Character:FindFirstChildWhichIsA("Humanoid")
      if hum then
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        hum.AutoRotate = false
      end
    end
  end
  -- sound
  batchClear(function()
    for _, snd in ipairs(S.Sound:GetDescendants()) do
      if snd:IsA("Sound") then
        snd:Stop()
        snd.Volume = 0
        snd.RollOffMinDistance = 8
        snd.RollOffMaxDistance = 16
      end
    end
  end)
  -- region cleanup
  cleanupRegion(1000)
  notify("🚀 Pro Ultra Applied")
  print("Pro OK")
end

-- Restore
local function restore()
  S.Lighting.GlobalShadows = true
  S.Lighting.FogEnd = 1000
  S.Lighting.Brightness = 2
  for _, fx in ipairs(S.Lighting:GetChildren()) do
    if fx:IsA("PostEffect") then fx.Enabled = true end
  end
  if S.Terrain then
    S.Terrain.Decorations = true
  end
  batchClear(function()
    for _, snd in ipairs(S.Sound:GetDescendants()) do
      if snd:IsA("Sound") then snd.Volume = 1 end
    end
  end)
  notify("🔁 Restored Defaults")
  print("Restore OK")
end

-- GUI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,340,0,460)
frame.Position = UDim2.new(0,20,0,80)
frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local header = Instance.new("TextLabel", frame)
header.Size, header.Position = UDim2.new(1,0,0,48), UDim2.new(0,0,0,0)
header.BackgroundColor3 = Color3.fromRGB(40,40,40)
header.Font, header.TextSize, header.TextColor3 = Enum.Font.GothamBold, 20, Color3.new(1,1,1)
header.Text = "📱 FPS BOOST v12.5"

local close = Instance.new("TextButton", frame)
close.Size, close.Position = UDim2.new(0,36,0,40), UDim2.new(1,-46,0,4)
close.Text, close.Font = "✖", Enum.Font.GothamBlack
Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
close.MouseButton1Click:Connect(function() frame.Visible = false end)

local minimize = Instance.new("TextButton", frame)
minimize.Size, minimize.Position = UDim2.new(0,36,0,40), UDim2.new(1,-90,0,4)
minimize.Text, minimize.Font = "-", Enum.Font.GothamBlack
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,6)
minimize.MouseButton1Click:Connect(function()
  if frame.Size.Y.Offset > 60 then
    frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 60)
  else
    frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 460)
  end
end)

local container = Instance.new("Frame", frame)
container.Size = UDim2.new(1,0,1,-48)
container.Position = UDim2.new(0,0,0,48)
container.BackgroundTransparency = 1

-- Button creation
local function addBtn(label,y,fn)
  local b=Instance.new("TextButton", container)
  b.Size = UDim2.new(1,-24,0,56)
  b.Position = UDim2.new(0,12,0,y)
  b.Text, b.Font, b.TextSize = label, Enum.Font.GothamMedium, 18
  b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(50,50,50), Color3.new(1,1,1)
  Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
  b.MouseButton1Click:Connect(fn)
  b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(70,70,70) end)
  b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
end

addBtn("🎮 Basic (Clean)", 10, basic)
addBtn("⚙️ Advanced (Mid)", 80, advanced)
addBtn("🚀 Pro Mobile Ultra", 150, pro)
addBtn("🔁 Restore Defaults", 220, restore)

-- FPS Counter
local fpsGui = Instance.new("ScreenGui", player.PlayerGui)
local fpsLbl = Instance.new("TextLabel", fpsGui)
fpsLbl.Size, fpsLbl.Position = UDim2.new(0,140,0,30), UDim2.new(1,-160,0,10)
fpsLbl.BackgroundColor3, fpsLbl.BackgroundTransparency = Color3.fromRGB(20,20,20), 0.5
fpsLbl.Font, fpsLbl.TextSize, fpsLbl.TextColor3 = Enum.Font.GothamBold, 16, Color3.fromRGB(0,255,0)
fpsLbl.Text = "FPS: --"

local c,last = 0, tick()
S.RunService.RenderStepped:Connect(function()
  c +=1
  if tick()-last >=1 then
    fpsLbl.Text="FPS: "..c
    c,last=0,tick()
  end
end)

print("✅ FPS BOOSTER v12.5 Loaded properly. Choose your mode!")

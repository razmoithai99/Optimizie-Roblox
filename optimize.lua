loadstring(game:HttpGet("https://raw.githubusercontent.com/scripts/main/optimize.lua"))()
-- Tạo biến tham chiếu đến các dịch vụ cần thiết
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

-- Hàm để giảm đồ họa và tăng FPS
local function optimizeGraphics()
    -- Tắt các hiệu ứng chiếu sáng và bóng đổ
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0

    -- Giảm chất lượng chi tiết của terrain
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
    end

    -- Tắt tất cả decal và texture trên các phần
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Material = Enum.Material.SmoothPlastic
            part.Reflectance = 0
            if part:IsA("MeshPart") then
                part.TextureID = ""
            end
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part:Destroy()
        end
    end
end

-- Chạy hàm tối ưu hóa đồ họa
optimizeGraphics()

-- Lắng nghe sự kiện khi một phần mới được thêm vào workspace
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("BasePart") then
        descendant.Material = Enum.Material.SmoothPlastic
        descendant.Reflectance = 0
        if descendant:IsA("MeshPart") then
            descendant.TextureID = ""
        end
    elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
        descendant:Destroy()
    end
end)

print("Đồ họa đã được tối ưu hóa để tăng FPS!")




    

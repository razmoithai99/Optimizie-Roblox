--[==[ FPS BOOSTER v13.1 – MOBILE UI GỌN + SỬA NÚT MINIMIZE + DEBUG TỪNG NÚT ]==]
-- ✅ Thêm lại nút Minimize (ẩn hiện panel)
-- ✅ Giảm kích thước menu phù hợp màn hình điện thoại (240x260)
-- ✅ In debug log khi người dùng bấm để kiểm tra trigger hoạt động

-- Các phần tối ưu giữ nguyên bên trên

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
header.Text = "⚙️ FPS BOOST v13.1"
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

-- FPS giữ nguyên như cũ

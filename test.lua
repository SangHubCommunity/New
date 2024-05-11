-- Tạo một ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo một TextButton để hiển thị chữ "On" và "Off"
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.5, -25)
button.Text = "Off"
button.Parent = gui

-- Tạo một biến để lưu trạng thái của nút
local isOn = false

-- Thiết lập hàm để xử lý khi nút được nhấn
button.MouseButton1Click:Connect(function()
    isOn = not isOn
    if isOn then
        button.Text = "On"
        while isOn do
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, true)
            wait(0.1)  -- 100 milliseconds
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, false)
            wait(0.1)  -- 100 milliseconds
        end
    else
        button.Text = "Off"
    end
end)

-- Thiết lập hàm để di chuyển GUI bằng cảm ứng
local dragging = false
button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and dragging then
        button.Position = UDim2.new(0, input.Position.X - button.AbsoluteSize.X / 2, 0, input.Position.Y - button.AbsoluteSize.Y / 2)
    end
end)

button.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Thêm một hàm để đảm bảo rằng biến isOn được đặt lại khi bạn nhấn lại nút
button.MouseButton1Click:Connect(function()
    isOn = not isOn
end)
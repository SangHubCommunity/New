-- Tạo một ScreenGui
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo một TextButton để hiển thị chữ "On" và "Off"
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.5, -25)
button.Text = "Auto Click: Off"
button.Parent = gui

-- Tạo một biến để lưu trạng thái của chế độ auto click
local autoClickEnabled = false

-- Thiết lập hàm để xử lý khi nút được nhấn
button.MouseButton1Click:Connect(function()
    autoClickEnabled = not autoClickEnabled
    if autoClickEnabled then
        button.Text = "Auto Click: On"
        while autoClickEnabled do
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, true)
            wait(0.1)  -- 100 milliseconds
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, false)
            wait(0.1)  -- 100 milliseconds
        end
    else
        button.Text = "Auto Click: Off"
    end
end)
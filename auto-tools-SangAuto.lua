local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.5, -25)
button.Text = "Auto Click: Off"
button.Parent = gui

local autoClickEnabled = false

button.MouseButton1Click:Connect(function()
    autoClickEnabled = not autoClickEnabled
    if autoClickEnabled then
        button.Text = "Auto Click: On"
    else
        button.Text = "Auto Click: Off"
    end
end)

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

game:GetService("UserInputService").TouchMoved:Connect(function(input)
    if dragging then
        local newPosition = button.Position + UDim2.new(0, input.Delta.X, 0, input.Delta.Y)
        button.Position = UDim2.new(0, math.clamp(newPosition.X.Offset, 0, game:GetService("GuiService"):GetScreenResolution().X - button.AbsoluteSize.X), 0, math.clamp(newPosition.Y.Offset, 0, game:GetService("GuiService"):GetScreenResolution().Y - button.AbsoluteSize.Y))
    end
end)

while true do
    if autoClickEnabled then
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, true)
        wait(0.1)  -- 100 milliseconds
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(Vector2.new(0, 0), Enum.UserInputType.MouseButton1, false)
        wait(0.1)  -- 100 milliseconds
    end
    wait(0.1)
end
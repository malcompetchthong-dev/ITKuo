--// KUOHUB ADVANCED + FUTURISTIC (FULL)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "KuoHub"

-- MAIN
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- GLOW BORDER
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(170,0,255)
Stroke.Thickness = 2
Stroke.Transparency = 0.2

-- TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundTransparency = 1

-- TITLE (ม่วงชัด)
local Title = Instance.new("TextLabel", Top)
Title.Text = "KuoHub"
Title.Size = UDim2.new(1,-120,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(170,0,255)

-- =========================
-- CLOSE (×)
-- =========================
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0,35,0,35)
Close.Position = UDim2.new(1,-40,0.5,-17)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.BackgroundColor3 = Color3.fromRGB(200,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)

-- =========================
-- MINIMIZE (- / +)
-- =========================
local Min = Instance.new("TextButton", Top)
Min.Size = UDim2.new(0,35,0,35)
Min.Position = UDim2.new(1,-80,0.5,-17)
Min.Text = "-"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 18
Min.BackgroundColor3 = Color3.fromRGB(80,80,80)
Min.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Min).CornerRadius = UDim.new(1,0)

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-20,1,-60)
Content.Position = UDim2.new(0,10,0,50)
Content.BackgroundTransparency = 1

local minimized = false

Min.MouseButton1Click:Connect(function()
minimized = not minimized

if minimized then  
    Content.Visible = false  
    TweenService:Create(Main, TweenInfo.new(0.25), {  
        Size = UDim2.new(0,550,0,45)  
    }):Play()  
    Min.Text = "+"  
else  
    Content.Visible = true  
    TweenService:Create(Main, TweenInfo.new(0.25), {  
        Size = UDim2.new(0,550,0,350)  
    }):Play()  
    Min.Text = "-"  
end

end)

-- =========================
-- DRAG (ลื่น ๆ)
-- =========================
local dragging = false
local dragStart, startPos

Top.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = Main.Position
end
end)

Top.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
local delta = input.Position - dragStart
Main.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)

Main.BackgroundTransparency = 1
TweenService:Create(Main, TweenInfo.new(0.4), {
BackgroundTransparency = 0.1
}):Play()

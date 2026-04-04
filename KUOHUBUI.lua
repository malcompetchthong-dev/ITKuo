--// KUOHUB FULL ADVANCED + FUTURISTIC + MINIMIZE FIX (Tab หายจริง)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "KuoHub"

-- MAIN
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0, 0, 0.5, -175) -- ฝั่งซ้าย
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BackgroundTransparency = 0.15
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- GLOW BORDER
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(170,0,255)
Stroke.Thickness = 2
Stroke.Transparency = 0.2

-- TOP
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,45)
Top.BackgroundTransparency = 1

-- TITLE + GRADIENT
local Title = Instance.new("TextLabel", Top)
Title.Text = "KuoHub"
Title.Size = UDim2.new(1,-100,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(170,0,255)

local Gradient = Instance.new("UIGradient", Title)
Gradient.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, Color3.fromRGB(170,0,255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(0,200,255))
}

-- LINE
local Line = Instance.new("Frame", Top)
Line.Size = UDim2.new(0,80,0,2)
Line.Position = UDim2.new(0,10,1,-2)
Line.BackgroundColor3 = Color3.fromRGB(170,0,255)
Line.BorderSizePixel = 0

-- SIDE
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0,140,1,-45)
Side.Position = UDim2.new(0,0,0,45)
Side.BackgroundTransparency = 1

-- PAGES FOLDER
local Pages = Instance.new("Folder", Main)

-- CURRENT PAGE TRACKER
local CurrentPage = nil

-- MINIMIZE & CLOSE
local Minimize = Instance.new("TextButton", Top)
Minimize.Size = UDim2.new(0,40,1,0)
Minimize.Position = UDim2.new(1,-80,0,0)
Minimize.Text = "–"
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.fromRGB(200,200,200)

local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.new(0,40,1,0)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundTransparency = 1
Close.TextColor3 = Color3.fromRGB(255,80,80)

Close.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)

local minimized = false

Minimize.MouseButton1Click:Connect(function()
minimized = not minimized
Minimize.Text = minimized and "+" or "–"

if minimized then  
    -- ลดขนาด GUI  
    TweenService:Create(Main,TweenInfo.new(0.3),{Size=UDim2.new(0,550,0,45)}):Play()  
    Side.Visible = false  
    if CurrentPage then  
        CurrentPage.Visible = false -- ซ่อน Tab จริง  
    end  
else  
    -- ขยาย GUI  
    TweenService:Create(Main,TweenInfo.new(0.3),{Size=UDim2.new(0,550,0,350)}):Play()  
    task.wait(0.15)  
    Side.Visible = true  
    if CurrentPage then  
        CurrentPage.Visible = true -- เปิด Tab กลับ  
    end  
end

end)

-- WINDOW SYSTEM
local Window = {}

function Window:Tab(name)
local Page = Instance.new("ScrollingFrame", Pages)
Page.Size = UDim2.new(1,-150,1,-55)
Page.Position = UDim2.new(0,150,0,50)
Page.CanvasSize = UDim2.new(0,0,0,500)
Page.ScrollBarThickness = 4
Page.Visible = false
Page.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Page)  
Layout.Padding = UDim.new(0,8)  

-- TAB BUTTON  
local Btn = Instance.new("TextButton", Side)  
Btn.Size = UDim2.new(1,-10,0,40)  
Btn.Position = UDim2.new(0,5,0,#Side:GetChildren()*45)  
Btn.Text = name  
Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)  
Btn.TextColor3 = Color3.fromRGB(200,200,200)  
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)  

Btn.MouseEnter:Connect(function()  
    TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(120,0,200)}):Play()  
end)  
Btn.MouseLeave:Connect(function()  
    TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(30,30,30)}):Play()  
end)  

Btn.MouseButton1Click:Connect(function()  
    -- ซ่อนทุก Page  
    for _,v in pairs(Pages:GetChildren()) do  
        if v:IsA("ScrollingFrame") then  
            v.Visible = false  
        end  
    end  
    Page.Visible = true  
    CurrentPage = Page -- บันทึก Tab ปัจจุบัน  
end)  

-- TAB SYSTEM  
local Tab = {}  

function Tab:Section(text)  
    local Label = Instance.new("TextLabel", Page)  
    Label.Size = UDim2.new(1,-10,0,25)  
    Label.BackgroundTransparency = 1  
    Label.Text = text  
    Label.TextColor3 = Color3.fromRGB(170,0,255)  
    Label.Font = Enum.Font.GothamBold  
    Label.TextSize = 16  
    Label.TextXAlignment = Enum.TextXAlignment.Left  
end  

function Tab:Button(config)  
    local Btn = Instance.new("TextButton", Page)  
    Btn.Size = UDim2.new(1,-10,0,35)  
    Btn.Text = config.Title or "Button"  
    Btn.BackgroundColor3 = Color3.fromRGB(100,0,200)  
    Btn.TextColor3 = Color3.new(1,1,1)  
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)  

    Btn.MouseButton1Click:Connect(function()  
        if config.Callback then  
            config.Callback()  
        end  
    end)  
end  

function Tab:Toggle(config)  
    local Frame = Instance.new("Frame", Page)  
    Frame.Size = UDim2.new(1,-10,0,45)  
    Frame.BackgroundTransparency = 1  

    local TitleLbl = Instance.new("TextLabel", Frame)  
    TitleLbl.Size = UDim2.new(1,-60,0,20)  
    TitleLbl.Text = config.Title or "Toggle"  
    TitleLbl.TextColor3 = Color3.fromRGB(220,220,220)  
    TitleLbl.Font = Enum.Font.GothamBold  
    TitleLbl.TextSize = 14  
    TitleLbl.BackgroundTransparency = 1  
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left  

    local DescLbl = Instance.new("TextLabel", Frame)  
    DescLbl.Size = UDim2.new(1,-60,0,18)  
    DescLbl.Position = UDim2.new(0,0,0,20)  
    DescLbl.Text = config.Desc or ""  
    DescLbl.TextColor3 = Color3.fromRGB(150,150,150)  
    DescLbl.Font = Enum.Font.Gotham  
    DescLbl.TextSize = 12  
    DescLbl.BackgroundTransparency = 1  
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left  

    local ToggleFrame = Instance.new("Frame", Frame)  
    ToggleFrame.Size = UDim2.new(0,40,0,20)  
    ToggleFrame.Position = UDim2.new(1,-45,0.5,-10)  
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)  
    ToggleFrame.Active = true  
    ToggleFrame.Selectable = true  
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(1,0)  

    local Circle = Instance.new("Frame", ToggleFrame)  
    Circle.Size = UDim2.new(0,18,0,18)  
    Circle.Position = UDim2.new(0,1,0.5,-9)  
    Circle.BackgroundColor3 = Color3.new(1,1,1)  
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)  

    local state = config.Value or false  

    local function update()  
        TweenService:Create(Circle,TweenInfo.new(0.2),{  
            Position = state and UDim2.new(1,-19,0.5,-9) or UDim2.new(0,1,0.5,-9)  
        }):Play()  
        TweenService:Create(ToggleFrame,TweenInfo.new(0.2),{  
            BackgroundColor3 = state and Color3.fromRGB(170,0,255) or Color3.fromRGB(60,60,60)  
        }):Play()  
    end  

    update()  

    ToggleFrame.InputEnded:Connect(function(i)  
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then  
            state = not state  
            update()  
            if config.Callback then  
                config.Callback(state)  
            end  
        end  
    end)  

    if config.Callback then  
        config.Callback(state)  
    end  
end  

return Tab

end

function Window:AddMinimizeButton(config)
local btn = Instance.new("ImageButton", ScreenGui)
btn.Size = UDim2.new(0,50,0,50)
btn.Position = UDim2.new(0,20,0.5,-25)
btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
btn.Image = config.Button.Image or ""
btn.BackgroundTransparency = config.Button.BackgroundTransparency or 0
btn.Active = true
btn.Draggable = true

local corner = Instance.new("UICorner", btn)  
corner.CornerRadius = config.Corner.CornerRadius or UDim.new(1,0)  

local visible = true  

btn.MouseButton1Click:Connect(function()  
    visible = not visible  
    Main.Visible = visible  
end)

end
return Window

--// KUOHUB LIBRARY (STABLE FULL)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Library = {}

--// 🔒 กัน UI ซ้ำ
if game.CoreGui:FindFirstChild("KUOHUB_UI") then
    game.CoreGui:FindFirstChild("KUOHUB_UI"):Destroy()
end

--// THEMES
local Themes = {
    Dark = {
        Main = Color3.fromRGB(32,32,36),
        Top = Color3.fromRGB(40,40,46),
        Text = Color3.fromRGB(235,235,235),
        Border = Color3.fromRGB(90,90,110)
    },

    SoftDark = {
        Main = Color3.fromRGB(38,38,44),
        Top = Color3.fromRGB(46,46,54),
        Text = Color3.fromRGB(240,240,240),
        Border = Color3.fromRGB(120,120,150)
    }
}

--// 🌈 RAINBOW
local rainbowColors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211)
}

local function tweenStrokeColor(stroke)
    task.spawn(function()
        local i = 1
        while stroke and stroke.Parent do
            TweenService:Create(stroke,TweenInfo.new(1),{Color = rainbowColors[i]}):Play()
            i += 1
            if i > #rainbowColors then i = 1 end
            task.wait(1)
        end
    end)
end

--// DRAG (มือถือ + PC)
local function makeDraggable(frame, dragBar)
    local dragging, dragStart, startPos

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    dragBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

--// WINDOW
function Library:Window(config)
    local Theme = Themes[config.Theme] or Themes.SoftDark

    local gui = Instance.new("ScreenGui")
    gui.Name = "KUOHUB_UI"
    gui.Parent = game.CoreGui

    -- MAIN
    local Main = Instance.new("Frame", gui)
    Main.Size = config.Config.Size or UDim2.new(0,500,0,400)
    Main.Position = UDim2.new(0.5,-250,0.5,-200)
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

    local Stroke = Instance.new("UIStroke",Main)
    Stroke.Color = Theme.Border
    tweenStrokeColor(Stroke)

    -- TOP
    local Top = Instance.new("Frame",Main)
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = Theme.Top
    Top.BorderSizePixel = 0
    Instance.new("UICorner",Top).CornerRadius = UDim.new(0,12)

    -- 🖼️ ICON
    local IconImage
    if config.Icon then
        IconImage = Instance.new("ImageLabel", Top)
        IconImage.Size = UDim2.new(0,24,0,24)
        IconImage.Position = UDim2.new(0,8,0.5,-12)
        IconImage.BackgroundTransparency = 1

        if tostring(config.Icon):find("rbxassetid://") then
            IconImage.Image = config.Icon
        else
            IconImage.Image = "rbxassetid://" .. tostring(config.Icon)
        end
    end

    -- TITLE
    local Title = Instance.new("TextLabel",Top)
    Title.Size = UDim2.new(1,-120,1,0)
    Title.Position = UDim2.new(0, IconImage and 36 or 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = config.Title or "KUOHUB"
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    -- CLOSE
    local Close = Instance.new("TextButton",Top)
    Close.Size = UDim2.new(0,30,0,30)
    Close.Position = UDim2.new(1,-35,0.5,-15)
    Close.Text = "X"
    Close.BackgroundColor3 = Color3.fromRGB(200,80,80)
    Close.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",Close)

    Close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- MINIMIZE
    local Minimize = Instance.new("TextButton",Top)
    Minimize.Size = UDim2.new(0,30,0,30)
    Minimize.Position = UDim2.new(1,-70,0.5,-15)
    Minimize.Text = "-"
    Minimize.BackgroundColor3 = Color3.fromRGB(90,90,120)
    Minimize.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",Minimize)

    local minimized = false
    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        for _,v in pairs(Main:GetChildren()) do
            if v ~= Top then
                v.Visible = not minimized
            end
        end
        Minimize.Text = minimized and "+" or "-"
    end)

    -- CONTAINER
    local Container = Instance.new("Frame",Main)
    Container.Size = UDim2.new(1,-20,1,-60)
    Container.Position = UDim2.new(0,10,0,50)
    Container.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout",Container)
    Layout.Padding = UDim.new(0,6)

    -- DRAG ทั้งหน้าต่าง
    makeDraggable(Main, Main)

    -- WINDOW OBJECT
    local Window = {}

    function Window:Tab(cfg)
        local TabObj = {}
        TabObj.Container = Container

        -- TOGGLE
        function TabObj:AddToggle(tcfg)
            local Frame = Instance.new("Frame",Container)
            Frame.Size = UDim2.new(1,0,0,40)
            Frame.BackgroundTransparency = 1

            local Btn = Instance.new("TextButton",Frame)
            Btn.Size = UDim2.new(1,0,1,0)
            Btn.BackgroundTransparency = 1
            Btn.Text = ""

            local Text = Instance.new("TextLabel",Frame)
            Text.Size = UDim2.new(1,-60,1,0)
            Text.Position = UDim2.new(0,10,0,0)
            Text.BackgroundTransparency = 1
            Text.TextXAlignment = Enum.TextXAlignment.Left
            Text.Font = Enum.Font.Gotham
            Text.TextSize = 14
            Text.TextColor3 = Theme.Text
            Text.Text = tcfg.Title or "Toggle"

            local Box = Instance.new("Frame",Frame)
            Box.Size = UDim2.new(0,40,0,20)
            Box.Position = UDim2.new(1,-50,0.5,-10)
            Box.BackgroundColor3 = Color3.fromRGB(60,60,60)
            Instance.new("UICorner",Box).CornerRadius = UDim.new(1,0)

            local Circle = Instance.new("Frame",Box)
            Circle.Size = UDim2.new(0,18,0,18)
            Circle.Position = UDim2.new(0,1,0.5,-9)
            Circle.BackgroundColor3 = Color3.new(1,1,1)
            Instance.new("UICorner",Circle)

            local state = tcfg.Value or false

            local function set(v)
                state = v
                if state then
                    Circle:TweenPosition(UDim2.new(1,-19,0.5,-9),"Out","Quad",0.2,true)
                    Box.BackgroundColor3 = Color3.fromRGB(0,170,255)
                else
                    Circle:TweenPosition(UDim2.new(0,1,0.5,-9),"Out","Quad",0.2,true)
                    Box.BackgroundColor3 = Color3.fromRGB(60,60,60)
                end
                if tcfg.Callback then
                    tcfg.Callback(state)
                end
            end

            Btn.MouseButton1Click:Connect(function()
                set(not state)
            end)

            task.defer(function()
                set(state)
            end)

            return {Set = set}
        end

        return TabObj
    end

    function Window:AddMinimizeButton(cfg)
        -- รองรับเรียกแยก (ไม่พัง)
    end

    return Window
end

return Library

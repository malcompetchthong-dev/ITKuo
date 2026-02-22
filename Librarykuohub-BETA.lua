--// KUOHUB LIBRARY (STABLE CLEAN)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Library = {}

-- 🔒 กัน UI ซ้ำ
if game.CoreGui:FindFirstChild("KUOHUB_UI") then
    game.CoreGui:FindFirstChild("KUOHUB_UI"):Destroy()
end

-- THEMES
local Themes = {
    Dark = {
        Main = Color3.fromRGB(20,20,20),
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

-- 🌈 RAINBOW
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

-- DRAG (มือถือ + PC)
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

-- WINDOW
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

    -- ICON
    local IconImage
    if config.Icon then
        IconImage = Instance.new("ImageLabel", Top)
        IconImage.Size = UDim2.new(0,24,0,24)
        IconImage.Position = UDim2.new(0,8,0.5,-12)
        IconImage.BackgroundTransparency = 1
        IconImage.Image = tostring(config.Icon):find("rbxassetid://")
            and config.Icon
            or ("rbxassetid://" .. tostring(config.Icon))
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

    -- DRAG
    makeDraggable(Main, Main)

    -- WINDOW OBJECT
    local Window = {}

    function Window:Tab()
        local TabObj = {}
        TabObj.Container = Container

        -- ✅ TOGGLE (เวอร์ชันคุณ แบบแก้แล้ว)
        function TabObj:AddToggle(Configs)
            Configs = Configs or {}

            local TName = Configs.Name or "Toggle"
            local Default = Configs.Default or false
            local Callback = Configs.Callback or function() end

            local Frame = Instance.new("Frame", Container)
            Frame.Size = UDim2.new(1,0,0,30)
            Frame.BackgroundTransparency = 1

            local Button = Instance.new("TextButton", Frame)
            Button.Size = UDim2.new(1,0,1,0)
            Button.BackgroundTransparency = 1
            Button.Text = ""

            local Text = Instance.new("TextLabel", Frame)
            Text.Size = UDim2.new(1,-70,1,0)
            Text.Position = UDim2.new(0,15,0,0)
            Text.BackgroundTransparency = 1
            Text.TextXAlignment = Enum.TextXAlignment.Left
            Text.Font = Enum.Font.Gotham
            Text.TextSize = 13
            Text.TextColor3 = Theme.Text
            Text.Text = TName

            local ToggleFrame = Instance.new("Frame", Frame)
            ToggleFrame.Size = UDim2.new(0,36,0,18)
            ToggleFrame.AnchorPoint = Vector2.new(1,0.5)
            ToggleFrame.Position = UDim2.new(1,-10,0.5,0)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(1,0)

            local ToggleIcon = Instance.new("Frame", ToggleFrame)
            ToggleIcon.Size = UDim2.new(0,14,0,14)
            ToggleIcon.Position = UDim2.new(0,2,0.5,-7)
            ToggleIcon.BackgroundColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", ToggleIcon).CornerRadius = UDim.new(1,0)

            local state = Default
            local busy = false

            local function SetToggle(v)
                if busy then return end
                busy = true
                state = v

                if state then
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(0,170,255)
                    ToggleIcon:TweenPosition(UDim2.new(1,-16,0.5,-7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
                else
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
                    ToggleIcon:TweenPosition(UDim2.new(0,2,0.5,-7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
                end

                task.spawn(function()
                    Callback(state)
                end)

                task.delay(0.25, function()
                    busy = false
                end)
            end

            Button.Activated:Connect(function()
                SetToggle(not state)
            end)

            task.defer(function()
                SetToggle(state)
            end)

            return {
                Set = SetToggle,
                GetToggle = function() return state end
            }
        end

        return TabObj
    end

    function Window:AddMinimizeButton()
        -- รองรับเรียกแยก
    end

    return Window
end

return Library

--// KUOHUB UI LIBRARY FIXED

local Library = {}
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Http = game:GetService("HttpService")

--================ THEMES ================--

local Themes = {
    SoftDark = {
        Main = Color3.fromRGB(38,38,38),
        Top = Color3.fromRGB(48,48,48),
        Sidebar = Color3.fromRGB(42,42,42),
        Item = Color3.fromRGB(55,55,55),
        Border = Color3.fromRGB(70,70,70),
        Text = Color3.fromRGB(235,235,235),
        SubText = Color3.fromRGB(180,180,180),
        Accent = Color3.fromRGB(120,120,120)
    },

    Light = {
        Main = Color3.fromRGB(240,240,240),
        Top = Color3.fromRGB(225,225,225),
        Sidebar = Color3.fromRGB(235,235,235),
        Item = Color3.fromRGB(220,220,220),
        Border = Color3.fromRGB(200,200,200),
        Text = Color3.fromRGB(40,40,40),
        SubText = Color3.fromRGB(80,80,80),
        Accent = Color3.fromRGB(120,120,120)
    }
}

--================ DRAG ================--

local function Dragify(Frame, DragArea)
    local dragging, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    DragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement or
            input.UserInputType == Enum.UserInputType.Touch
        ) then
            update(input)
        end
    end)
end

--================ WINDOW ================--

function Library:Window(config)

    local Theme = Themes[config.Theme] or Themes.SoftDark

    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "KUOHUB_UI"

    local Main = Instance.new("Frame", gui)
    Main.Size = config.Config.Size or UDim2.new(0,500,0,400)
    Main.Position = UDim2.new(0.5,-250,0.5,-200)
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

    local Stroke = Instance.new("UIStroke",Main)
    Stroke.Color = Theme.Border

    -- TOP
    local Top = Instance.new("Frame",Main)
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = Theme.Top
    Top.BorderSizePixel = 0
    Instance.new("UICorner",Top).CornerRadius = UDim.new(0,12)

    local Title = Instance.new("TextLabel",Top)
    Title.Size = UDim2.new(1,-120,1,0)
    Title.Position = UDim2.new(0,10,0,0)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = config.Title or "KUOHUB"
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    -- CLOSE
    local Close = Instance.new("TextButton",Top)
    Close.Size = UDim2.new(0,32,0,32)
    Close.Position = UDim2.new(1,-40,0.5,-16)
    Close.Text = "X"
    Close.BackgroundColor3 = Theme.Item
    Close.TextColor3 = Theme.Text
    Instance.new("UICorner",Close).CornerRadius = UDim.new(1,0)

    Close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- MIN
    local Min = Instance.new("TextButton",Top)
    Min.Size = UDim2.new(0,32,0,32)
    Min.Position = UDim2.new(1,-80,0.5,-16)
    Min.Text = "-"
    Min.BackgroundColor3 = Theme.Item
    Min.TextColor3 = Theme.Text
    Instance.new("UICorner",Min).CornerRadius = UDim.new(1,0)

    -- CONTENT
    local Content = Instance.new("Frame",Main)
    Content.Position = UDim2.new(0,0,0,50)
    Content.Size = UDim2.new(1,0,1,-50)
    Content.BackgroundTransparency = 1

    Min.MouseButton1Click:Connect(function()
        Content.Visible = not Content.Visible
        Min.Text = Content.Visible and "-" or "+"
    end)

    Dragify(Main,Top)

    --================ TAB ================--

    local Tabs = {}
    local CurrentTab

    local WindowFuncs = {}

    function WindowFuncs:Tab(tabConfig)

        local TabFrame = Instance.new("ScrollingFrame",Content)
        TabFrame.Size = UDim2.new(1,0,1,0)
        TabFrame.CanvasSize = UDim2.new(0,0,0,0)
        TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabFrame.ScrollBarThickness = 4
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false

        local layout = Instance.new("UIListLayout",TabFrame)
        layout.Padding = UDim.new(0,8)

        table.insert(Tabs,TabFrame)

        if not CurrentTab then
            CurrentTab = TabFrame
            TabFrame.Visible = true
        end

        local TabFuncs = {}

        function TabFuncs:Section(sec)
            local Label = Instance.new("TextLabel",TabFrame)
            Label.Size = UDim2.new(1,-10,0,24)
            Label.BackgroundTransparency = 1
            Label.Text = sec.Title
            Label.TextColor3 = Theme.SubText
            Label.Font = Enum.Font.GothamBold
            Label.TextSize = 14
        end

        function TabFuncs:Toggle(opt)
            local state = opt.Value or false

            local Btn = Instance.new("TextButton",TabFrame)
            Btn.Size = UDim2.new(1,-10,0,40)
            Btn.BackgroundColor3 = Theme.Item
            Btn.Text = opt.Title
            Btn.TextColor3 = Theme.Text
            Instance.new("UICorner",Btn).CornerRadius = UDim.new(0,8)

            Btn.MouseButton1Click:Connect(function()
                state = not state
                Btn.BackgroundColor3 = state and Theme.Accent or Theme.Item
                if opt.Callback then
                    opt.Callback(state)
                end
            end)
        end

        return TabFuncs
    end

    function WindowFuncs:AddMinimizeButton() end

    return WindowFuncs
end

return Library

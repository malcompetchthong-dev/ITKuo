--// KUOHUB UI LIBRARY FULL

local Library = {}

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

--================ THEMES ================--

local Themes = {
    Dark = {
        Main = Color3.fromRGB(38,38,38),
        Top = Color3.fromRGB(48,48,48),
        Sidebar = Color3.fromRGB(42,42,42),
        Item = Color3.fromRGB(55,55,55),
        Border = Color3.fromRGB(70,70,70),
        Text = Color3.fromRGB(235,235,235),
        SubText = Color3.fromRGB(180,180,180),
        Accent = Color3.fromRGB(120,120,120)
    }
}

--================ RAINBOW STROKE ================--

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
            TweenService:Create(
                stroke,
                TweenInfo.new(1),
                {Color = rainbowColors[i]}
            ):Play()

            i += 1
            if i > #rainbowColors then
                i = 1
            end
            task.wait(1)
        end
    end)
end

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
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            update(input)
        end
    end)
end

--================ WINDOW ================--

function Library:Window(config)
    config = config or {}

    local Theme = Themes[config.Theme] or Themes.Dark

    -- 🔴 ห้ามเปลี่ยน (ตามที่คุณสั่ง)
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "KUOHUB_UI"

    local Main = Instance.new("Frame", gui)
    Main.Size = config.Config and config.Config.Size or UDim2.new(0,500,0,400)
    Main.Position = UDim2.new(0.5,-250,0.5,-200)
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

    local Stroke = Instance.new("UIStroke",Main)
    Stroke.Color = Theme.Border
    Stroke.Thickness = 3
    tweenStrokeColor(Stroke)

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
    -- 🔴 จบส่วนห้ามแตะ

    Dragify(Main, Top)

    --================ SIDEBAR ================--

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0,140,1,-45)
    Sidebar.Position = UDim2.new(0,0,0,45)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner",Sidebar)

    local SideLayout = Instance.new("UIListLayout", Sidebar)
    SideLayout.Padding = UDim.new(0,6)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Pages = Instance.new("Frame", Main)
    Pages.Size = UDim2.new(1,-140,1,-45)
    Pages.Position = UDim2.new(0,140,0,45)
    Pages.BackgroundTransparency = 1

    local CurrentTab

    local WindowFunctions = {}

    --================ TAB ================--

    function WindowFunctions:Tab(tabConfig)
        tabConfig = tabConfig or {}

        local TabButton = Instance.new("TextButton", Sidebar)
        TabButton.Size = UDim2.new(1,-10,0,36)
        TabButton.BackgroundColor3 = Theme.Item
        TabButton.Text = tabConfig.Title or "Tab"
        TabButton.TextColor3 = Theme.Text
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.AutoButtonColor = false
        Instance.new("UICorner",TabButton)

        local Page = Instance.new("ScrollingFrame", Pages)
        Page.Size = UDim2.new(1,0,1,0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.ScrollBarThickness = 4

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0,6)

        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Page.Visible = false
            end
            Page.Visible = true
            CurrentTab = {Page = Page}
        end)

        if not CurrentTab then
            task.defer(function()
                TabButton:Activate()
            end)
        end

        local TabFunctions = {}

        function TabFunctions:AddToggle(cfg)
            local Toggle = Instance.new("TextButton", Page)
            Toggle.Size = UDim2.new(1,0,0,36)
            Toggle.BackgroundColor3 = Theme.Item
            Toggle.Text = cfg.Title or "Toggle"
            Toggle.TextColor3 = Theme.Text
            Toggle.Font = Enum.Font.Gotham
            Toggle.TextSize = 14
            Toggle.AutoButtonColor = false
            Instance.new("UICorner",Toggle)

            local state = false
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                if cfg.Callback then
                    cfg.Callback(state)
                end
            end)
        end

        return TabFunctions
    end

    --================ MINIMIZE BUTTON ================--

    function WindowFunctions:AddMinimizeButton(cfg)
        local btn = Instance.new("ImageButton", gui)
        btn.Size = UDim2.new(0,50,0,50)
        btn.Position = UDim2.new(0,20,0.5,-25)
        btn.Image = cfg.Button.Image
        btn.BackgroundTransparency = cfg.Button.BackgroundTransparency or 0
        Instance.new("UICorner",btn).CornerRadius =
            cfg.Corner and cfg.Corner.CornerRadius or UDim.new(1,0)

        btn.MouseButton1Click:Connect(function()
            Main.Visible = not Main.Visible
        end)
    end

    return WindowFunctions
end

return Library

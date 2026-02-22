--// KUO HUB LIBRARY (All-in-one)

local Library = {}

--========================
-- 🎨 THEMES
--========================
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

--========================
-- 🧲 DRAG SYSTEM (Mobile + PC)
--========================
local function makeDraggable(frame, handle)
    handle = handle or frame

    local UIS = game:GetService("UserInputService")
    local dragging = false
    local dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
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

--========================
-- 🪟 WINDOW
--========================
function Library:Window(cfg)
    local theme = Themes[cfg.Theme or "Dark"] or Themes.Dark

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "KuoHubUI"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    -- Main
    local Main = Instance.new("Frame")
    Main.Size = cfg.Config and cfg.Config.Size or UDim2.new(0,500,0,400)
    Main.Position = UDim2.new(0.5,-250,0.5,-200)
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    Main.BackgroundColor3 = theme.Main
    Main.BorderSizePixel = 0
    Main.Parent = gui

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

    local stroke = Instance.new("UIStroke", Main)
    stroke.Thickness = 1.2

    -- rainbow stroke
    task.spawn(function()
        local t = 0
        while stroke.Parent do
            stroke.Color = Color3.fromHSV(t,1,1)
            t = (t + 0.002) % 1
            task.wait()
        end
    end)

    --========================
    -- 🔝 TOP BAR
    --========================
    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,36)
    Top.BackgroundColor3 = theme.Top
    Top.BorderSizePixel = 0
    Top.Parent = Main

    Instance.new("UICorner", Top).CornerRadius = UDim.new(0,10)

    -- Icon
    if cfg.Icon then
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0,22,0,22)
        Icon.Position = UDim2.new(0,8,0.5,-11)
        Icon.BackgroundTransparency = 1
        Icon.Image = "rbxassetid://"..cfg.Icon
        Icon.Parent = Top
    end

    -- Title
    local Title = Instance.new("TextLabel")
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,-80,1,0)
    Title.Position = UDim2.new(0,36,0,0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = cfg.Title or "KUO HUB"
    Title.TextColor3 = theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Top

    -- Minimize
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0,28,0,28)
    MinBtn.Position = UDim2.new(1,-32,0.5,-14)
    MinBtn.Text = "-"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.BackgroundColor3 = theme.Main
    MinBtn.TextColor3 = theme.Text
    MinBtn.Parent = Top
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0,6)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Main.Size = minimized and UDim2.new(0,220,0,36)
            or (cfg.Config and cfg.Config.Size or UDim2.new(0,500,0,400))
    end)

    --========================
    -- 📦 CONTAINER
    --========================
    local Container = Instance.new("Frame")
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1,-12,1,-48)
    Container.Position = UDim2.new(0,6,0,42)
    Container.Parent = Main

    local layout = Instance.new("UIListLayout", Container)
    layout.Padding = UDim.new(0,6)

    -- DRAG (สำคัญ)
    makeDraggable(Main, Main)

    --========================
    -- 📑 TAB (simple)
    --========================
    local Window = {}

    function Window:Tab()
        local TabObj = {}
        TabObj.Container = Container

        --========================
        -- 🔘 TOGGLE
        --========================
        function TabObj:AddToggle(cfg)
            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Size = UDim2.new(1,0,0,36)
            ToggleFrame.BackgroundColor3 = theme.Top
            ToggleFrame.Text = ""
            ToggleFrame.AutoButtonColor = false
            ToggleFrame.Parent = Container

            Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0,6)

            local Label = Instance.new("TextLabel")
            Label.BackgroundTransparency = 1
            Label.Size = UDim2.new(1,-60,1,0)
            Label.Position = UDim2.new(0,10,0,0)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextColor3 = theme.Text
            Label.Text = cfg.Title or cfg.Name or "Toggle"
            Label.Parent = ToggleFrame

            local State = cfg.Value or cfg.Default or false

            local Indicator = Instance.new("Frame")
            Indicator.Size = UDim2.new(0,18,0,18)
            Indicator.Position = UDim2.new(1,-26,0.5,-9)
            Indicator.BackgroundColor3 = State and Color3.fromRGB(0,170,255) or Color3.fromRGB(80,80,80)
            Indicator.Parent = ToggleFrame
            Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1,0)

            local function setState(v)
                State = v
                Indicator.BackgroundColor3 =
                    State and Color3.fromRGB(0,170,255)
                    or Color3.fromRGB(80,80,80)

                if cfg.Callback then
                    task.spawn(cfg.Callback, State)
                end
            end

            ToggleFrame.MouseButton1Click:Connect(function()
                setState(not State)
            end)

            -- init callback
            if cfg.Callback then
                task.spawn(cfg.Callback, State)
            end

            return {
                Set = setState,
                Get = function() return State end
            }
        end

        return TabObj
    end

    function Window:AddMinimizeButton() end

    return Window
end

return Library

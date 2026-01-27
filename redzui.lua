--====================================================
-- REDZ UI LIBRARY (GENERIC / REUSABLE)
-- Drag Anywhere | Rainbow Border | Tabs
--====================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--====================================================
-- LIB TABLE
--====================================================
local redzlib = {}
redzlib.Themes = {
    Darker = {
        BG = Color3.fromRGB(25,25,25),
        Stroke = Color3.fromRGB(40,40,40),
        Text = Color3.fromRGB(255,255,255),
        Accent = Color3.fromRGB(88,101,242)
    },
    Dark = {
        BG = Color3.fromRGB(40,40,40),
        Stroke = Color3.fromRGB(65,65,65),
        Text = Color3.fromRGB(245,245,245),
        Accent = Color3.fromRGB(65,150,255)
    },
    Purple = {
        BG = Color3.fromRGB(30,30,35),
        Stroke = Color3.fromRGB(40,40,40),
        Text = Color3.fromRGB(240,240,240),
        Accent = Color3.fromRGB(150,0,255)
    }
}

redzlib.CurrentTheme = redzlib.Themes.Darker

--====================================================
-- RAINBOW COLORS
--====================================================
local rainbowColors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211)
}

local function RainbowStroke(stroke)
    task.spawn(function()
        local i = 1
        while stroke.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(1),
                {Color = rainbowColors[i]}
            ):Play()
            i = i + 1
            if i > #rainbowColors then i = 1 end
            task.wait(1)
        end
    end)
end

--====================================================
-- MAKE WINDOW
--====================================================
function redzlib:MakeWindow(data)
    local gui = Instance.new("ScreenGui", Player.PlayerGui)
    gui.Name = "RedzUILib"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,620,0,380)
    main.Position = UDim2.new(0.5,-310,0.5,-190)
    main.BackgroundColor3 = self.CurrentTheme.BG
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0,15)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 4
    RainbowStroke(stroke)

    --================ TITLE =================
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,-80,0,40)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = self.CurrentTheme.Text

    local titleText = data.Title or "UI Library"
    if data.SubTitle and data.SubTitle ~= "" then
        titleText = titleText .. "  |  " .. data.SubTitle
    end
    title.Text = titleText

    --================ MINIMIZE =================
    local mini = Instance.new("TextButton", main)
    mini.Size = UDim2.new(0,30,0,30)
    mini.Position = UDim2.new(1,-35,0,5)
    mini.Text = "-"
    mini.Font = Enum.Font.GothamBold
    mini.TextSize = 18
    mini.BackgroundColor3 = self.CurrentTheme.BG
    mini.TextColor3 = self.CurrentTheme.Text

    local mc = Instance.new("UICorner", mini)
    mc.CornerRadius = UDim.new(0,6)

    local minimized = false
    mini.MouseButton1Click:Connect(function()
        minimized = not minimized
        main.Size = minimized
            and UDim2.new(0,620,0,40)
            or UDim2.new(0,620,0,380)
    end)

    --================ SIDEBAR =================
    local sidebar = Instance.new("Frame", main)
    sidebar.Position = UDim2.new(0,0,0,40)
    sidebar.Size = UDim2.new(0,160,1,-40)
    sidebar.BackgroundColor3 = self.CurrentTheme.BG
    sidebar.BorderSizePixel = 0

    local sbStroke = Instance.new("UIStroke", sidebar)
    sbStroke.Thickness = 3
    RainbowStroke(sbStroke)

    local layout = Instance.new("UIListLayout", sidebar)
    layout.Padding = UDim.new(0,6)
    layout.HorizontalAlignment = Center

    local pad = Instance.new("UIPadding", sidebar)
    pad.PaddingTop = UDim.new(0,6)

    --================ CONTENT =================
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0,160,0,40)
    content.Size = UDim2.new(1,-160,1,-40)
    content.BackgroundTransparency = 1

    local CurrentTab

    --====================================================
    -- TAB API
    --====================================================
    local Window = {}

    function Window:MakeTab(tabData)
        local name = tabData[1]

        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1,-12,0,36)
        btn.Text = name
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.BackgroundColor3 = redzlib.CurrentTheme.BG
        btn.TextColor3 = redzlib.CurrentTheme.Text

        local bc = Instance.new("UICorner", btn)
        bc.CornerRadius = UDim.new(0,8)

        local page = Instance.new("ScrollingFrame", content)
        page.Size = UDim2.new(1,0,1,0)
        page.CanvasSize = UDim2.new(0,0,0,0)
        page.AutomaticCanvasSize = Y
        page.ScrollBarImageTransparency = 0.7
        page.Visible = false
        page.BackgroundTransparency = 1

        local pl = Instance.new("UIListLayout", page)
        pl.Padding = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Page.Visible = false
            end
            page.Visible = true
            CurrentTab = {Page = page}
        end)

        if not CurrentTab then
            task.defer(function() btn:Fire() end)
        end

        local Tab = {}

        function Tab:AddButton(data)
            local b = Instance.new("TextButton", page)
            b.Size = UDim2.new(1,0,0,38)
            b.Text = data[1]
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            b.BackgroundColor3 = redzlib.CurrentTheme.BG
            b.TextColor3 = redzlib.CurrentTheme.Text
            local c = Instance.new("UICorner", b)
            c.CornerRadius = UDim.new(0,8)

            b.MouseButton1Click:Connect(function()
                data[2]()
            end)
        end

        return Tab
    end

    return Window
end

--====================================================
-- SET THEME
--====================================================
function redzlib:SetTheme(name)
    if self.Themes[name] then
        self.CurrentTheme = self.Themes[name]
    end
end

return redzlib

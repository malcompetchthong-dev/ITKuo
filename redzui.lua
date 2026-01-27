--// Kuo RedzLib v1 (All-in-One)
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local lib = {}
lib.__index = lib

-- 🌈 Rainbow Colors
local rainbowColors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211)
}

local function rainbowStroke(stroke)
    task.spawn(function()
        local i = 1
        while stroke.Parent do
            TweenService:Create(stroke, TweenInfo.new(1), {
                Color = rainbowColors[i]
            }):Play()
            i = i % #rainbowColors + 1
            task.wait(1)
        end
    end)
end

-- 🖱 Drag Anywhere
local function makeDraggable(frame)
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
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
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- 🪟 Window
function lib:MakeWindow(cfg)
    local self = setmetatable({}, lib)

    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.fromOffset(520, 360)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(20,20,20)

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 2
    rainbowStroke(stroke)

    makeDraggable(main)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.fromOffset(10, 0)
    title.Text = cfg.Title or "Window"
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18

    local tabsHolder = Instance.new("Frame", main)
    tabsHolder.Size = UDim2.new(1, -20, 1, -60)
    tabsHolder.Position = UDim2.fromOffset(10, 50)
    tabsHolder.BackgroundTransparency = 1

    local tabLayout = Instance.new("UIListLayout", tabsHolder)
    tabLayout.FillDirection = Horizontal
    tabLayout.Padding = UDim.new(0, 6)

    self._gui = gui
    self._main = main
    self._tabsHolder = tabsHolder
    self._tabs = {}
    self._currentTab = nil

    function self:AddMinimizeButton()
        local btn = Instance.new("TextButton", main)
        btn.Size = UDim2.fromOffset(30,30)
        btn.Position = UDim2.new(1,-40,0,5)
        btn.Text = "-"
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn)

        local minimized = false
        btn.MouseButton1Click:Connect(function()
            minimized = not minimized
            main.Size = minimized and UDim2.fromOffset(520,40) or UDim2.fromOffset(520,360)
        end)
    end

    function self:MakeTab(info)
        local tab = {}

        local btn = Instance.new("TextButton", tabsHolder)
        btn.Size = UDim2.fromOffset(120,30)
        btn.Text = info[1]
        btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
        btn.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn)

        local page = Instance.new("ScrollingFrame", main)
        page.Size = UDim2.new(1,-20,1,-100)
        page.Position = UDim2.fromOffset(10,90)
        page.Visible = false
        page.CanvasSize = UDim2.new(0,0,0,0)
        page.ScrollBarImageTransparency = 1
        page.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0,6)

        function tab:AddParagraph(info)
            local lbl = Instance.new("TextLabel", page)
            lbl.Size = UDim2.new(1,-10,0,60)
            lbl.TextWrapped = true
            lbl.TextYAlignment = Top
            lbl.Text = info[2]
            lbl.BackgroundColor3 = Color3.fromRGB(30,30,30)
            lbl.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", lbl)
        end

        function tab:AddButton(info)
            local btn = Instance.new("TextButton", page)
            btn.Size = UDim2.new(1,-10,0,40)
            btn.Text = info[1]
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(info[2])
        end

        btn.MouseButton1Click:Connect(function()
            if self._currentTab then
                self._currentTab.page.Visible = false
            end
            page.Visible = true
            self._currentTab = {page = page}
        end)

        self._tabs[#self._tabs+1] = {button = btn, page = page}
        return tab
    end

    function self:SelectTab(tab)
        for _,v in pairs(self._tabs) do
            v.page.Visible = false
        end
        tab.page.Visible = true
    end

    return self
end

return lib

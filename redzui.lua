--// Redz Simple UI Library (Modified by Kuo)
--// Drag All Area | Mobile Ready | Rainbow Border

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local RedzLib = {}

-- ===== ScreenGui =====
local gui = Instance.new("ScreenGui")
gui.Name = "RedzUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== Detect Mobile =====
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

-- ===== Rainbow Colors =====
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
                TweenInfo.new(0.8),
                {Color = rainbowColors[i]}
            ):Play()
            i = i + 1
            if i > #rainbowColors then i = 1 end
            task.wait(0.8)
        end
    end)
end

-- ===== Drag System (All Area) =====
local function MakeDraggable(frame)
    local dragging = false
    local dragStart, startPos

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
        if dragging and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
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

-- ===== Window =====
function RedzLib:MakeWindow(cfg)
    local Window = {}

    local main = Instance.new("Frame", gui)
    main.Size = isMobile and UDim2.new(0,360,0,260) or UDim2.new(0,520,0,320)
    main.Position = UDim2.new(0.5,-260,0.5,-160)
    main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    main.BorderSizePixel = 0

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0,14)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 4
    RainbowStroke(stroke)

    MakeDraggable(main)

    -- ===== Header =====
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1,0,0,36)
    header.BackgroundTransparency = 1
    MakeDraggable(header)

    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1,-90,1,0)
    title.Position = UDim2.new(0,12,0,0)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Left
    title.Text = cfg.Title or "Redz UI"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1,1,1)

    -- ===== Minimize =====
    local minimized = false
    local minBtn = Instance.new("TextButton", header)
    minBtn.Size = UDim2.new(0,28,0,28)
    minBtn.Position = UDim2.new(1,-64,0,4)
    minBtn.Text = "-"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 18
    minBtn.TextColor3 = Color3.new(1,1,1)
    minBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)

    local minCorner = Instance.new("UICorner", minBtn)

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        minBtn.Text = minimized and "+" or "-"
        main.Size = minimized
            and UDim2.new(main.Size.X.Scale, main.Size.X.Offset, 0,36)
            or (isMobile and UDim2.new(0,360,0,260) or UDim2.new(0,520,0,320))
    end)

    -- ===== Close =====
    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0,28,0,28)
    closeBtn.Position = UDim2.new(1,-32,0,4)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
    closeBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)

    local closeCorner = Instance.new("UICorner", closeBtn)

    closeBtn.MouseButton1Click:Connect(function()
        local dialog = Instance.new("Frame", gui)
        dialog.Size = UDim2.new(0,260,0,120)
        dialog.Position = UDim2.new(0.5,-130,0.5,-60)
        dialog.BackgroundColor3 = Color3.fromRGB(25,25,25)
        dialog.BorderSizePixel = 0
        local dc = Instance.new("UICorner", dialog)

        local txt = Instance.new("TextLabel", dialog)
        txt.Size = UDim2.new(1,-20,0,60)
        txt.Position = UDim2.new(0,10,0,10)
        txt.BackgroundTransparency = 1
        txt.TextWrapped = true
        txt.Text = "Do you want to destroy this UI?"
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Font = Enum.Font.Gotham
        txt.TextSize = 14

        local yes = Instance.new("TextButton", dialog)
        yes.Size = UDim2.new(0.5,-15,0,30)
        yes.Position = UDim2.new(0,10,1,-40)
        yes.Text = "Confirm"
        yes.BackgroundColor3 = Color3.fromRGB(70,200,120)
        local yc = Instance.new("UICorner", yes)

        local no = Instance.new("TextButton", dialog)
        no.Size = UDim2.new(0.5,-15,0,30)
        no.Position = UDim2.new(0.5,5,1,-40)
        no.Text = "Cancel"
        no.BackgroundColor3 = Color3.fromRGB(200,80,80)
        local nc = Instance.new("UICorner", no)

        yes.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)

        no.MouseButton1Click:Connect(function()
            dialog:Destroy()
        end)
    end)

    -- ===== Tabs =====
    local tabs = {}

    function Window:MakeTab(info)
        local Tab = {}
        Tab.Name = info[1] or "Tab"
        Tab.Buttons = {}

        function Tab:AddButton(info)
            local btn = Instance.new("TextButton", main)
            btn.Size = UDim2.new(0,140,0,36)
            btn.Position = UDim2.new(0,20,0,60 + (#Tab.Buttons * 42))
            btn.Text = info[1]
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
            local bc = Instance.new("UICorner", btn)

            btn.MouseButton1Click:Connect(function()
                info[2]()
            end)

            table.insert(Tab.Buttons, btn)
        end

        return Tab
    end

    return Window
end

function RedzLib:SetTheme(theme)
    -- placeholder (Dark / Darker)
end

return RedzLib

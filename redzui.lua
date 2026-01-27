--// REDZ UI LIB (English Version)
--// Edited for public use

repeat task.wait() until game:IsLoaded()

--// Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--// Device detect
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

--// Rainbow colors
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
        while stroke and stroke.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(1),
                {Color = rainbowColors[i]}
            ):Play()

            i += 1
            if i > #rainbowColors then i = 1 end
            task.wait(1)
        end
    end)
end

--// Library
local redzlib = {}
redzlib.__index = redzlib

redzlib.Theme = {
    Background = Color3.fromRGB(25,25,25),
    Text = Color3.fromRGB(255,255,255)
}

function redzlib:SetTheme(name)
    -- Reserved (compatibility)
end

--// Window
function redzlib:MakeWindow(cfg)
    local gui = Instance.new("ScreenGui")
    gui.Name = "RedzUI"
    gui.ResetOnSpawn = false
    gui.Parent = Player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, isMobile and 480 or 620, 0, isMobile and 320 or 380)
    main.Position = UDim2.new(0.5,-main.Size.X.Offset/2,0.5,-main.Size.Y.Offset/2)
    main.BackgroundColor3 = redzlib.Theme.Background
    main.BorderSizePixel = 0
    main.Active = true

    -- Drag anywhere
    local dragging, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local scale = Instance.new("UIScale", main)
    scale.Scale = isMobile and 0.9 or 1

    Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 4
    RainbowStroke(stroke)

    -- Title (single line, left aligned)
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,-90,0,36)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = (cfg.Title or "") .. " " .. (cfg.SubTitle or "")
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = redzlib.Theme.Text

    -- Minimize button
    local minimize = Instance.new("TextButton", main)
    minimize.Size = UDim2.new(0,30,0,30)
    minimize.Position = UDim2.new(1,-70,0,3)
    minimize.Text = "-"
    minimize.Font = Enum.Font.GothamBold
    minimize.TextSize = 20
    minimize.BackgroundColor3 = redzlib.Theme.Background
    minimize.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", minimize)

    -- Close button
    local close = Instance.new("TextButton", main)
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-35,0,3)
    close.Text = "X"
    close.Font = Enum.Font.GothamBold
    close.TextSize = 18
    close.BackgroundColor3 = redzlib.Theme.Background
    close.TextColor3 = Color3.fromRGB(255,80,80)
    Instance.new("UICorner", close)

    -- Content
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0,0,0,36)
    content.Size = UDim2.new(1,0,1,-36)
    content.BackgroundTransparency = 1

    -- Minimize logic
    local minimized = false
    local fullSize = main.Size

    minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        minimize.Text = minimized and "+" or "-"
        content.Visible = not minimized

        TweenService:Create(main,TweenInfo.new(0.25),{
            Size = minimized and
                UDim2.new(fullSize.X.Scale,fullSize.X.Offset,0,36)
                or fullSize
        }):Play()
    end)

    -- Close confirmation
    close.MouseButton1Click:Connect(function()
        if gui:FindFirstChild("ConfirmDialog") then return end

        local box = Instance.new("Frame", gui)
        box.Name = "ConfirmDialog"
        box.Size = UDim2.new(0,260,0,120)
        box.Position = UDim2.new(0.5,-130,0.5,-60)
        box.BackgroundColor3 = redzlib.Theme.Background
        Instance.new("UICorner", box)

        local text = Instance.new("TextLabel", box)
        text.Size = UDim2.new(1,0,0,60)
        text.BackgroundTransparency = 1
        text.TextWrapped = true
        text.Text = "Do you want to destroy this UI?"
        text.TextColor3 = Color3.new(1,1,1)

        local yes = Instance.new("TextButton", box)
        yes.Size = UDim2.new(0.5,-5,0,30)
        yes.Position = UDim2.new(0,5,1,-35)
        yes.Text = "Confirm"

        local no = Instance.new("TextButton", box)
        no.Size = UDim2.new(0.5,-5,0,30)
        no.Position = UDim2.new(0.5,0,1,-35)
        no.Text = "Cancel"

        yes.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        no.MouseButton1Click:Connect(function()
            box:Destroy()
        end)
    end)

    -- Tabs
    local Window = {}

    function Window:MakeTab(info)
        local Tab = {}

        function Tab:AddButton(data)
            local btn = Instance.new("TextButton", content)
            btn.Size = UDim2.new(1,-20,0,36)
            btn.Position = UDim2.new(0,10,0,10)
            btn.Text = data[1]
            btn.Font = Enum.Font.Gotham
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
            Instance.new("UICorner", btn)

            btn.MouseButton1Click:Connect(data[2])
        end

        return Tab
    end

    return Window
end

return redzlib

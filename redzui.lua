--// Redz UI (Custom Build for Kuo)
--// One-file version (Fixed API Compatible)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- =========================
-- Anti Duplicate UI
-- =========================
if PlayerGui:FindFirstChild("RedzUI") then
    PlayerGui.RedzUI:Destroy()
end

local RedzLib = {}
RedzLib.__index = RedzLib

-- =========================
-- Rainbow Colors
-- =========================
local rainbowColors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211),
}

local function RainbowStroke(stroke)
    task.spawn(function()
        local i = 1
        while stroke.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(1),
                { Color = rainbowColors[i] }
            ):Play()
            i += 1
            if i > #rainbowColors then i = 1 end
            task.wait(1)
        end
    end)
end

-- =========================
-- Drag (All Points)
-- =========================
local function MakeDraggable(frame)
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

-- =========================
-- Make Window
-- =========================
function RedzLib:MakeWindow(cfg)
    local gui = Instance.new("ScreenGui")
    gui.Name = "RedzUI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 620, 0, 380)
    main.Position = UDim2.new(0.5, -310, 0.5, -190)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

    local scale = Instance.new("UIScale", main)
    scale.Scale = isMobile and 0.9 or 1

    MakeDraggable(main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 4
    RainbowStroke(stroke)

    -- Title (single line)
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,-100,0,40)
    title.Position = UDim2.new(0,12,0,0)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = (cfg.Title or "") .. " " .. (cfg.SubTitle or "")
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16

    -- =========================
    -- Minimize Button
    -- =========================
    local minimized = false
    local minBtn = Instance.new("TextButton", main)
    minBtn.Size = UDim2.new(0,30,0,30)
    minBtn.Position = UDim2.new(1,-70,0,5)
    minBtn.Text = "-"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 20
    minBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Instance.new("UICorner", minBtn)

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        minBtn.Text = minimized and "+" or "-"
        TweenService:Create(
            main,
            TweenInfo.new(0.25),
            { Size = minimized and UDim2.new(0,620,0,40) or UDim2.new(0,620,0,380) }
        ):Play()
    end)

    -- =========================
    -- Close Button (Confirm)
    -- =========================
    local closeBtn = Instance.new("TextButton", main)
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,5)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
    closeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Instance.new("UICorner", closeBtn)

    closeBtn.MouseButton1Click:Connect(function()
        local confirm = Instance.new("Frame", gui)
        confirm.Size = UDim2.new(0,300,0,140)
        confirm.Position = UDim2.new(0.5,-150,0.5,-70)
        confirm.BackgroundColor3 = Color3.fromRGB(30,30,30)
        Instance.new("UICorner", confirm)
        MakeDraggable(confirm)

        local txt = Instance.new("TextLabel", confirm)
        txt.Size = UDim2.new(1,-20,0,60)
        txt.Position = UDim2.new(0,10,0,10)
        txt.BackgroundTransparency = 1
        txt.Text = "Do you want to destroy this GUI?"
        txt.TextWrapped = true
        txt.TextColor3 = Color3.new(1,1,1)
        txt.Font = Enum.Font.Gotham
        txt.TextSize = 14

        local yes = Instance.new("TextButton", confirm)
        yes.Size = UDim2.new(0.45,0,0,30)
        yes.Position = UDim2.new(0.05,0,1,-40)
        yes.Text = "Confirm"
        yes.BackgroundColor3 = Color3.fromRGB(70,200,120)
        Instance.new("UICorner", yes)

        local no = Instance.new("TextButton", confirm)
        no.Size = UDim2.new(0.45,0,0,30)
        no.Position = UDim2.new(0.5,0,1,-40)
        no.Text = "Cancel"
        no.BackgroundColor3 = Color3.fromRGB(200,70,70)
        Instance.new("UICorner", no)

        yes.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
        no.MouseButton1Click:Connect(function()
            confirm:Destroy()
        end)
    end)

    -- =========================
    -- Window API
    -- =========================
    local Window = {}

    function Window:AddMinimizeButton() end
    function Window:SelectTab() end

    function Window:Dialog(cfg)
        -- already handled by close button (compat)
    end

    function Window:MakeTab(info)
        local tab = {}

        function tab:AddButton(data)
            local b = Instance.new("TextButton", main)
            b.Size = UDim2.new(0,160,0,36)
            b.Position = UDim2.new(0,20,0,60)
            b.Text = data[1]
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(data[2])
        end

        function tab:AddSection() end
        function tab:AddParagraph() end

        function tab:AddDiscordInvite(data)
            if _G.RedzDiscordInvited then return end
            _G.RedzDiscordInvited = true
            print("Discord Invite:", data.Invite)
        end

        return tab
    end

    return Window
end

function RedzLib:SetTheme() end

return setmetatable({}, RedzLib)

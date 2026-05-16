local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:MakeWindow({
Title = "Kuo Hub [99Nights]",
})

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://126460540157931", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})
-- =========================
-- UI
-- =========================
local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

Home:Section("Main")

-- =========================
-- SERVICES
-- =========================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer

-- =========================
-- REMOTES
-- =========================
local DamageRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")
local EquipRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("EquipItemHandle")

-- =========================
-- SETTINGS
-- =========================
local KILLAURA = false
local FARM_TREE = false
local infiniteHealthEnabled = false
local healthConnection = nil

local RANGE = 80
local HIT_DELAY = 0.1

-- =========================
-- UI TOGGLES
-- =========================
Home:AddDiscordInvite({
    Name = "Kuo Hub",
    Description = "Join server",
    Logo = "rbxassetid://126460540157931",
    Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title = "Kill Aura",
    Desc = "ฆ่ามอนอัตโนมัติ",
    Callback = function(v)
        KILLAURA = v
    end
})

Home:Toggle({
    Title = "Auto Farm Tree",
    Desc = "ตัดไม้ทีละต้น",
    Callback = function(v)
        FARM_TREE = v
    end
})

Combat:Toggle({
    Title = "God Mode",
    Desc = "อมตะ",
    Callback = function(v)
        infiniteHealthEnabled = v
        if v and lp.Character then
            ActivateInfiniteHealth(lp.Character)
        elseif healthConnection then
            healthConnection:Disconnect()
            healthConnection = nil
        end
    end
})

-- =========================
-- CHARACTER
-- =========================
local function getChar()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- =========================
-- TOOL
-- =========================
local function getAxe()
    local inv = lp:FindFirstChild("Inventory")
    if not inv then return end

    for _,v in pairs(inv:GetChildren()) do
        if v.Name:lower():find("axe") then
            return v
        end
    end
end

local lastEquip = 0
local function equipAxe(axe)
    if tick() - lastEquip > 1 then
        lastEquip = tick()
        EquipRemote:FireServer("FireAllClients", axe)
    end
end

-- =========================
-- KILLAURA
-- =========================
local function getMonsters()
    local folder = workspace:FindFirstChild("Characters")
    if not folder then return {} end

    local hrp = getRoot()
    if not hrp then return {} end

    local list = {}

    for _,mob in pairs(folder:GetChildren()) do
        local root = mob:FindFirstChild("HumanoidRootPart")
        local hum = mob:FindFirstChildOfClass("Humanoid")

        if root and hum and hum.Health > 0 then
            local dist = (root.Position - hrp.Position).Magnitude
            if dist <= RANGE then
                table.insert(list, {mob = mob, root = root})
            end
        end
    end

    return list
end

local function hit(mob, root, axe)
    pcall(function()
        DamageRemote:InvokeServer(
            mob,
            axe,
            "1_4478233043",
            root.CFrame
        )
    end)
end

-- =========================
-- GOD MODE
-- =========================
function ActivateInfiniteHealth(character)
    if not character or not character:FindFirstChild("Humanoid") then return end

    if healthConnection then
        healthConnection:Disconnect()
    end

    local humanoid = character:FindFirstChild("Humanoid")

    healthConnection = humanoid.Changed:Connect(function(prop)
        if infiniteHealthEnabled then
            if prop == "Health" and humanoid.Health < humanoid.MaxHealth then
                local remote = ReplicatedStorage:FindFirstChild("RemoteEvents")
                if remote and remote:FindFirstChild("DamagePlayer") then
                    remote.DamagePlayer:FireServer(math.huge * -1)
                end
            end
        end
    end)
end

lp.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if infiniteHealthEnabled then
        ActivateInfiniteHealth(char)
    end
end)

-- =========================
-- 🌲 TREE SYSTEM
-- =========================
local Foliage = workspace:WaitForChild("Map"):WaitForChild("Foliage")

local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(0,255,0)
highlight.OutlineColor = Color3.fromRGB(255,255,255)
highlight.FillTransparency = 0.5
highlight.Parent = game.CoreGui

local function getNearestTree()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local root = char.HumanoidRootPart
    local closest = nil
    local minDist = 150

    for _, v in pairs(Foliage:GetChildren()) do
        if v.Name == "Small Tree" then
            local part = v:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (part.Position - root.Position).Magnitude
                if dist <= minDist then
                    minDist = dist
                    closest = v
                end
            end
        end
    end

    return closest
end

-- =========================
-- 🔥 THREAD 1: KILLAURA
-- =========================
task.spawn(function()
    while task.wait(0.3) do
        if not KILLAURA then continue end

        local axe = getAxe()
        if not axe then continue end

        equipAxe(axe)

        for _,data in pairs(getMonsters()) do
            hit(data.mob, data.root, axe)
            task.wait(HIT_DELAY)
        end
    end
end)

-- =========================
-- 🌲 THREAD 2: FARM TREE
-- =========================
task.spawn(function()
    while task.wait(0.4) do
        if not FARM_TREE then continue end

        local axe = getAxe()
        if not axe then continue end

        local Tree = getNearestTree()

        if Tree then
            highlight.Adornee = Tree

            while Tree and Tree.Parent and FARM_TREE do
                EquipRemote:FireServer("FireAllClients", axe)

                local args = {
                    Tree,
                    axe,
                    "1_4478233043",
                    CFrame.new(73.76412963867188, 4.6776556968688965, -88.8170394897461,
                        0.0038667151238769293, -9.135444400953929e-08, -0.9999925494194031,
                        -7.452111816519391e-08, 1, -9.164328673705313e-08,
                        0.9999925494194031, 7.487491870961094e-08, 0.0038667151238769293)
                }

                DamageRemote:InvokeServer(unpack(args))
                task.wait(0.1)
            end
        end
    end
end)
-- =========================
-- WARNING GUI
-- =========================
local TweenService =
    game:GetService("TweenService")

local CoreGui =
    game:GetService("CoreGui")

pcall(function()
    CoreGui:FindFirstChild("Kuo Hub"):Destroy()
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Kuo Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- =========================
-- MAIN
-- =========================
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5,0)
Main.Position = UDim2.new(0.5,0,-0.3,0)
Main.Size = UDim2.new(0,420,0,145)
Main.BackgroundColor3 =
    Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0,20)

-- Stroke
local Stroke = Instance.new("UIStroke")
Stroke.Parent = Main
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(255,170,0)

-- Glow
local Glow = Instance.new("ImageLabel")
Glow.Parent = Main
Glow.BackgroundTransparency = 1
Glow.Size = UDim2.new(1,50,1,50)
Glow.Position = UDim2.new(0,-25,0,-25)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageTransparency = 0.35
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24,24,276,276)
Glow.ImageColor3 =
    Color3.fromRGB(255,170,0)

-- =========================
-- ICON
-- =========================
local Icon = Instance.new("TextLabel")
Icon.Parent = Main
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0,14,0,8)
Icon.Size = UDim2.new(0,40,0,40)
Icon.Font = Enum.Font.GothamBold
Icon.Text = "⚠️"
Icon.TextSize = 28

-- =========================
-- TITLE
-- =========================
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,55,0,10)
Title.Size = UDim2.new(1,-65,0,30)
Title.Font = Enum.Font.GothamBold
Title.Text = "DELTA DETECT WARNING"
Title.TextSize = 24
Title.TextColor3 =
    Color3.fromRGB(255,255,255)
Title.TextXAlignment =
    Enum.TextXAlignment.Left

-- =========================
-- MESSAGE
-- =========================
local Desc = Instance.new("TextLabel")
Desc.Parent = Main
Desc.BackgroundTransparency = 1
Desc.Position = UDim2.new(0,18,0,48)
Desc.Size = UDim2.new(1,-36,0,70)
Desc.Font = Enum.Font.Gotham
Desc.TextWrapped = true
Desc.TextYAlignment =
    Enum.TextYAlignment.Top
Desc.TextXAlignment =
    Enum.TextXAlignment.Left
Desc.TextSize = 15

Desc.Text =
"⚠️ ตัวรัน Delta โดน Detect (โดนตรวจจับ)\n\n" ..
"ตอนนี้มีหลายคนโดนเตือนหรือโดนแบน\n" ..
"ใครยังไม่โดน แนะนำให้งดใช้ตัวรันหลัก\n" ..
"หรือใช้ในไอดีสำรองไปก่อน"

Desc.TextColor3 =
    Color3.fromRGB(220,220,220)

-- =========================
-- BAR
-- =========================
local BarBG = Instance.new("Frame")
BarBG.Parent = Main
BarBG.Position = UDim2.new(0,18,1,-16)
BarBG.Size = UDim2.new(1,-36,0,6)
BarBG.BackgroundColor3 =
    Color3.fromRGB(35,35,35)
BarBG.BorderSizePixel = 0

Instance.new("UICorner", BarBG).CornerRadius =
    UDim.new(1,0)

local Bar = Instance.new("Frame")
Bar.Parent = BarBG
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 =
    Color3.fromRGB(255,170,0)
Bar.BorderSizePixel = 0

Instance.new("UICorner", Bar).CornerRadius =
    UDim.new(1,0)

-- =========================
-- ANIMATION
-- =========================

TweenService:Create(
    Main,
    TweenInfo.new(
        0.45,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    ),
    {
        Position = UDim2.new(0.5,0,0.04,0)
    }
):Play()

TweenService:Create(
    Bar,
    TweenInfo.new(7),
    {
        Size = UDim2.new(1,0,1,0)
    }
):Play()

-- Glow Pulse
task.spawn(function()

    while Main.Parent do

        TweenService:Create(
            Glow,
            TweenInfo.new(
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                ImageTransparency = 0.55
            }
        ):Play()

        task.wait(1)

        TweenService:Create(
            Glow,
            TweenInfo.new(
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            ),
            {
                ImageTransparency = 0.3
            }
        ):Play()

        task.wait(1)
    end
end)

-- =========================
-- REMOVE
-- =========================
task.delay(7.2,function()

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.4,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Position = UDim2.new(0.5,0,-0.3,0),
            BackgroundTransparency = 1
        }
    ):Play()

    task.wait(0.45)

    ScreenGui:Destroy()

end)

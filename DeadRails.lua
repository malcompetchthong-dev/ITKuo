local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:MakeWindow({
Title = "Kuo Hub[DeadRails]",
})

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://126460540157931", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})

local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

Home:Section("Main")

repeat task.wait() until game:IsLoaded()

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// CHARACTER
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

function CombatModule.EnableGodMode()
    if ScriptState.GodMode then return end
    ScriptState.GodMode = true
 
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        -- Salvar valores originais
        local originalMaxHealth = humanoid.MaxHealth
        local originalHealth = humanoid.Health
 
        -- Aplicar god mode
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
 
        -- Prevenir dano
        local connection = humanoid.HealthChanged:Connect(function()
            if ScriptState.GodMode then
                humanoid.Health = math.huge
            end
        end)
 
        table.insert(Connections, connection)
 
        -- Spoof para anti-cheat
        pcall(function()
            local mt = getrawmetatable(humanoid)
            if mt then
                setreadonly(mt, false)
                local oldIndex = mt.__index
                mt.__index = function(self, key)
                    if key == "Health" and ScriptState.GodMode then
                        return originalHealth -- Retornar valor normal
                    end
                    return oldIndex(self, key)
                end
                setreadonly(mt, true)
            end
        end)
    end
 
    print("🛡️ God Mode ativado")
end
 
-- Desativar God Mode
function CombatModule.DisableGodMode()
    ScriptState.GodMode = false
 
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
 
    print("🚫 God Mode desativado")
end
 

-- =========================
-- INVISIBLE (MM2 FIX)
-- =========================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local invisible = false
local bodyParts = {}
local character, humanoid, rootPart

local function setupCharacter()
character = player.Character or player.CharacterAdded:Wait()
humanoid = character:WaitForChild("Humanoid")
rootPart = character:WaitForChild("HumanoidRootPart")

bodyParts = {}

for _, v in pairs(character:GetDescendants()) do
if v:IsA("BasePart") and v.Transparency == 0 then
table.insert(bodyParts, v)
end
end

end

local function setInvisible(state)
invisible = state

for _, v in pairs(bodyParts) do
v.Transparency = invisible and 0.5 or 0
end

end

-- 🔥 ตัวนี้เอาไปใช้กับ Toggle
function applyInvisible(state)
setInvisible(state)
end

-- setup ครั้งแรก
setupCharacter()

-- ระบบล่องหน (ของเดิม 100%)
RunService.Heartbeat:Connect(function()
if invisible and rootPart and humanoid then
local cf = rootPart.CFrame
local camOff = humanoid.CameraOffset

rootPart.CFrame = cf * CFrame.new(0, -200000, 0)
humanoid.CameraOffset = Vector3.new(
camOff.X,
camOff.Y + 200000,
camOff.Z
)

RunService.RenderStepped:Wait()

rootPart.CFrame = cf
humanoid.CameraOffset = camOff

end

end)

-- กันตายแล้วพัง
player.CharacterAdded:Connect(function()
invisible = false
setupCharacter()
end)

-- =========================
-- UI
-- =========================
Home:AddDiscordInvite({
Name = "Kuo Hub",
Description = "Join server",
Logo = "rbxassetid://126460540157931",
Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title = "God Mode",
    Desc = "กันตาย",
    Callback = function(v)
        GOD_MODE = v
    end
})

Home:Toggle({
Title = "Invisible Mode",
Desc = "ร่องหน",
Callback = function(v)
applyInvisible(v)
end
})

getgenv().SpeedValue = 16

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function getChar()
return lp.Character or lp.CharacterAdded:Wait()
end

local function applySpeed(v)
local char = getChar()
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then
hum.WalkSpeed = v
end
end

--========================
-- SLIDER
--========================
Home:AddSlider({
Name = "Adjust walking speed",
Min = 16,
Max = 200,
Default = 16,
Callback = function(v)
getgenv().SpeedValue = v
applySpeed(v)
end
})

--========================
-- MAIN MOVEMENT LOOP (FIXED)
--========================
task.spawn(function()
while task.wait(0.05) do
local char = lp.Character
if char then
local hrp = char:FindFirstChild("HumanoidRootPart")
local hum = char:FindFirstChildOfClass("Humanoid")

if hrp and hum then
local dir = hum.MoveDirection

if dir.Magnitude > 0 then
hrp.AssemblyLinearVelocity = dir * getgenv().SpeedValue
else
-- 🔥 stop clean (กันลื่น)
hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
end
end
end

end

end)

--========================
-- RESPWAN FIX
--========================
lp.CharacterAdded:Connect(function()
task.wait(0.5)
applySpeed(getgenv().SpeedValue)
end)

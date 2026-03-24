local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://78655725770640", BackgroundTransparency = 0 },
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

--// SETTINGS
local flying = false
local speed = 60
local ESP_ENABLED = false
local AUTO_WARP_GUN = false
local INFINITE_JUMP = false
local AIMLOCK = false
local LOCK_TARGET = nil
local NOCLIP = false
local SILENT_AIM = false

-- =========================
-- FLY
-- =========================
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

local function setFly(state)
flying = state
bv.Parent = state and root or nil
bg.Parent = state and root or nil
end

RunService.RenderStepped:Connect(function()
if flying then
local cam = workspace.CurrentCamera
local moveDir = humanoid.MoveDirection
bv.Velocity = (cam.CFrame.LookVector * moveDir.Z + cam.CFrame.RightVector * moveDir.X) * speed
bg.CFrame = cam.CFrame
end
end)

-- =========================
-- ROLE CHECK
-- =========================
local function getRole(plr)
local bp = plr:FindFirstChild("Backpack")
local char = plr.Character

if bp and bp:FindFirstChild("Knife") then return "Murderer" end    
if bp and bp:FindFirstChild("Gun") then return "Sheriff" end    
if char and char:FindFirstChild("Knife") then return "Murderer" end    
if char and char:FindFirstChild("Gun") then return "Sheriff" end    

return "Innocent"

end

-- =========================
-- ESP PLAYER + GUN
-- =========================
local function createESP(char, role)
local head = char:FindFirstChild("Head")
if not head then return end
if char:FindFirstChild("KuoHL") then return end

local hl = Instance.new("Highlight")    
hl.Name = "KuoHL"    
hl.FillTransparency = 0.5    
hl.OutlineColor = Color3.new(1,1,1)    

local bill = Instance.new("BillboardGui")    
bill.Name = "KuoTag"    
bill.Size = UDim2.new(0,100,0,40)    
bill.StudsOffset = Vector3.new(0,2,0)    
bill.AlwaysOnTop = true    
bill.Parent = head    

local text = Instance.new("TextLabel")    
text.Size = UDim2.new(1,0,1,0)    
text.BackgroundTransparency = 1    
text.TextScaled = true    
text.Font = Enum.Font.GothamBold    
text.Parent = bill    

if role == "Murderer" then    
    hl.FillColor = Color3.fromRGB(255,0,0)    
    text.Text = "ไอชั่ว 😈"    
    text.TextColor3 = Color3.fromRGB(255,0,0)    
elseif role == "Sheriff" then    
    hl.FillColor = Color3.fromRGB(170,0,255)    
    text.Text = "นายอำเภอ 👮"    
    text.TextColor3 = Color3.fromRGB(170,0,255)    
else    
    hl.FillColor = Color3.fromRGB(0,255,0)    
    text.Text = "ผู้บริสุทธิ์ 🙂"    
    text.TextColor3 = Color3.fromRGB(0,255,0)    
end    

hl.Parent = char

end

local function clearESP(char)
if not char then return end
local hl = char:FindFirstChild("KuoHL")
if hl then hl:Destroy() end
local head = char:FindFirstChild("Head")
if head then
local tag = head:FindFirstChild("KuoTag")
if tag then tag:Destroy() end
end
end

local function createGunESP(gun)
if gun:FindFirstChild("GunHL") then return end
local hl = Instance.new("Highlight")
hl.Name = "GunHL"
hl.FillColor = Color3.fromRGB(255,255,0)
hl.FillTransparency = 0.3
hl.OutlineColor = Color3.new(1,1,1)
hl.Parent = gun
end

local function clearGunESP()
for _, v in ipairs(workspace:GetDescendants()) do
if v:FindFirstChild("GunHL") then
v.GunHL:Destroy()
end
end
end

-- =========================
-- AUTO WARP GUN
-- =========================
local lastGun = nil

local function findGun()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("BasePart") and v.Name:lower():find("revolver") then
return v
end
end
end

RunService.RenderStepped:Connect(function()

-- ESP    
if ESP_ENABLED then    
    for _, plr in ipairs(Players:GetPlayers()) do    
        if plr ~= player and plr.Character then    
            clearESP(plr.Character)    
            createESP(plr.Character, getRole(plr))    
        end    
    end    
    for _, v in ipairs(workspace:GetDescendants()) do    
        if v:IsA("BasePart") and v.Name:lower():find("revolver") then    
            createGunESP(v)    
        end    
    end    
end    

-- AUTO GUN    
if AUTO_WARP_GUN then    
    local char = player.Character    
    local root = char and char:FindFirstChild("HumanoidRootPart")    
    if root then    
        local gun = findGun()    
        local backpack = player:FindFirstChild("Backpack")    
        if backpack and backpack:FindFirstChild("Gun") then return end    
        if gun and gun ~= lastGun then    
            lastGun = gun    
            game:GetService("StarterGui"):SetCore("SendNotification", {    
                Title = "KuoHub", Text = "🔫 เก็บปืน!", Duration = 2    
            })    
            for i = 1,5 do    
                root.CFrame = gun.CFrame + Vector3.new(0,2,0)    
                firetouchinterest(root, gun, 0)    
                firetouchinterest(root, gun, 1)    
                task.wait(0.05)    
            end    
        end    
        if not gun then lastGun = nil end    
    end    
end

end)

-- =========================
-- INFINITE JUMP
-- =========================
UIS.JumpRequest:Connect(function()
if INFINITE_JUMP then
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end
end)

-- =========================
-- NOCLIP
-- =========================
RunService.Stepped:Connect(function()
if NOCLIP then
local char = player.Character
if char then
for _, v in ipairs(char:GetDescendants()) do
if v:IsA("BasePart") then v.CanCollide = false end
end
end
end
end)

-- =========================
-- AIM LOCK + SILENT AIM
-- =========================
local function getMurderer()
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and plr.Character and getRole(plr) == "Murderer" then
return plr.Character:FindFirstChild("HumanoidRootPart")
end
end
end

RunService.RenderStepped:Connect(function()
if AIMLOCK then
if not LOCK_TARGET or not LOCK_TARGET.Parent then LOCK_TARGET = getMurderer() end
local cam = workspace.CurrentCamera
if LOCK_TARGET then cam.CFrame = CFrame.new(cam.CFrame.Position, LOCK_TARGET.Position) end
end
end)

local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
local args = {...}
local method = getnamecallmethod()
if SILENT_AIM and method=="FireServer" then
local target = getMurderer()
if target then
for i,v in ipairs(args) do
if typeof(v)=="CFrame" then args[i] = CFrame.new(target.Position) end
end
end
end
return old(self, unpack(args))
end)

-- =========================
-- UI
-- =========================
Home:Toggle({Title="ESP",Desc="ไฮไลต์ผู้เล่น",Callback=function(v) ESP_ENABLED=v if not v then for _,plr in ipairs(Players:GetPlayers()) do if plr.Character then clearESP(plr.Character) end end clearGunESP() end end})
Home:Toggle({Title="Fly(Bug)",Desc="บิน(บินไม่เสถียน)",Callback=function(v) setFly(v) end})
Home:Toggle({Title="Auto Warp Gun(Bug)",Desc="วาร์ปไปเก็บปืนอัตโนมัติ(บัค)",Callback=function(v) AUTO_WARP_GUN=v end})
Home:Toggle({Title="Infinite Jump",Desc="กระโดดได้เรื่อยๆ",Callback=function(v) INFINITE_JUMP=v end})
Home:Toggle({Title="NoClip",Desc="เดินทะลุกำแพง",Callback=function(v) NOCLIP=v end})
Combat:Toggle({Title="Aim Lock",Desc="ล็อคเป้าฆาตกร",Callback=function(v) AIMLOCK=v LOCK_TARGET=nil end})
Combat:Toggle({Title="Silent Aim(Bug)",Desc="ยิงทะลุแบบเนียน(บัค)",Callback=function(v) SILENT_AIM=v end})

-- F key toggle fly
UIS.InputBegan:Connect(function(i,g)
if not g and i.KeyCode==Enum.KeyCode.F then setFly(not flying) end
end)

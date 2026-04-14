local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()      
      
Window:AddMinimizeButton({      
Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },      
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
local AUTO_SHOOT = false      
local AUTO_KNIFE = false      
local KILL_AURA = false      
local KNIFE_RANGE = 1000      
local KILL_AURA_RANGE = 2000      
local AUTO_COIN_COLLECT = false      
local CHAT_ANNOUNCE = false      
local Anti_Pling = false      
      
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
-- ESP (FULL REALTIME)      
-- =========================      
      
local function createESP(char, role)      
local head = char:FindFirstChild("Head")      
if not head then return end      
      
-- ===== Highlight =====      
local hl = char:FindFirstChild("KuoHL")      
if not hl then      
hl = Instance.new("Highlight")      
hl.Name = "KuoHL"      
hl.FillTransparency = 0.5      
hl.OutlineTransparency = 0      
hl.Parent = char      
end      
      
-- ===== Billboard =====      
local bill = head:FindFirstChild("KuoTag")      
if not bill then      
bill = Instance.new("BillboardGui")      
bill.Name = "KuoTag"      
bill.Size = UDim2.new(0,100,0,40)      
bill.StudsOffset = Vector3.new(0,2,0)      
bill.AlwaysOnTop = true      
bill.Parent = head      
      
local text = Instance.new("TextLabel")      
text.Name = "Text"      
text.Size = UDim2.new(1,0,1,0)      
text.BackgroundTransparency = 1      
text.TextScaled = true      
text.Font = Enum.Font.GothamBold      
text.Parent = bill      
      
end      
      
local text = bill:FindFirstChild("Text")      
if not text then return end      
      
-- ===== REALTIME UPDATE =====      
if role == "Murderer" then      
hl.FillColor = Color3.fromRGB(255,0,0)      
hl.OutlineColor = Color3.fromRGB(255,0,0)      
      
text.Text = "ฆาตกร"      
text.TextColor3 = Color3.fromRGB(255,0,0)      
      
elseif role == "Sheriff" then      
hl.FillColor = Color3.fromRGB(170,0,255)      
hl.OutlineColor = Color3.fromRGB(170,0,255)      
      
text.Text = "นายอำเภอ"      
text.TextColor3 = Color3.fromRGB(170,0,255)      
      
else      
hl.FillColor = Color3.fromRGB(0,255,0)      
hl.OutlineColor = Color3.fromRGB(0,255,0)      
      
text.Text = "ผู้บริสุทธิ์"      
text.TextColor3 = Color3.fromRGB(0,255,0)      
      
end      
      
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
      
-- =========================      
-- ESP LOOP (REALTIME 100%)      
-- =========================      
task.spawn(function()      
while task.wait(0.15) do -- 🔥 เร็วมาก อัปเดตตลอด      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player then      
local char = plr.Character      
      
if char then      
if ESP_ENABLED then      
local role = getRole(plr)      
createESP(char, role)      
else      
clearESP(char)      
end      
end      
end      
end      
end      
      
end)      
      
-- =========================      
-- PLAYER JOIN SUPPORT      
-- =========================      
Players.PlayerAdded:Connect(function(plr)      
plr.CharacterAdded:Connect(function(char)      
task.wait(0.5)      
if ESP_ENABLED then      
createESP(char, getRole(plr))      
end      
end)      
end)      
      
-- =========================      
-- 🔍 หา Sheriff (ตัวเดียว)      
-- =========================      
local function getSheriff()      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and getRole(plr) == "Sheriff" then      
return plr      
end      
end      
end      
      
-- =========================      
-- 💀 เช็ค Sheriff ตาย      
-- =========================      
local function isSheriffDead()      
local sheriff = getSheriff()      
if not sheriff or not sheriff.Character then return false end      
      
local hum = sheriff.Character:FindFirstChildOfClass("Humanoid")      
if not hum then return false end      
      
return hum.Health <= 0      
      
end      
      
-- =========================      
-- 🔫 หา Gun ที่ตก      
-- =========================      
local function findDroppedGun()      
for _, v in ipairs(workspace:GetDescendants()) do      
if v:IsA("Tool") and v.Name == "Gun" and v.Parent == workspace then      
local handle = v:FindFirstChild("Handle")      
if handle and handle:IsA("BasePart") then      
return handle      
end      
end      
end      
end      
      
-- =========================      
-- 🚀 AUTO WARP GUN (FINAL)      
-- =========================      
local AUTO_WARP_GUN_RANGE = 150 -- ปรับได้      
      
RunService.RenderStepped:Connect(function()      
if not AUTO_WARP_GUN then return end      
      
-- ❗ ต้อง Sheriff ตายก่อน      
if not isSheriffDead() then return end      
      
local char = player.Character      
local root = char and char:FindFirstChild("HumanoidRootPart")      
if not root then return end      
      
local backpack = player:FindFirstChild("Backpack")      
      
-- ✅ มีปืนแล้ว = หยุด      
if backpack and backpack:FindFirstChild("Gun") then return end      
      
local gun = findDroppedGun()      
if not gun then return end      
      
-- 🔥 เช็คระยะ (กันโป๊ะ)      
local dist = (gun.Position - root.Position).Magnitude      
if dist > AUTO_WARP_GUN_RANGE then return end      
      
-- 💾 เซฟตำแหน่ง      
local oldCF = root.CFrame      
      
-- 🔥 วาร์ปไป      
root.CFrame = gun.CFrame + Vector3.new(0, 2.5, 0)      
      
task.wait(0.05)      
      
-- 🔫 เก็บปืน      
for i = 1, 6 do      
firetouchinterest(root, gun, 0)      
firetouchinterest(root, gun, 1)      
task.wait(0.02)      
      
if backpack and backpack:FindFirstChild("Gun") then      
break      
end      
      
end      
      
task.wait(0.02)      
      
-- 🔙 กลับที่เดิม      
root.CFrame = oldCF      
      
end)      
-- =========================      
-- AUTO SHOOT (FIXED)      
-- =========================      
local function findMurderer()      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and getRole(plr) == "Murderer" then      
return plr      
end      
end      
end      
      
local function getLeadCFrame(targetChar, originPos)      
local head = targetChar:FindFirstChild("Head")      
local root = targetChar:FindFirstChild("HumanoidRootPart")      
if not head or not root then return end      
      
-- ✅ ใช้ตัวใหม่      
local velocity = root.AssemblyLinearVelocity      
      
local distance = (head.Position - originPos).Magnitude      
local predictTime = math.clamp(distance / 200, 0.15, 0.35)      
      
local predictedPos = head.Position + (velocity * predictTime)      
      
-- ชดเชยการกระโดด (แกน Y)      
predictedPos = predictedPos + Vector3.new(0, math.clamp(velocity.Y * 0.1, 0, 2), 0)      
      
return CFrame.new(predictedPos)      
      
end      
      
task.spawn(function()      
while task.wait(0.01) do      
if not AUTO_SHOOT then continue end      
      
local target = findMurderer()      
if not target or not target.Character then continue end      
      
local char = player.Character      
local gun = char and char:FindFirstChild("Gun")      
if not gun then continue end      
      
local shootEvent = gun:FindFirstChild("Shoot")      
local originPart = gun:FindFirstChild("Handle")      
if not shootEvent or not originPart then continue end      
      
local originCF = originPart.CFrame      
local targetCF = getLeadCFrame(target.Character, originPart.Position)      
      
if targetCF then      
pcall(function()      
shootEvent:FireServer(      
originCF,      
targetCF      
)      
end)      
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
-- AIMLOCK      
-- =========================      
local function getMurdererRoot()      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and getRole(plr) == "Murderer" then      
return plr.Character:FindFirstChild("HumanoidRootPart")      
end      
end      
end      
      
RunService.RenderStepped:Connect(function()      
if AIMLOCK then      
if not LOCK_TARGET or not LOCK_TARGET.Parent then      
LOCK_TARGET = getMurdererRoot()      
end      
local cam = workspace.CurrentCamera      
if LOCK_TARGET then      
cam.CFrame = CFrame.new(cam.CFrame.Position, LOCK_TARGET.Position)      
end      
end      
end)      
      
local AUTO_KNIFE = false      
local KNIFE_RANGE = 100      
      
local function getClosestTarget()      
local closest = nil      
local shortest = KNIFE_RANGE      
      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then      
local enemyRoot = plr.Character.HumanoidRootPart      
local dist = (enemyRoot.Position - root.Position).Magnitude      
      
if dist < shortest then      
shortest = dist      
closest = plr      
end      
end      
      
end      
      
return closest      
      
end      
      
local function fireKnife(targetPart)
    local char = player.Character
    if not char then return end

    local knife = char:FindFirstChild("Knife")
    if not knife then return end

    local events = knife:FindFirstChild("Events")
    if not events then return end

    local remote = events:FindFirstChild("HandleTouched")
    if not remote then return end

    pcall(function()
        remote:FireServer(targetPart)
    end)
end


task.spawn(function()
    while task.wait(0.1) do
        if not AUTO_KNIFE then continue end
        if getRole(player) ~= "Murderer" then continue end

        local target = getClosestTarget()
        if not target or not target.Character then continue end

        local enemyRoot = target.Character:FindFirstChild("HumanoidRootPart")
        local hum = target.Character:FindFirstChildOfClass("Humanoid")

        if not enemyRoot or not hum or hum.Health <= 0 then continue end

        -- ระยะกันมั่ว
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        if (enemyRoot.Position - root.Position).Magnitude > KNIFE_RANGE then
            continue
        end

        fireKnife(enemyRoot)
    end
end)
      
local function getAuraTarget()      
local closest = nil      
local shortest = KILL_AURA_RANGE      
      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then      
      
local dist = (plr.Character.HumanoidRootPart.Position - root.Position).Magnitude      
      
if dist < shortest then      
shortest = dist      
closest = plr      
end      
      
end      
      
end      
      
return closest      
      
end      
      
task.spawn(function()
    while task.wait(0.1) do
        if not KILL_AURA then continue end
        if getRole(player) ~= "Murderer" then continue end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        local target = getAuraTarget()
        if not target or not target.Character then continue end

        local enemyChar = target.Character
        local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
        local hum = enemyChar:FindFirstChildOfClass("Humanoid")

        -- 🔥 กัน lobby / ตาย
        if not enemyRoot or not hum or hum.Health <= 0 then continue end

        -- 🔥 ระยะ
        if (enemyRoot.Position - root.Position).Magnitude > KILL_AURA_RANGE then continue end

        local oldCF = root.CFrame
        root.CFrame = enemyRoot.CFrame

        task.wait(0.05)

        -- 🔪 ใช้ Remote ใหม่แทน Activate
        fireKnife(enemyRoot)

        task.wait(0.03)
        root.CFrame = oldCF
    end
end)
      
local TweenService = game:GetService("TweenService")      
      
local COIN_SPEED = 30      
local SAFE_DISTANCE = 40      
local STUCK_TIME = 1      
      
local currentTarget = nil      
local lastMoveTime = tick()      
local lastPos = nil      
      
-- 🔍 หาเหรียญแบบฉลาด (หลบคน)      
local function getSmartCoin(root)      
local bestCoin = nil      
local bestScore = math.huge      
      
for _, coin in ipairs(workspace:GetDescendants()) do      
if (coin.Name == "Coin" or coin.Name == "Coin_Server") and coin:IsA("BasePart") then      
      
local dist = (coin.Position - root.Position).Magnitude      
      
-- 🧠 เช็คศัตรูใกล้เหรียญ      
local danger = 0      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then      
local d = (plr.Character.HumanoidRootPart.Position - coin.Position).Magnitude      
if d < SAFE_DISTANCE then      
danger = danger + (SAFE_DISTANCE - d)      
end      
end      
end      
      
-- 🎯 score ต่ำ = ดี      
local score = dist + (danger * 5)      
      
if score < bestScore then      
bestScore = score      
bestCoin = coin      
end      
      
end      
      
end      
      
return bestCoin      
      
end      
      
-- 🚀 Tween Fly (เนียน + กันแบน)      
local function tweenTo(root, pos)      
local dist = (root.Position - pos).Magnitude      
local time = dist / COIN_SPEED      
      
local tween = TweenService:Create(      
root,      
TweenInfo.new(time, Enum.EasingStyle.Linear),      
{CFrame = CFrame.new(pos)}      
)      
      
tween:Play()      
return tween      
      
end      
      
-- 🔥 LOOP      
task.spawn(function()      
while task.wait(0.01) do      
if not AUTO_COIN_COLLECT then continue end      
      
local char = player.Character      
local root = char and char:FindFirstChild("HumanoidRootPart")      
if not root then continue end      
      
-- ❗ ปิด Fly ปกติ      
if flying then      
setFly(false)      
end      
      
-- 🎯 ล็อคเป้าหมาย      
if not currentTarget or not currentTarget.Parent then      
currentTarget = getSmartCoin(root)      
end      
      
if not currentTarget then continue end      
      
local targetPos = currentTarget.Position + Vector3.new(0, 2, 0)      
      
-- 🚀 Tween ไปหา      
local tween = tweenTo(root, targetPos)      
      
-- 🧠 Anti Stuck      
local startTime = tick()      
lastPos = root.Position      
      
while tween.PlaybackState == Enum.PlaybackState.Playing do      
task.wait(0.01)      
      
if not AUTO_COIN_COLLECT then      
tween:Cancel()      
break      
end      
      
-- 🧱 ติด = วาร์ป      
if (root.Position - lastPos).Magnitude < 1 then      
if tick() - startTime > STUCK_TIME then      
root.CFrame = CFrame.new(targetPos)      
break      
end      
else      
startTime = tick()      
lastPos = root.Position      
end      
      
end      
      
-- 🔄 รีเซ็ตเป้าหมาย      
currentTarget = nil      
      
end      
      
end)      
      
-- =========================      
-- 📢 CHAT ANNOUNCE (FIXED)      
-- =========================      
      
local TextChatService = game:GetService("TextChatService")      
local ReplicatedStorage = game:GetService("ReplicatedStorage")      
      
-- 🔥 ส่งแชท (โคตรเสถียร)      
local function sendChat(msg)      
pcall(function()      
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then      
      
local channels = TextChatService:WaitForChild("TextChannels", 2)      
local channel = channels and channels:FindFirstChild("RBXGeneral")      
      
if channel then          
        channel:SendAsync(msg)          
    else          
        warn("No RBXGeneral channel")          
    end          
      
else          
    ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")          
        :WaitForChild("SayMessageRequest")          
        :FireServer(msg, "All")          
end      
      
end)      
      
end      
      
-- 🔪 หา Murderer      
local function getMurderer()      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and getRole(plr) == "Murderer" then      
return plr      
end      
end      
end      
      
-- 👮 หา Sheriff      
local function getSheriffPlayer()      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr ~= player and getRole(plr) == "Sheriff" then      
return plr      
end      
end      
end      
      
-- 🔁 Loop ประกาศ      
task.spawn(function()      
local announced = false      
      
while task.wait(0.1) do      
if not CHAT_ANNOUNCE then      
announced = false      
continue      
end      
      
if not announced then                      
    local murderer = getMurderer()                      
    local sheriff = getSheriffPlayer()                      
      
    if murderer and sheriff then                      
        local msg = "Murderer: "..murderer.Name..          
        " | Sheriff: "..sheriff.Name..          
        " | Kuo Hub"          
      
        sendChat(msg)                      
        announced = true            
      
        task.wait(0.01) -- ✅ ต้อง 1-2 วิ ถึงจะเสถียร          
    end                      
end                      
      
-- 🔄 รีรอบใหม่          
if not getMurderer() and not getSheriffPlayer() then                      
    announced = false                      
end      
      
end      
      
end)      
      
-- =========================      
-- SYSTEM: ANTI PLING (NO COLLIDE)      
-- =========================      
      
local function setCollision(character, state)      
for _, part in ipairs(character:GetDescendants()) do      
if part:IsA("BasePart") then      
part.CanCollide = state      
end      
end      
end      
      
local function applyNoCollide(player)      
if not player.Character then return end      
      
setCollision(player.Character, false)      
      
player.Character.DescendantAdded:Connect(function(part)      
if part:IsA("BasePart") then      
part.CanCollide = false      
end      
end)      
      
end      
      
-- =========================      
-- MAIN LOOP (TOGGLE CONTROL)      
-- =========================      
task.spawn(function()      
while task.wait(0.01) do      
if Anti_Pling then      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr.Character then      
applyNoCollide(plr)      
end      
end      
else      
for _, plr in ipairs(Players:GetPlayers()) do      
if plr.Character then      
setCollision(plr.Character, true)      
end      
end      
end      
end      
end)      
      
-- =========================      
-- UI      
-- =========================      
Home:AddDiscordInvite({      
Name = "Kuo Hub",      
Description = "Join server",      
Logo = "rbxassetid://103308551113442",      
Invite = "https://discord.gg/Apn2j9Fez",      
})      
Home:Toggle({Title="ESP",Desc="ไฮไลต์ผู้เล่น",Callback=function(v) ESP_ENABLED=v end})      
Home:Toggle({Title="Fly",Desc="บิน",Callback=function(v) setFly(v) end})    
Home:Toggle({Title="Auto Warp Gun(Bug)",Desc="วาร์ปเก็บปืน(บัค)",Callback=function(v) AUTO_WARP_GUN=v end})      
Home:Toggle({Title="Infinite Jump",Desc="กระโดดไม่จำกัด",Callback=function(v) INFINITE_JUMP=v end})      
Home:Toggle({Title="NoClip",Desc="ทะลุกำแพง",Callback=function(v) NOCLIP=v end})      
      
Combat:Toggle({Title="Aim Lock",Desc="ล็อคฆาตกร",Callback=function(v) AIMLOCK=v LOCK_TARGET=nil end})      
Combat:Toggle({Title="Auto Shoot",Desc="ยิงออโต้",Callback=function(v) AUTO_SHOOT=v end})      
Combat:Toggle({      
Title="Auto Knife",      
Desc="ปามีดอัตโนมัติ",      
Callback=function(v)      
AUTO_KNIFE=v      
end      
})      
Combat:Toggle({      
Title="Kill Aura",      
Desc="ฆ่าทุกคนอัตโนมัติ",      
Callback=function(v)      
KILL_AURA=v      
end      
})      
      
Home:Toggle({      
Title = "Auto Coin Collect",      
Desc = "ออโต้เก็บเหรียญ",      
Callback = function(v)      
AUTO_COIN_COLLECT = v      
end      
})      
      
Home:Toggle({      
Title="Reveal Role",      
Desc="เปิดเผยวายร้าย",      
Callback=function(v)      
CHAT_ANNOUNCE = v      
end      
})      
      
Home:Toggle({      
Title="Anti-Pling",      
Desc="กันปลิง",      
Callback=function(v)      
Anti_Pling = v      
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
    
Home:AddSlider({    
    Name = "Adjust flight speed",    
    Min = 16,    
    Max = 200,    
    Default = 60,    
    Callback = function(v)    
        speed = v    
    end    
})    
    
Home:AddSlider({
    Name = "Coin Collect Speed",
    Min = 16,
    Max = 200,
    Default = 30,
    Callback = function(v)
        COIN_SPEED = v
    end
})

-- KEY      
UIS.InputBegan:Connect(function(i,g)      
if not g and i.KeyCode == Enum.KeyCode.F then      
setFly(not flying)      
end      
end)

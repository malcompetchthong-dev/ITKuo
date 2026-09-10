local KuoHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/Librarykuohub-BETA.lua"))()

local Window = KuoHub:MakeWindow({
    Title = "Kuo Hub | +1 speed keyboard"
})

Window:AddMinimizeButton({
    Button = {
        Image = "rbxassetid://126460540157931",
        BackgroundTransparency = 0
    },
    Position = UDim2.new(0,20,0.5,-25)
})
  
local Home = Window:Tab("Home")  
  
local Combat = Window:MakeTab({"Combat","sword"})  

local Info = Window:MakeTab({"System","history"})

--// Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// States
local ESP_ENABLED = false
local INFINITE_JUMP = false
local NOCLIP = false

--// Storage
local ESPObjects = {}
local walkSpeed = 16

--==================================================
-- ESP
--==================================================

local function removeESP(player)
if ESPObjects[player] then
ESPObjects[player]:Destroy()
ESPObjects[player] = nil
end
end

local function createESP(player)
if player == LocalPlayer then
return
end

if ESPObjects[player] then    
    return    
end    

local function addCharacter(character)    
    if not ESP_ENABLED then    
        return    
    end    

    removeESP(player)    

    local highlight = Instance.new("Highlight")    
    highlight.Name = "KuoHub_ESP"    
    highlight.Adornee = character    
    highlight.FillTransparency = 0.5    
    highlight.OutlineTransparency = 0    
    highlight.FillColor = Color3.fromRGB(170, 0, 255)    
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)    
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop    
    highlight.Parent = character    

    ESPObjects[player] = highlight    
end    

if player.Character then    
    addCharacter(player.Character)    
end    

player.CharacterAdded:Connect(function(character)    
    task.wait(0.5)    

    if ESP_ENABLED then    
        addCharacter(character)    
    end    
end)

end

local function setESP(state)
ESP_ENABLED = state

if state then    
    for _, player in ipairs(Players:GetPlayers()) do    
        createESP(player)    
    end    
else    
    for player in pairs(ESPObjects) do    
        removeESP(player)    
    end    
end

end

Players.PlayerAdded:Connect(function(player)
if ESP_ENABLED then
createESP(player)
end
end)

Players.PlayerRemoving:Connect(function(player)
removeESP(player)
end)
--==================================================
-- Fly
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local speed = 60
local TOGGLE_KEY = Enum.KeyCode.F

--==================================================
-- VARIABLES
--==================================================

local Character
local Humanoid
local Root
local Animator
local AnimateScript

local Flying = false

local BodyVelocity
local BodyGyro
local IdleTrack

local PCKeys = {
	W = false,
	A = false,
	S = false,
	D = false,
	Up = false,
	Down = false
}

--==================================================
-- CHARACTER SETUP
--==================================================

local function SetupCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()

	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")

	Animator = Humanoid:FindFirstChildOfClass("Animator")

	if not Animator then
		Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end

	AnimateScript = Character:FindFirstChild("Animate")
end

SetupCharacter()

Player.CharacterAdded:Connect(function()
	Flying = false

	if BodyVelocity then
		BodyVelocity:Destroy()
		BodyVelocity = nil
	end

	if BodyGyro then
		BodyGyro:Destroy()
		BodyGyro = nil
	end

	if IdleTrack then
		IdleTrack:Stop()
		IdleTrack:Destroy()
		IdleTrack = nil
	end

	task.wait(0.2)
	SetupCharacter()
end)

--==================================================
-- STOP NORMAL ANIMATIONS
--==================================================

local function StopNormalAnimations()
	if not Animator then
		return
	end

	for _, Track in ipairs(Animator:GetPlayingAnimationTracks()) do
		Track:Stop(0.1)
	end
end

--==================================================
-- IDLE ANIMATION
--==================================================

local function StartIdleAnimation()
	if not Animator then
		return
	end

	StopNormalAnimations()

	local Animation = Instance.new("Animation")

	if Humanoid.RigType == Enum.HumanoidRigType.R15 then
		Animation.AnimationId = "rbxassetid://507766666"
	else
		Animation.AnimationId = "rbxassetid://180435571"
	end

	IdleTrack = Animator:LoadAnimation(Animation)
	IdleTrack.Priority = Enum.AnimationPriority.Idle
	IdleTrack.Looped = true
	IdleTrack:Play(0.15)

	Animation:Destroy()
end

local function StopIdleAnimation()
	if IdleTrack then
		IdleTrack:Stop(0.15)
		IdleTrack:Destroy()
		IdleTrack = nil
	end
end

--==================================================
-- START FLY
--==================================================

local function StartFly()
	if Flying then
		return
	end

	if not Character or not Humanoid or not Root then
		return
	end

	Flying = true

	StopNormalAnimations()

	if AnimateScript then
		AnimateScript.Enabled = false
	end

	Humanoid.AutoRotate = false

	BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.Name = "FlyVelocity"
	BodyVelocity.MaxForce = Vector3.new(
		math.huge,
		math.huge,
		math.huge
	)
	BodyVelocity.P = 50000
	BodyVelocity.Velocity = Vector3.zero
	BodyVelocity.Parent = Root

	BodyGyro = Instance.new("BodyGyro")
	BodyGyro.Name = "FlyGyro"
	BodyGyro.MaxTorque = Vector3.new(
		math.huge,
		math.huge,
		math.huge
	)
	BodyGyro.P = 50000
	BodyGyro.D = 1000
	BodyGyro.CFrame = Root.CFrame
	BodyGyro.Parent = Root

	StartIdleAnimation()
end

--==================================================
-- STOP FLY
--==================================================

local function StopFly()
	if not Flying then
		return
	end

	Flying = false

	if BodyVelocity then
		BodyVelocity:Destroy()
		BodyVelocity = nil
	end

	if BodyGyro then
		BodyGyro:Destroy()
		BodyGyro = nil
	end

	StopIdleAnimation()

	if AnimateScript then
		AnimateScript.Enabled = true
	end

	Humanoid.AutoRotate = true

	Humanoid:ChangeState(
		Enum.HumanoidStateType.GettingUp
	)
end

--==================================================
-- SET FLY
--==================================================

function setFly(v)
	if v then
		StartFly()
	else
		StopFly()
	end
end

--==================================================
-- PC KEYBOARD
--==================================================

UserInputService.InputBegan:Connect(function(Input, Processed)
	if Processed then
		return
	end

	if Input.KeyCode == TOGGLE_KEY then
		setFly(not Flying)
		return
	end

	if Input.KeyCode == Enum.KeyCode.W then
		PCKeys.W = true

	elseif Input.KeyCode == Enum.KeyCode.A then
		PCKeys.A = true

	elseif Input.KeyCode == Enum.KeyCode.S then
		PCKeys.S = true

	elseif Input.KeyCode == Enum.KeyCode.D then
		PCKeys.D = true

	elseif Input.KeyCode == Enum.KeyCode.Space then
		PCKeys.Up = true

	elseif Input.KeyCode == Enum.KeyCode.LeftControl then
		PCKeys.Down = true
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.W then
		PCKeys.W = false

	elseif Input.KeyCode == Enum.KeyCode.A then
		PCKeys.A = false

	elseif Input.KeyCode == Enum.KeyCode.S then
		PCKeys.S = false

	elseif Input.KeyCode == Enum.KeyCode.D then
		PCKeys.D = false

	elseif Input.KeyCode == Enum.KeyCode.Space then
		PCKeys.Up = false

	elseif Input.KeyCode == Enum.KeyCode.LeftControl then
		PCKeys.Down = false
	end
end)

--==================================================
-- PC DIRECTION
--==================================================

local function GetPCDirection(Camera)
	local Direction = Vector3.zero

	local Forward = Camera.CFrame.LookVector
	local Right = Camera.CFrame.RightVector

	if PCKeys.W then
		Direction += Forward
	end

	if PCKeys.S then
		Direction -= Forward
	end

	if PCKeys.D then
		Direction += Right
	end

	if PCKeys.A then
		Direction -= Right
	end

	if PCKeys.Up then
		Direction += Vector3.new(0, 1, 0)
	end

	if PCKeys.Down then
		Direction -= Vector3.new(0, 1, 0)
	end

	if Direction.Magnitude > 1 then
		Direction = Direction.Unit
	end

	return Direction
end

--==================================================
-- MOBILE DIRECTION
--==================================================

local function GetMobileDirection(Camera)
	local Move = Humanoid.MoveDirection

	if Move.Magnitude <= 0.01 then
		return Vector3.zero
	end

	local Look = Camera.CFrame.LookVector
	local Right = Camera.CFrame.RightVector

	local FlatForward = Vector3.new(
		Look.X,
		0,
		Look.Z
	)

	local FlatRight = Vector3.new(
		Right.X,
		0,
		Right.Z
	)

	if FlatForward.Magnitude > 0 then
		FlatForward = FlatForward.Unit
	end

	if FlatRight.Magnitude > 0 then
		FlatRight = FlatRight.Unit
	end

	local ForwardAmount = Move:Dot(FlatForward)
	local RightAmount = Move:Dot(FlatRight)

	local Direction =
		Look * ForwardAmount
		+
		FlatRight * RightAmount

	if Direction.Magnitude > 1 then
		Direction = Direction.Unit
	end

	return Direction
end

--==================================================
-- MAIN FLY LOOP
--==================================================

RunService.RenderStepped:Connect(function()
	if not Flying then
		return
	end

	if not Character
		or not Humanoid
		or not Root
		or not BodyVelocity
		or not BodyGyro then
		return
	end

	local Camera = workspace.CurrentCamera

	local Direction

	-- PC
	if UserInputService.KeyboardEnabled then
		Direction = GetPCDirection(Camera)

	-- Mobile
	else
		Direction = GetMobileDirection(Camera)
	end

	--================================================
	-- SPEED
	--================================================

	BodyVelocity.Velocity = Direction * speed

	--================================================
	-- ROTATION
	--================================================

	if Direction.Magnitude > 0.01 then

		BodyGyro.CFrame = CFrame.lookAt(
			Root.Position,
			Root.Position + Direction.Unit
		)

	else

		local Look = Camera.CFrame.LookVector

		BodyGyro.CFrame = CFrame.lookAt(
			Root.Position,
			Root.Position + Look
		)
	end

	--================================================
	-- KEEP IDLE
	--================================================

	if IdleTrack and not IdleTrack.IsPlaying then
		IdleTrack:Play(0.1)
	end
end)--==================================================
-- Infinite Jump
--==================================================

--==================================================
-- Infinite Jump
--==================================================

UIS.JumpRequest:Connect(function()
if not INFINITE_JUMP then
return
end

local character = LocalPlayer.Character    
if not character then    
    return    
end    

local humanoid = character:FindFirstChildOfClass("Humanoid")    
if humanoid then    
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)    
end

end)

--==================================================
-- NoClip
--==================================================

RunService.Stepped:Connect(function()
if not NOCLIP then
return
end

local character = LocalPlayer.Character    
if not character then    
    return    
end    

for _, part in ipairs(character:GetDescendants()) do    
    if part:IsA("BasePart") then    
        part.CanCollide = false    
    end    
end

end)

-- คืนค่า CanCollide เมื่อปิด NoClip
local function disableNoClip()
local character = LocalPlayer.Character
if not character then
return
end

for _, part in ipairs(character:GetDescendants()) do    
    if part:IsA("BasePart") then    
        if part.Name ~= "HumanoidRootPart" then    
            part.CanCollide = true    
        end    
    end    
end

end

--==================================================
-- Invisible Mode
--==================================================

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

function applyInvisible(state)
setInvisible(state)
end

setupCharacter()

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

player.CharacterAdded:Connect(function()
invisible = false
setupCharacter()
end)

--==================================================
-- Character Respawn
--==================================================

LocalPlayer.CharacterAdded:Connect(function()
task.wait(1)
end)

--==================================================
-- Bypass Treadmill 
--==================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local Bypass = {
    Enabled = false,
    Connections = {},
    Old = {},
    Hook = nil,
    Spoofed = false,
    RapidFire = nil
}

local UpdateSpeed = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("UpdateSpeed")

-- ========== Raycast Filter (เหมือนต้นฉบับ) ==========
local treadmillFilter
pcall(function()
    treadmillFilter = require(ReplicatedStorage:WaitForChild("Treadmill"):WaitForChild("Raycast")).getTreadmillFilter()
end)

-- ========== Check Floor ==========
local function checkFloor()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not treadmillFilter then return nil end
    
    local result = workspace:Raycast(hrp.Position, Vector3.new(0, -7, 0), treadmillFilter)
    if not (result and result.Instance) then return nil end
    
    local inst = result.Instance
    local tags = {
        {"AdminTreadmill", "AdminTreadmill"},
        {"AdminAbuseTreadmill", "AdminAbuseTreadmill"},
        {"CandyTreadmill", "CandyTreadmill"},
        {"DiamondTreadmill", "DiamondTreadmill"},
        {"GoldTreadmill", "GoldTreadmill"},
        {"AATreadmillX3ll3n", "AATreadmillX3ll3n"},
        {"HourlyTreadmill", "HourlyTreadmill"},
        {"DailyTreadmill", "DailyTreadmill"},
        {"Treadmill", "Treadmill"},
        {"VoidTreadmillAAChichine", "VoidTreadmillAAChichine"},
        {"AdminAbuse_IndependanceTreadmill", "AdminAbuse_IndependanceTreadmill"},
        {"AdminAbuse_July14thTreadmill", "AdminAbuse_July14thTreadmill"},
        {"AdminAbuse_WorldCupTreadmill", "AdminAbuse_WorldCupTreadmill"},
        {"BBNOConcertTreadmill", "BBNOConcertTreadmill"},
        {"SummerTreadmill", "SummerTreadmill"},
    }
    
    for _, pair in ipairs(tags) do
        if CollectionService:HasTag(inst, pair[1]) then
            return pair[2]
        end
    end
    return nil
end

-- ========== Spoof ClientState ==========
local function spoofState()
    if not Bypass.Enabled then return end
    pcall(function()
        local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))
        if not Bypass.Old.Get and ClientState.Get then
            Bypass.Old.Get = ClientState.Get
        end
        if ClientState.Get == Bypass.Old.Get or not Bypass.Spoofed then
            ClientState.Get = function(self, ...)
                local r = Bypass.Old.Get(self, ...)
                if type(r) == "table" then
                    r.AdminTreadmillActive = true
                    r.DiamondTreadmillActive = true
                    r.GoldTreadmillActive = true
                    r.CandyTreadmillActive = true
                end
                return r
            end
            Bypass.Spoofed = true
        end
    end)
end

-- ========== Fast Cooldown ==========
local function fastCooldown()
    pcall(function()
        local cfg = require(ReplicatedStorage:WaitForChild("Config")).XP_TIME_BASED
        if not Bypass.Old.Min then
            Bypass.Old.Min = cfg.MIN_COOLDOWN
            Bypass.Old.Max = cfg.MAX_COOLDOWN
        end
        cfg.MIN_COOLDOWN = 0.001
        cfg.MAX_COOLDOWN = 0.005
    end)
end

-- ========== ×1000 Rapid Fire ==========
local function startRapid()
    if Bypass.RapidFire then return end
    Bypass.RapidFire = task.spawn(function()
        while Bypass.Enabled do
            local t = checkFloor()
            if t then
                -- ยิง 10 ครั้งต่อ 0.01 วิ = ความเร็ว×10 
                -- ถ้าต้องการ×1000 จริงๆ ให้เปลี่ยน 10 เป็น 100
                -- แต่ระวังอาจโดน kick ถ้ายิงมากเกินไป
                for i = 1, 1000 do
                    if not Bypass.Enabled then break end
                    UpdateSpeed:FireServer(t)
                end
            end
            task.wait(0.001)
        end
        Bypass.RapidFire = nil
    end)
end

-- ========== เปิด Bypass ==========
function EnableBypass()
    if Bypass.Enabled then return end
    Bypass.Enabled = true

    spoofState()
    fastCooldown()
    startRapid()

    -- Respawn → spoof ซ้ำ
    table.insert(Bypass.Connections, LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        Bypass.Spoofed = false
        spoofState()
        fastCooldown()
    end))

    -- Loop ตรวจสอบทุก 2 วิ (กัน script ต้นฉบับ reset)
    task.spawn(function()
        while Bypass.Enabled do
            task.wait(2)
            spoofState()
            fastCooldown()
        end
    end)

    -- Block Remote ซื้อแทรดมิลล์
    if hookmetamethod and not Bypass.Hook then
        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            if getnamecallmethod() == "FireServer" then
                local n = self.Name
                if n == "PromptAdminTreadmill" or n == "PromptDiamondTreadmill" 
                   or n == "PromptCandyTreadmill" or n == "PromptGoldTreadmill" then
                    return
                end
            end
            return old(self, ...)
        end)
        Bypass.Hook = old
    end

    -- ลบ ProximityPrompt / ClickDetector
    local function clean()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector") then
                local p = obj.Parent
                if p and (p.Name:lower():find("treadmill") or p.Name:lower():find("admin")) then
                    obj:Destroy()
                end
            end
        end
    end
    clean()
    table.insert(Bypass.Connections, workspace.DescendantAdded:Connect(function(d)
        if d:IsA("ProximityPrompt") or d:IsA("ClickDetector") then
            local p = d.Parent
            if p and (p.Name:lower():find("treadmill") or p.Name:lower():find("admin")) then
                d:Destroy()
            end
        end
    end))

    print("✅ Treadmill Bypass | ×1000 Rapid Fire")
end

-- ========== ปิด Bypass ==========
function DisableBypass()
    if not Bypass.Enabled then return end
    Bypass.Enabled = false
    Bypass.Spoofed = false

    for _, c in ipairs(Bypass.Connections) do
        pcall(function() c:Disconnect() end)
    end
    Bypass.Connections = {}

    pcall(function()
        local cs = require(ReplicatedStorage:WaitForChild("ClientState"))
        if Bypass.Old.Get then cs.Get = Bypass.Old.Get end
    end)
    
    pcall(function()
        local cfg = require(ReplicatedStorage:WaitForChild("Config")).XP_TIME_BASED
        cfg.MIN_COOLDOWN = Bypass.Old.Min or 0.1
        cfg.MAX_COOLDOWN = Bypass.Old.Max or 1.0
    end)

    print("❌ Disabled")
end

--===========≈======================================
--into
--==================================================

Info:Section("📌 KuoHub Information | ข้อมูลสคริปต์")

Info:Button({
Title = "📅 Last Update | อัปเดตล่าสุด :12/07/2026",
Callback = function()
end
})

Info:Button({
Title = "🇹🇭 Developed By Thai | พัฒนาโดยคนไทย",
Callback = function()
end
})

Info:Button({
Title = "⚡ Script Version | เวอร์ชันสคริปต์ : v10.1 FUTURISTIC",
Callback = function()
end
})

Info:Button({
Title = "🛠 Status : ✔️| สถานะ : Stable✔️",
Callback = function()
end
})

Info:Button({
Title = "📃 Punk status : Yes | สถานะพังค์ชั้น : ยังใช้งานได้",
Callback = function()
end
})

--==================================================
-- UI TOGGLES
--==================================================

Home:AddDiscordInvite({  
Name = "Kuo Hub",  
Description = "Join server",  
Logo = "rbxassetid://126460540157931",  
Invite = "https://discord.gg/Apn2j9Fez",  
})

Home:Toggle({
Title = "ESP",
Desc = "ไฮไลต์ผู้เล่น",
Callback = function(v)
setESP(v)
end
})

Home:Toggle({
	Title = "Fly",
	Desc = "บิน",
	Callback = function(v)
		setFly(v)
	end
})

Home:AddSlider({
	Name = "Adjust flight speed",
	Min = 16,
	Max = 200,
	Default = 60,
	Callback = function(v)
		speed = v
	end
})

Home:Toggle({
    Title = "Treadmill Bypass",
    Desc = "ปลดล็อกลู่วิ่ง",
    Callback = function(v)
        if v then EnableBypass() else DisableBypass() end
    end
})

Home:Toggle({
Title = "Infinite Jump",
Desc = "กระโดดไม่จำกัด",
Callback = function(v)
INFINITE_JUMP = v
end
})

Home:Toggle({
Title = "NoClip",
Desc = "ทะลุกำแพง",
Callback = function(v)
NOCLIP = v

if not v then    
        disableNoClip()    
    end    
end

})

Combat:Toggle({
Title = "Invisible Mode",
Desc = "ร่องหน",
Callback = function(v)
applyInvisible(v)
end
})

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
local Auto_win = false
local AntiDie = false
local CurrentWorld = "World 1"
local SelectedTarget = "Smart"

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
local RunService = game:GetService("RunService")

local Bypass = {
    Enabled = false,
    Connections = {},
    Old = {},
    Hook = nil,
    Spoofed = false
}

-- ========== Spoof ClientState ==========
local function SpoofClientState()
    if not Bypass.Enabled then return end
    pcall(function()
        local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))
        if not ClientState then return end
        if not Bypass.Old.ClientStateGet and ClientState.Get then
            Bypass.Old.ClientStateGet = ClientState.Get
        end
        if ClientState.Get == Bypass.Old.ClientStateGet or not Bypass.Spoofed then
            ClientState.Get = function(self, ...)
                local result = Bypass.Old.ClientStateGet(self, ...)
                if type(result) == "table" then
                    result.AdminTreadmillActive = true
                    result.DiamondTreadmillActive = true
                    result.GoldTreadmillActive = true
                    result.CandyTreadmillActive = true
                end
                return result
            end
            Bypass.Spoofed = true
        end
    end)
end

-- ========== แก้ Cooldown ให้ใกล้ 0 (ทำให้ความเร็วขึ้นเร็ว) ==========
local function FastCooldown()
    pcall(function()
        local Config = require(ReplicatedStorage:WaitForChild("Config"))
        if Config and Config.XP_TIME_BASED then
            if not Bypass.Old.MinCooldown then
                Bypass.Old.MinCooldown = Config.XP_TIME_BASED.MIN_COOLDOWN
                Bypass.Old.MaxCooldown = Config.XP_TIME_BASED.MAX_COOLDOWN
            end
            Config.XP_TIME_BASED.MIN_COOLDOWN = 0.01
            Config.XP_TIME_BASED.MAX_COOLDOWN = 0.05
        end
    end)
end

-- ========== เปิด Bypass ==========
function EnableBypass()
    if Bypass.Enabled then return end
    Bypass.Enabled = true

    SpoofClientState()
    FastCooldown()

    local charConn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        Bypass.Spoofed = false
        SpoofClientState()
        FastCooldown()
    end)
    table.insert(Bypass.Connections, charConn)
    
    task.spawn(function()
        while Bypass.Enabled do
            task.wait(2)
            if Bypass.Enabled then
                SpoofClientState()
                FastCooldown()
            end
        end
    end)

    if hookmetamethod and not Bypass.Hook then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" then
                local name = self.Name
                if name == "PromptAdminTreadmill" or name == "PromptDiamondTreadmill" 
                   or name == "PromptCandyTreadmill" or name == "PromptGoldTreadmill" then
                    return
                end
            end
            return oldNamecall(self, ...)
        end)
        Bypass.Hook = oldNamecall
    end

    local function cleanPrompts()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") or obj:IsA("ClickDetector") then
                local p = obj.Parent
                if p and (p.Name:lower():find("treadmill") or p.Name:lower():find("admin")) then
                    obj:Destroy()
                end
            end
        end
    end
    cleanPrompts()
    
    local conn = workspace.DescendantAdded:Connect(function(d)
        if d:IsA("ProximityPrompt") or d:IsA("ClickDetector") then
            local p = d.Parent
            if p and (p.Name:lower():find("treadmill") or p.Name:lower():find("admin")) then
                d:Destroy()
            end
        end
    end)
    table.insert(Bypass.Connections, conn)

    print("✅ Treadmill Bypass Enabled | Cooldown: 0.01s")
end

-- ========== ปิด Bypass ==========
function DisableBypass()
    if not Bypass.Enabled then return end
    Bypass.Enabled = false
    Bypass.Spoofed = false

    for _, conn in ipairs(Bypass.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    Bypass.Connections = {}

    pcall(function()
        local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))
        if ClientState and Bypass.Old.ClientStateGet then
            ClientState.Get = Bypass.Old.ClientStateGet
        end
    end)
    
    pcall(function()
        local Config = require(ReplicatedStorage:WaitForChild("Config"))
        if Config and Config.XP_TIME_BASED then
            Config.XP_TIME_BASED.MIN_COOLDOWN = Bypass.Old.MinCooldown or 0.1
            Config.XP_TIME_BASED.MAX_COOLDOWN = Bypass.Old.MaxCooldown or 1.0
        end
    end)

    print("❌ Treadmill Bypass Disabled")
end

--==================================================
-- AUTO WIN CORE (ย่อสั้น - ใส่เส้นทางเองได้)
--==================================================

local AutoWin = {}

--// ตั้งค่า
AutoWin.Enabled = false
AutoWin.RunId = 0
AutoWin.World = "World 1"
AutoWin.Target = "Smart"

--// ตาราง Targets ตาม World
AutoWin.Targets = {
    ["World 1"] = {"Smart","1 Win","3 Wins","10 Wins","20 Wins","50 Wins","100 Wins","150 Wins","300 Wins","500 Wins","1000 Wins","2500 Wins","10000 Wins","25000 Wins","50000 Wins","150K Wins"},
    ["World 2"] = {"Smart","250K Wins","400K Wins","600K Wins","1M Wins","1.5M Wins","2.5M Wins","4M Wins","6M Wins","10M Wins","15M Wins","25M Wins","40M Wins","60M Wins","100M Wins","200M Wins"},
    ["World 3"] = {"Smart","300M Wins","500M Wins","800M Wins","1.25B Wins","2B Wins","3.5B Wins","5.5B Wins","8.5B Wins","16B Wins","25B Wins","40B Wins","65B Wins","100B Wins","200B Wins"},
    ["BBNO"] = {"Smart","1 Cash","10 Cash","20 Cash","50 Cash","100 Cash","150 Cash","300 Cash","500 Cash","1000 Cash","2500 Cash","10000 Cash","25000 Cash","50000 Cash"}
}

--// เส้นทาง (ใส่เองตรงนี้)
AutoWin.Routes = {--==================================================
-- AUTO WIN CORE
--==================================================

(function()
local K = {}
local A = game:GetService("TweenService")
local I = Vector3.new(0, 3, 0)

x = x or {}
x.autoWalkRunning = false
x.autoWinRunId = 0
x.DEFAULT_WALK_SPEED = 120

local N = N or {}
local E = LocalPlayer
local z = E:WaitForChild("PlayerGui")
local T = {E.Character}
local p = {E.Character}
local q = {E.Character}
local v = {}
local e = RunService
local f = {TouchEnabled = false}

local function D_func()
local k = z:FindFirstChild('SpeedGameUI')
if not k then return nil end
local Y, d = pcall(function() return k.Frames.RightFrame.ButtonsFrame.ImageLabel.MaxCustomSpeed.Text end)
if not Y then return nil end
local k = tostring(d):gsub(',', '')
local Y, d = k:match("([%d%.]+)%s*([KkMmBb]?)")
local k = tonumber(Y)
if not k then return nil end
local Y = {K = 1e3, M = 1e6, B = 1e9}
return k * (Y[string.upper(d)] or 1)
end

local function k_func(Y)
local d = tonumber(Y)
if d and d > 0 then return d end
if N and N["Smart Speed"] then
local Y = D_func()
if Y and Y > 0 then return Y end
end
return tonumber(x.DEFAULT_WALK_SPEED) or 120
end

K.GetCurrentMaxSpeed = D_func

local D_anim = {
idle = 'rbxassetid://507766666',
walk = 'rbxassetid://507777826',
run = 'rbxassetid://507767714',
swim = "rbxassetid://507784897",
swimidle = 'rbxassetid://507785072',
jump = 'rbxassetid://507765000',
fall = 'rbxassetid://507767968',
climb = 'rbxassetid://507765644',
sit = "rbxassetid://2506281703",
wave = "rbxassetid://507770239",
point = "rbxassetid://507770453",
dance = 'rbxassetid://507771019',
dance2 = "rbxassetid://507776043",
dance3 = "rbxassetid://507777268",
laugh = 'rbxassetid://507770818',
cheer = "rbxassetid://507770677"
}

local function Y_func(d, w, X, y)
local R, F, M, c = nil, nil, nil, true
if typeof(w) == 'string' then
R = w
if typeof(X) == "boolean" then
c = X
elseif typeof(X) == 'number' and X <= 1 then
M = X
F = y
else
F = X
M = y
end
elseif typeof(w) == "table" then
R = w.Animation
F = w.Speed
M = w.FaceNextProgress
c = w.DetectSpawnWin ~= false
else
F = w
end
return {Type = 'Move', Position = d, Speed = F, Animation = R, FaceNextProgress = M, DetectSpawnWin = c}
end

local function d_Walk(d, w) return {Type = "Walk", Position = d, MagnitudeTolerance = w or 4} end
local function d_Wait(d) return {Type = 'Wait', Duration = d or 1} end
local function d_WaitPos(w, X, y) return {Type = 'WaitPosition', Position = w, Tolerance = X or 5, Timeout = y or 5} end

local function w_Jump(X, y, R, F, M, c, H)
local Q = false
local G, b, a = nil, M, c
if typeof(M) == "boolean" then
Q = M
b = c
a = H
elseif typeof(M) == "number" or tonumber(M) then
G = tonumber(M)
b = c
a = H
end
return {Type = "Jump", Axis = string.lower(tostring(X or "")), Start = y, Land = R, JumpHeight = F or 8, FollowY = Q, LandingY = G, Speed = b, FaceNextProgress = a}
end

local function X_Climb(y, R, F) return {Type = 'Climb', StartY = tonumber(y) or y, EndY = tonumber(R) or R, Facing = F} end
local function y_Delete(R, F) return {Type = 'DeleteObject', GetTarget = R, DeleteOnce = F or false, Deleted = false} end
local function R_SetFly(F) return {Type = 'SetFlying', State = F} end
local function F_WinBlock(M, c, H) return {Type = "WinBlock", GetTarget = M, Delay = c or 0.15, Timeout = H or 12, CheckInterval = 0.15} end
local function M_WaitTimer(c, H) return {Type = "WaitForTimer", GetTimer = c, Target = H or 0} end
local function c_WaitTouched(H, Q) return {Type = "WaitTouched", Object = H, Target = Q, Size = Vector3.new(10, 10, 10), TriggerZone = nil, Connection = nil, Touched = false} end

local function H_char()
local Q = E.Character or E.CharacterAdded:Wait()
local G = Q:WaitForChild("Humanoid")
local b = Q:WaitForChild("HumanoidRootPart")
return Q, G, b
end

local function Q_check(G)
if not x.autoWalkRunning or x.autoWinRunId ~= G then return false end
local char = E.Character
if not char then return false end
local hum = char:FindFirstChildOfClass("Humanoid")
return hum and hum.Health > 0
end

local function p_touch(q)
if not f.TouchEnabled then return end
if q then
if x.NoInputEnabled then return end
if x.AutoWinTouchControlsDisabled then return end
if not x.Controls then
local q, G = pcall(function()
local b = E:WaitForChild('PlayerScripts')
local a = require(b:WaitForChild('PlayerModule'))
return a:GetControls()
end)
if q then x.Controls = G end
end
if x.Controls then
x.Controls:Disable()
x.AutoWinTouchControlsDisabled = true
end
elseif x.AutoWinTouchControlsDisabled then
if x.Controls and not x.NoInputEnabled then
x.Controls:Enable()
end
x.AutoWinTouchControlsDisabled = false
end
end

local function q_world(G) return G == 'World 3' and f.TouchEnabled end

function K.ParseWinAmount(f)
local G = tostring(f):gsub("Wins", ''):gsub("Cash", ''):gsub(" ", "")
local f = {["k"] = 1000, ["K"] = 1000, ["m"] = 1000000, ["M"] = 1000000, ["b"] = 1000000000, ["B"] = 1000000000}
local b = G:sub(-1.0)
local a = G
if f[b] then
a = G:sub(1, -2.0)
local U = tonumber(a)
if U then return U * f[b] end
end
return tonumber(G) or 0
end

function K.IsWinLessThanSelected(f)
local G = x.AutoWinEffectiveTarget or N["Select Win Amount"]
if not G then return false end
local b = K.ParseWinAmount(G)
local G = K.ParseWinAmount(tostring(f))
return G < b
end

local function f_level()
local G = z:FindFirstChild('SpeedGameUI')
local z = G and G:FindFirstChild("Frames")
local G = z and z:FindFirstChild("LevelFrame")
local z = G and G:FindFirstChild('ProgressBg')
local G = z and z:FindFirstChild("LevelText")
return G and tonumber(G.Text:match("%d+")) or nil
end

local z_data = {
["World 1"] = {
DefaultTarget = '10 Wins',
Requirements = {
{Level = 5, Target = "20 Wins"},
{Level = 13, Target = '50 Wins'},
{Level = 28, Target = "150 Wins"},
{Level = 35, Target = "300 Wins"},
{Level = 40, Target = '500 Wins'},
{Level = 54, Target = "10000 Wins"},
{Level = 59, Target = "25000 Wins"},
{Level = 89, Target = '50000 Wins'},
{Level = 100, Target = '150K Wins'}
}
},
['BBNO'] = {
DefaultTarget = '300 Cash',
Requirements = {
{Level = 40, Target = "500 Cash"},
{Level = 54, Target = '10000 Cash'},
{Level = 89, Target = "25000 Cash"},
{Level = 110, Target = "50000 Cash"}
}
}
}

function K.ResolveSmartTarget(G, b)
local a = z_data[G]
if not a or typeof(b) ~= "string" then
x.SmartPlayNotificationKey = nil
return b
end
local z = f_level()
if not z then return b end
local f = a.DefaultTarget
for U, U in ipairs(a.Requirements) do
if z >= U.Level then
f = U.Target
else
break
end
end
if b == 'Smart' then
x.SmartPlayNotificationKey = nil
return f
end
local a = K.ParseWinAmount(b)
local U = K.ParseWinAmount(f)
if a <= U then
x.SmartPlayNotificationKey = nil
return b
end
local a = G .. ':' .. b .. "->" .. f
if x.SmartPlayNotificationKey ~= a then
x.SmartPlayNotificationKey = a
print(string.format("[Smart Play] Level %d is too low for %s. Switching to %s.", z, b, f))
end
return f
end

function K.EnsureWinRemoteListener()
if v["WinRemote"] then return end
v["WinRemote"] = true
end

local function S_reset()
local z = E.Character
local J = z and z:FindFirstChildOfClass('Humanoid')
local f = z and z:FindFirstChild("HumanoidRootPart")
if J and f then
J:Move(Vector3.zero, false)
J.WalkSpeed = 16
f.AssemblyLinearVelocity = Vector3.zero
f.AssemblyAngularVelocity = Vector3.zero
for _, name in ipairs({'AutoWinBodyGyro', 'AutoWinBodyVelocity', 'FlyGyro', 'FlyVelocity'}) do
local obj = f:FindFirstChild(name)
if obj then obj:Destroy() end
end
J.PlatformStand = false
J.Sit = false
pcall(function()
J:ChangeState(Enum.HumanoidStateType.GettingUp)
task.wait(0.05)
J:ChangeState(Enum.HumanoidStateType.Running)
end)
if x.Controls and x.AutoWinTouchControlsDisabled then
x.Controls:Enable()
x.AutoWinTouchControlsDisabled = false
end
end
end

local function z_fly(J)
local f = E.Character
local G = f and f:FindFirstChildOfClass('Humanoid')
local b = f and f:FindFirstChild("HumanoidRootPart")
if not b or not G then return end
if J then
if not b:FindFirstChild("AutoWinBodyVelocity") then
G.PlatformStand = true
local J = Instance.new('BodyGyro')
J.Name = 'AutoWinBodyGyro'
J.P = 9e4
J.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
J.CFrame = b.CFrame
J.Parent = b
local J = Instance.new("BodyVelocity")
J.Name = 'AutoWinBodyVelocity'
J.Velocity = Vector3.new(0, 0, 0)
J.MaxForce = Vector3.new(9e9, 9e9, 9e9)
J.Parent = b
end
else
local J = b:FindFirstChild('AutoWinBodyGyro')
if J then J:Destroy() end
local J = b:FindFirstChild('AutoWinBodyVelocity')
if J then J:Destroy() end
G.PlatformStand = false
end
end

local function J_scale(f, G)
if f and f.AutomaticScalingEnabled and f.HipHeight then
return math.max(f.HipHeight / 2, 0.01)
end
if G and G.GetScale then
local f, b = pcall(function() return G:GetScale() end)
if f and b and b > 0 then return b end
end
return 1
end

local function f_speed(G, b, a, U)
if G == 'run' then
return math.max((b or 120) * 1.25 / (16 * J_scale(a, U)), 0.0001)
elseif G == "climb" then
return math.max((b or 120) / (5 * J_scale(a, U)), 0.0001)
end
return 1
end

local function J_anim(G, b, a)
local U = G and D_anim[G]
if not U then return nil end
local D = E.Character
local B = D and D:FindFirstChildOfClass("Humanoid")
if not B then return nil end
local O = B:FindFirstChildOfClass("Animator") or Instance.new("Animator", B)
local j = Instance.new("Animation")
j.AnimationId = U
local U = O:LoadAnimation(j)
U.Priority = Enum.AnimationPriority.Movement
U.Looped = a ~= false
U:Play(0.1)
U:AdjustSpeed(f_speed(G, b, B, D))
j:Destroy()
return U
end

local function D_clamp(f)
if typeof(f) ~= "number" then return 0.85 end
return math.clamp(f, 0, 1)
end

local f_dirs = {
north = Vector3.new(0, 0, -1.0),
south = Vector3.new(0, 0, 1),
east = Vector3.new(1, 0, 0),
west = Vector3.new(-1.0, 0, 0),
northeast = Vector3.new(1, 0, -1.0),
northwest = Vector3.new(-1.0, 0, -1.0),
southeast = Vector3.new(1, 0, 1),
southwest = Vector3.new(-1.0, 0, 1)
}

local function G_vec(b)
local a = Vector3.new(b.X, 0, b.Z)
if a.Magnitude <= 0.01 then return Vector3.new(0, 0, -1.0) end
return a.Unit
end

local function b_dir(a, U)
if typeof(a) == 'Vector3' then return G_vec(a) end
local B = string.lower(tostring(a or '')):gsub("%s+", '')
local a = f_dirs[B]
if a then return a.Unit end
return G_vec(U)
end

local function f_move(a, U, B, O, j, l, W)
if not Q_check(B) then return false end
local s
local C = false
local h, h, h = H_char()
local Z = k_func(U)
local U = (h.Position - a).Magnitude
local u = math.max(U / Z, 0.05)
local U = h.Position
local o
local g = G_vec(h.CFrame.LookVector)
local G = a - U
if G.Magnitude > 0.01 then
o = a + G.Unit
else
o = a + h.CFrame.LookVector
end

local function G_func(U)
if j == "jump" then return h.Position + g end
if O and U >= D_clamp(l) then return O end
local U = h.Position
local O = a - U
if O.Magnitude > 0.01 then return a + O.Unit end
return o
end

local U_tween = A:Create(h, TweenInfo.new(u, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = a})
local A_clock = os.clock()
U_tween:Play()
s = J_anim(j, Z)
while U_tween.PlaybackState == Enum.PlaybackState.Playing do
if W ~= false then
local a = workspace:FindFirstChild('SpawnLocation')
if a and a:IsA("BasePart") then
local O = (h.Position - a.Position).Magnitude
if O <= 15 then
x.winReceived = true
U_tween:Cancel()
S_reset()
if s then
s:Stop(0.1)
s:Destroy()
end
return false
end
end
end
if not Q_check(B) or x.winReceived then
U_tween:Cancel()
S_reset()
if s then
s:Stop(0.1)
s:Destroy()
end
return false
end
local a = math.clamp((os.clock() - A_clock) / u, 0, 1)
h.CFrame = CFrame.lookAt(h.Position, G_func(a))
local A = h:FindFirstChild('AutoWinBodyGyro')
if A then A.CFrame = h.CFrame end
task.wait(0.03)
end
C = U_tween.PlaybackState == Enum.PlaybackState.Completed
if s then
s:Stop(0.1)
s:Destroy()
end
return C

end

local function A_walk(G, a, U)
if not Q_check(U) then return false end
local B, B, O = H_char()
local j = a or 4
local a = O.Position
local l = os.clock()
B.PlatformStand = false
B:MoveTo(G)
while Q_check(U) and not x.winReceived do
local W = (O.Position - G).Magnitude
if W <= j then
S_reset()
return true
end
if not Q_check(U) or x.winReceived then
S_reset()
return false
end
if (O.Position - a).Magnitude > 0.5 then
a = O.Position
l = os.clock()
elseif os.clock() - l > 2 then
B.Jump = true
B:MoveTo(G)
l = os.clock()
else
B:MoveTo(G)
end
task.wait(0.1)
end
S_reset()
return x.winReceived
end

local function G_jump(a, U, B)
local O = a.Axis
local j = tonumber(a.Start)
local l = tonumber(a.Land)
local W = tonumber(a.LandingY) or U.Y
if not a.LandingY and a.FollowY and B then W = B.Y end
if O == 'xz' and typeof(a.Start) == "table" and typeof(a.Land) == 'table' then
local s = tonumber(a.Land[1])
local C = tonumber(a.Land[2])
if s and C then return Vector3.new(s, W, C) end
end
if not j or not l then
if B and a.FollowY then return B end
return B and Vector3.new(B.X, W, B.Z)
end
if O == 'x' then return Vector3.new(l, W, U.Z)
elseif O == 'y' or O == 'z' then return Vector3.new(U.X, W, l)
end
return B and Vector3.new(B.X, W, B.Z)
end

local function a_lerp(U, B, O, j, l)
local W = O.Axis
local s = tonumber(O.Start)
local C = tonumber(O.Land)
local h = U.X + (B.X - U.X) * l
local Z = U.Z + (B.Z - U.Z) * l
if W == "xz" and typeof(O.Start) == "table" and typeof(O.Land) == 'table' then
local u = tonumber(O.Start[1])
local o = tonumber(O.Start[2])
local g = tonumber(O.Land[1])
local r = tonumber(O.Land[2])
if u and o and g and r then
h = u + (g - u) * l
Z = o + (r - o) * l
end
elseif W == 'x' and s and C then
h = s + (C - s) * l
Z = U.Z
elseif (W == "y" or W == 'z') and s and C then
h = U.X
Z = s + (C - s) * l
end
local O = U.Y + (B.Y - U.Y) * l + math.sin(math.pi * l) * j
return Vector3.new(h, O, Z)
end

local function U_jump(B, O, j)
if not Q_check(j) then return false end
local l, l, W = H_char()
local s = k_func(B.Speed)
local C = W.Position
local h = G_jump(B, C, O)
if not h then return false end
local G = Vector3.new(h.X - C.X, 0, h.Z - C.Z).Magnitude
local O = math.max(G / s, 0.05)
local G = B.JumpHeight or 8
local Z = J_anim('jump', s, false)
local s_clock = os.clock()
l.PlatformStand = false
l:ChangeState(Enum.HumanoidStateType.Jumping)
while Q_check(j) and not x.winReceived do
local l = math.clamp((os.clock() - s_clock) / O, 0, 1)
local O = a_lerp(C, h, B, G, l)
local G = Vector3.new(h.X, O.Y, h.Z)
if l < D_clamp(B.FaceNextProgress) then
local D = h - W.Position
local a = Vector3.new(D.X, 0, D.Z)
if a.Magnitude > 0.01 then G = O + a.Unit end
end
W.CFrame = CFrame.lookAt(O, G)
local D = W:FindFirstChild("AutoWinBodyGyro")
if D then D.CFrame = W.CFrame end
if l >= 1 then break end
e.Heartbeat:Wait()
end
if Z then
Z:Stop(0.1)
Z:Destroy()
end
if not Q_check(j) or x.winReceived then
S_reset()
return x.winReceived
end
local D = W.CFrame.LookVector
local G = Vector3.new(D.X, 0, D.Z)
if G.Magnitude <= 0.01 then G = Vector3.new(0, 0, -1.0) end
W.CFrame = CFrame.lookAt(h, h + G.Unit)
return true
end

local function D_climb(G, a)
if not Q_check(a) then return false end
local B, B, O = H_char()
local j = tonumber(G.StartY)
local l = tonumber(G.EndY)
if not j or not l then return false end
local W = k_func(G.Speed)
local k = Vector3.new(O.Position.X, j, O.Position.Z)
local s = Vector3.new(O.Position.X, l, O.Position.Z)
local C = math.max(math.abs(l - j) / W, 0.05)
local j = b_dir(G.Facing, O.CFrame.LookVector)
local G = J_anim("climb", W, true)
local J = os.clock()
B.PlatformStand = false
B:ChangeState(Enum.HumanoidStateType.Climbing)
while Q_check(a) and not x.winReceived do
local b = math.clamp((os.clock() - J) / C, 0, 1)
local J = k:Lerp(s, b)
O.CFrame = CFrame.lookAt(J, J + j)
local J = O:FindFirstChild('AutoWinBodyGyro')
if J then J.CFrame = O.CFrame end
if b >= 1 then break end
e.Heartbeat:Wait()
end
if G then
G:Stop(0.1)
G:Destroy()
end
if not Q_check(a) or x.winReceived then
S_reset()
return x.winReceived
end
O.CFrame = CFrame.lookAt(s, s + j)
return true
end

local function J_winblock(k, G)
local b = os.clock()
local a
while Q_check(G) and not x.winReceived and os.clock() - b < k.Timeout do
local b, B = pcall(k.GetTarget)
if b and typeof(B) == 'Instance' and B:IsA("BasePart") then
a = B
break
end
task.wait(k.CheckInterval)
end
if not a then return false end
task.wait(k.Delay)
if not Q_check(G) or x.winReceived then return x.winReceived end
local b = f_move(a.Position + I, k.Speed, G)
if b and Q_check(G) and not x.winReceived then
local k, k = H_char()
k:MoveTo(a.Position)
end
local k = os.clock()
while Q_check(G) and not x.winReceived and os.clock() - k < 10 do
local k = workspace:FindFirstChild("SpawnLocation")
local b = E.Character
local a = b and b:FindFirstChild('HumanoidRootPart')
if k and k:IsA('BasePart') and a then
local b = (a.Position - k.Position).Magnitude
if b <= 15 then
print("Player Teleported???")
x.winReceived = true
break
end
end
task.wait(0.05)
end
if Q_check(G) and not x.winReceived then
local k = E.Character
local G = k and k:FindFirstChildOfClass('Humanoid')
if G then G.Health = 0 end
end
return x.winReceived
end

local function k_timer(G, b, a)
local B, O = pcall(G)
if not B or not O then return end
repeat
task.wait(0.1)
until not Q_check(a) or math.abs((tonumber(O.Text) or math.huge) - b) <= 0.1
end

local function G_val(b)
if typeof(b) == 'function' then
local a, B = pcall(b)
if a then return B end
return nil
end
return b
end

local function b_zone(a, B)
local O = a.TriggerZone
if not O or not O.Parent then
O = Instance.new("Part")
O.Name = "AutoWinWaitTouchedZone"
O.Size = a.Size or Vector3.new(10, 10, 10)
O.Anchored = true
O.CanCollide = false
O.CanTouch = true
O.CanQuery = true
O.Transparency = 1
O.Parent = workspace
a.TriggerZone = O
end
if typeof(B) == "Instance" and B:IsA('BasePart') then
O.CFrame = B.CFrame
elseif typeof(B) == 'Vector3' then
O.Position = B
elseif typeof(B) == "CFrame" then
O.CFrame = B
end
return O
end

local function a_touched(B, O)
B.Touched = false
local j = G_val(B.Object)
local l = G_val(B.Target)
if not j or not l then return false end
local W = b_zone(B, l)
if B.Connection then B.Connection:Disconnect() end
B.Connection = W.Touched:Connect(function(s)
local C = G_val(B.Object)
if s == C then B.Touched = true end
end)
while Q_check(O) and not x.winReceived and not B.Touched do
j = G_val(B.Object)
l = G_val(B.Target)
if not j or not l then break end
b_zone(B, l)
if typeof(j) == "Instance" and j:IsA("BasePart") then
for G, G in ipairs(workspace:GetPartBoundsInBox(W.CFrame, W.Size)) do
if G == j then
B.Touched = true
break
end
end
end
task.wait(0.05)
end
if B.Connection then
B.Connection:Disconnect()
B.Connection = nil
end
return B.Touched or x.winReceived
end

local function G_next(b, B)
if not b then return nil end
for O = B + 1, #b do
local B = b[O]
if B and B.Type == 'Move' then
return B.Position
elseif B and B.Type == "WinBlock" then
local b, O = pcall(B.GetTarget)
if b and typeof(O) == 'Instance' and O:IsA('BasePart') then
return O.Position + I
end
end
end
return nil
end

local function I_step(b, B, O, j)
if not b or not Q_check(B) or x.winReceived then return false end
if b.Type == "Move" then
local l = G_next(O, j)
return f_move(b.Position, b.Speed, B, l, b.Animation, b.FaceNextProgress, b.DetectSpawnWin)
elseif b.Type == 'Jump' then
local f = G_next(O, j)
return U_jump(b, f, B)
elseif b.Type == 'Climb' then
return D_climb(b, B)
elseif b.Type == "Walk" then
return A_walk(b.Position, b.MagnitudeTolerance, B)
elseif b.Type == 'SetFlying' then
z_fly(b.State)
return Q_check(B)
elseif b.Type == "WinBlock" then
return J_winblock(b, B)
elseif b.Type == "WaitForTimer" then
k_timer(b.GetTimer, b.Target, B)
return Q_check(B)
elseif b.Type == "WaitTouched" then
return a_touched(b, B)
elseif b.Type == "DeleteObject" then
if b.DeleteOnce and b.Deleted then return Q_check(B) end
if b.DeleteOnce then b.Deleted = true end
task.spawn(function()
local A, z = pcall(b.GetTarget)
if A and z and z:IsA('Instance') then z:Destroy() end
end)
return Q_check(B)
elseif b.Type == "Wait" then
local A = os.clock()
while Q_check(B) and not x.winReceived and os.clock() - A < (b.Duration or 0) do
task.wait(0.05)
end
return Q_check(B)
elseif b.Type == 'WaitPosition' then
local A = game.Players.LocalPlayer.Character
if not A then return false end
local z = A:FindFirstChild('HumanoidRootPart')
if not z then return false end
local D = b.Position
local J = b.Tolerance or 5
local f = tonumber(b.Timeout) or 5
local k = os.clock()
while Q_check(B) and not x.winReceived and os.clock() - k < f do
local f = z.Position
local z = (f - D).Magnitude
if z <= J then return true end
task.wait(0.1)
end
if Q_check(B) and not x.winReceived then
local z = A:FindFirstChildOfClass('Humanoid')
if z then z.Health = 0 end
return false
end
return x.winReceived
end
return true
end

local function A_append(z, D)
local J = {}
local f = #z - 2
if z and f > 0 then
for k = 1, f do
J[k] = z[k]
end
end
for z, z in ipairs(D) do
table.insert(J, z)
end
return J
end

-- Routes World 1
local z_routes = {}
z_routes["1 Win"] = {
Y_func(Vector3.new(2.81, 7.68, 129.98), 'run', false),
Y_func(Vector3.new(-0.48, 7.68, 284.92), 'run', 0.95),
Y_func(Vector3.new(-13.25, 11.31, 285.25), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage2.WinBlock1 end, .2)
}
z_routes["3 Wins"] = A_append(z_routes['1 Win'], {
Y_func(Vector3.new(50.45, 7.68, 399.32), "run"),
Y_func(Vector3.new(.22, 7.68, 504.8), "run"),
Y_func(Vector3.new(-16.12, 10.65, 507.26), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage3.WinBlock2 end, .2)
})
z_routes["10 Wins"] = A_append(z_routes['3 Wins'], {
Y_func(Vector3.new(-12.28, 7.68, 526.86), 'run'),
Y_func(Vector3.new(-15.79, 7.68, 559.83), 'run'),
Y_func(Vector3.new(-16.23, 49.29, 677.16), "run"),
Y_func(Vector3.new(-15.94, 75.96, 757.34), 'run'),
Y_func(Vector3.new(-15.92, 77.92, 774.04), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage4.WinBlock3 end, .2)
})
z_routes['20 Wins'] = A_append(z_routes['10 Wins'], {
Y_func(Vector3.new(1.09, 77.14, 789.13), "run"),
Y_func(Vector3.new(2.33, 77.14, 817.71), "run"),
w_Jump('z', 817.71, 853.24, 5),
Y_func(Vector3.new(3.68, 77.14, 900.07), 'run'),
w_Jump('z', 900.07, 921.40, 5),
Y_func(Vector3.new(3.89, 77.14, 945.26), 'run'),
w_Jump('z', 945.26, 998.72, 5),
Y_func(Vector3.new(3.80, 77.14, 1013.27), "run"),
w_Jump("z", 1013.27, 1036.98, 5),
Y_func(Vector3.new(-3.04, 77.14, 1103.80), "run"),
Y_func(Vector3.new(-14.89, 78.94, 1108.95), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage5.WinBlock4 end, .2)
})
z_routes["50 Wins"] = A_append(z_routes['20 Wins'], {
Y_func(Vector3.new(-0.39, 77.14, 1125.59), 'run'),
Y_func(Vector3.new(-0.17, 77.14, 1151.55), 'run'),
Y_func(Vector3.new(1.67, 77.14, 1358.60), "run"),
Y_func(Vector3.new(2.12, 77.14, 1410.29), "run"),
Y_func(Vector3.new(-20.89, 78.4, 1412.88), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage6.WinBlock5 end, .2)
})
z_routes['100 Wins'] = A_append(z_routes['50 Wins'], {
Y_func(Vector3.new(1.71, 75.96, 1420.83), {Animation = 'run', Speed = 150}),
M_WaitTimer(function(...) return workspace["NPC & Piege"].Tsunami1.TimerPart.StageGui.Timer end, .1),
Y_func(Vector3.new(-126.49, 53.31, 1444.94), {Animation = 'run', Speed = 150}),
Y_func(Vector3.new(-433.16, 53.31, 1463.62), {Animation = 'run', Speed = 150}),
Y_func(Vector3.new(-546.43, 53.32, 1463.7), {Animation = 'run', Speed = 150}),
Y_func(Vector3.new(-539.85, 55.15, 1448.3), {Animation = 'run', Speed = 150}),
F_WinBlock(function(...) return workspace.Structure.Stage7.WinBlock6 end, .2)
})
z_routes["150 Wins"] = A_append(z_routes['100 Wins'], {
Y_func(Vector3.new(-712.52, 53.32, 1465.25), 'run'),
Y_func(Vector3.new(-1007.36, 53.32, 1466.5), 'run'),
Y_func(Vector3.new(-1008.4, 55.29, 1451.05), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage8.WinBlock7 end, .2)
})
z_routes["300 Wins"] = A_append(z_routes['150 Wins'], {
Y_func(Vector3.new(-1028.58, 54.50, 1467.10), "run"),
Y_func(Vector3.new(-1087.28, 58.04, 1467.11), "run"),
X_Climb(58.04, 295.23, 'west'),
Y_func(Vector3.new(-1093.82, 296.50, 1466.77), 'run'),
Y_func(Vector3.new(-1121.53, 296.50, 1464.99), "run"),
Y_func(Vector3.new(-1123.63, 298.61, 1452.2), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage9.WinBlock8 end, .2)
})
z_routes['500 Wins'] = A_append(z_routes["300 Wins"], {
Y_func(Vector3.new(-1133.99, 296.50, 1466.29), 'run'),
Y_func(Vector3.new(-1185.22, 296.61, 1466.74), 'run'),
Y_func(Vector3.new(-1244.5, 303.80, 1467.25), "run"),
w_Jump('x', -1244.5, -1357.63, 8, 282.47),
Y_func(Vector3.new(-1368.79, 282.47, 1468.33), "run"),
Y_func(Vector3.new(-1379.12, 291.39, 1468.48), 'run'),
Y_func(Vector3.new(-1390.21, 302.46, 1468.64), "run"),
Y_func(Vector3.new(-1401.94, 314.20, 1468.82), 'run'),
Y_func(Vector3.new(-1414.42, 326.69, 1469.01), 'run'),
Y_func(Vector3.new(-1422.28, 334.55, 1469.10), 'run'),
Y_func(Vector3.new(-1436.97, 336.87, 1469.23), "run"),
Y_func(Vector3.new(-1467.19, 336.87, 1469.49), "run"),
Y_func(Vector3.new(-1506.06, 336.87, 1469.83), 'run'),
w_Jump('x', -1506.06, -1565.56, 8, 321.27),
Y_func(Vector3.new(-1624.22, 321.27, 1470.85), "run"),
w_Jump('x', -1624.22, -1746.12, 8, 290.87),
Y_func(Vector3.new(-1778.99, 291.09, 1472.18), "run"),
Y_func(Vector3.new(-1818.14, 301.58, 1472.52), 'run'),
Y_func(Vector3.new(-1861.72, 317.34, 1472.83), 'run'),
w_Jump("x", -1861.72, -1934.48, 8, 307.45),
Y_func(Vector3.new(-2045.2, 307.45, 1474.42), "run"),
w_Jump("x", -2045.2, -2127.3, 8, 307.67),
Y_func(Vector3.new(-2155.3, 317.38, 1475.39), "run"),
Y_func(Vector3.new(-2175.94, 324.53, 1475.57), "run"),
w_Jump("x", -2175.94, -2251.62, 8, 314.07),
Y_func(Vector3.new(-2279.1, 314.07, 1476.47), "run"),
Y_func(Vector3.new(-2307.45, 314.07, 1476.71), "run"),
Y_func(Vector3.new(-2342.51, 325.01, 1477.02), 'run'),
w_Jump("x", -2342.51, -2417.97, 8, 322.77),
Y_func(Vector3.new(-2429.93, 322.77, 1474.25), "run"),
Y_func(Vector3.new(-2494.78, 322.76, 1472.55), "run"),
Y_func(Vector3.new(-2523.56, 322.77, 1486.14), 'run'),
w_Jump('x', -2523.56, -2627.28, 8, 294.27),
Y_func(Vector3.new(-2650.38, 294.27, 1499.56), 'run'),
Y_func(Vector3.new(-2703.93, 294.27, 1484.21), 'run'),
Y_func(Vector3.new(-2786.51, 308.04, 1472.55), "run"),
w_Jump("x", -2786.51, -2871.51, 8, 283.33),
Y_func(Vector3.new(-2880.38, 283.33, 1474.26), "run"),
Y_func(Vector3.new(-2972.13, 296.50, 1468.36), "run"),
Y_func(Vector3.new(-2973.39, 299.56, 1449.55), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage10.WinBlock9 end, .2)
})
z_routes['1000 Wins'] = A_append(z_routes["500 Wins"], {
Y_func(Vector3.new(-3251.58, 295.32, 1468.47), "run"),
Y_func(Vector3.new(-3732.62, 295.32, 1464.91), "run"),
Y_func(Vector3.new(-3943.55, 295.32, 1466.12), 'run'),
Y_func(Vector3.new(-3939.01, 299.56, 1447.85), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage11.WinBlock10 end, .2)
})
z_routes['2500 Wins'] = A_append(z_routes['1000 Wins'], {
Y_func(Vector3.new(-3944.82, 296.50, 1465.57), 'run'),
Y_func(Vector3.new(-3992.31, 296.50, 1463.09), "run"),
w_Jump("x", -3992.31, -4101.22, 8, 296.50),
Y_func(Vector3.new(-4186.61, 296.50, 1464.14), 'run'),
w_Jump('x', -4186.61, -4292.88, 8, 296.50),
Y_func(Vector3.new(-4302.06, 296.48, 1467.15), "run"),
X_Climb(296.48, 342.63),
Y_func(Vector3.new(-4308.52, 371.21, 1467.09), "jump"),
Y_func(Vector3.new(-4294.34, 448.33, 1502.85), "jump"),
Y_func(Vector3.new(-4298.7, 504.16, 1525.44), "jump"),
Y_func(Vector3.new(-4298.7, 497.07, 1525.44), "jump"),
Y_func(Vector3.new(-4309.03, 472.36, 1527.47), "run"),
Y_func(Vector3.new(-4366.92, 471.01, 1526.97), "run"),
Y_func(Vector3.new(-4368.75, 474.62, 1513.47), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage12.WinBlock11 end, .1)
})
z_routes["10000 Wins"] = A_append(z_routes['2500 Wins'], {
Y_func(Vector3.new(-4584.82, 469.65, 1529.69), 'run'),
Y_func(Vector3.new(-4628.37, 469.65, 1141.16), 'run'),
Y_func(Vector3.new(-5046.67, 469.65, 1588.44), 'run'),
Y_func(Vector3.new(-5266.65, 469.65, 1477.57), 'run'),
Y_func(Vector3.new(-5341.57, 469.43, 1477.3), "run"),
Y_func(Vector3.new(-5341.17, 472.4, 1459.22), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage13.WinBlock12 end, .1)
})
z_routes["25000 Wins"] = A_append(z_routes["10000 Wins"], {
Y_func(Vector3.new(-5398.84, 476.83, 1480.4), 'run'),
Y_func(Vector3.new(-5902.1, 486.11, 1565.53), "run"),
Y_func(Vector3.new(-6479.85, 488.56, 1388.15), 'run'),
Y_func(Vector3.new(-6808.44, 520.43, 1487.06), 'run'),
Y_func(Vector3.new(-6808.57, 523.6, 1470.37), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage14.WinBlock13 end, .1)
})
z_routes["50000 Wins"] = A_append(z_routes['25000 Wins'], {
Y_func(Vector3.new(-6858.1, 551.99, 1489.02), 'run'),
Y_func(Vector3.new(-8308.83, 551.99, 1489.02), "run"),
Y_func(Vector3.new(-8345.8, 484.49, 1489.52), 'run'),
Y_func(Vector3.new(-8353.04, 490.49, 1468.88), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage15.WinBlock14 end, .1)
})
z_routes["150K Wins"] = A_append(z_routes["50000 Wins"], {
Y_func(Vector3.new(-8453.98, 484.49, 1490.244), 'run'),
Y_func(Vector3.new(-8802.23, 500.14, 1486.852), 'run'),
Y_func(Vector3.new(-9143.41, 503.41, 1393.124), 'run'),
Y_func(Vector3.new(-9375.97, 505.18, 1388.144), "run"),
Y_func(Vector3.new(-9507.49, 506.27, 1484.711), "run"),
Y_func(Vector3.new(-9899.78, 500.40, 1484.911), "run"),
Y_func(Vector3.new(-10160.3, 504.36, 1484.862), "run"),
Y_func(Vector3.new(-10253.13, 504.21, 1485.302), 'run'),
Y_func(Vector3.new(-10256.06, 527.41, 1593.329), "run"),
Y_func(Vector3.new(-10352.32, 436.98, 1716.224), "run"),
Y_func(Vector3.new(-10360.53, 442.96, 1792.248), "run"),
Y_func(Vector3.new(-10360.24, 545.07, 2339.724), 'run'),
Y_func(Vector3.new(-10359.65, 745.49, 3417.401), "run"),
Y_func(Vector3.new(-10474.12, 751.02, 3580.787), 'run'),
Y_func(Vector3.new(-10684.21, 751.61, 3579.589), "run"),
Y_func(Vector3.new(-10745.23, 808.04, 3586.674), "run"),
Y_func(Vector3.new(-12045.39, 804.50, 3574.341), "run"),
Y_func(Vector3.new(-12118.14, 751.43, 3576.324), 'run'),
Y_func(Vector3.new(-13209.91, 750.54, 3586.828), "run"),
Y_func(Vector3.new(-13406.26, 750.54, 3679.525), 'run'),
Y_func(Vector3.new(-13424.09, 750.54, 3382.024), "run"),
Y_func(Vector3.new(-13625.38, 750.54, 3349.125), 'run'),
Y_func(Vector3.new(-13632.23, 750.54, 3198.804), "run"),
Y_func(Vector3.new(-13869.61, 750.54, 3224.189), 'run'),
Y_func(Vector3.new(-13718.49, 750.54, 3448.185), 'run'),
Y_func(Vector3.new(-13709.48, 750.54, 3779.334), "run"),
Y_func(Vector3.new(-13637.45, 750.54, 3975.037), 'run'),
Y_func(Vector3.new(-13989.7, 750.54, 3964.212), 'run'),
Y_func(Vector3.new(-13994.57, 750.54, 3172.296), 'run'),
Y_func(Vector3.new(-14002.12, 750.54, 3097.345), 'run'),
Y_func(Vector3.new(-14001.91, 754.54, 3067.99), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage15.WinBlock14 end, .1)
})

-- Routes World 2
local D_routes = {}
D_routes["250K Wins"] = {
Y_func(Vector3.new(-393.47, 505.00, -44.82), 'run', false),
Y_func(Vector3.new(-393.71, 504.09, 2.43), 'run'),
w_Jump("z", 2.43, 48.95, 7.65),
Y_func(Vector3.new(-400.65, 504.09, 74.35), "run"),
w_Jump("z", 74.35, 121.47, 7.65),
Y_func(Vector3.new(-402.55, 504.09, 136.23), "run"),
w_Jump('z', 136.23, 175.91, 7.65),
Y_func(Vector3.new(-415.55, 500.99, 189.32), "run", 0.95),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock16 end, .1)
}
D_routes["400K Wins"] = A_append(D_routes['250K Wins'], {
Y_func(Vector3.new(-399.46, 498.99, 198.01), 'run'),
Y_func(Vector3.new(-399.82, 498.99, 267.71), "run"),
Y_func(Vector3.new(-400.21, 498.99, 341.16), 'run'),
Y_func(Vector3.new(-400.58, 498.99, 412.84), "run"),
Y_func(Vector3.new(-416.32, 500.83, 433.69), 'run'),
F_WinBlock(function(...) return workspace["WORLD 2"].Winblocks.WinBlock17 end, .1)
})
D_routes["600K Wins"] = A_append(D_routes["400K Wins"], {
Y_func(Vector3.new(-398.2, 500.03, 463.03), "run"),
Y_func(Vector3.new(-347.46, 500.03, 469.68), 'run'),
Y_func(Vector3.new(-349.14, 527.10, 573.13), 'run'),
Y_func(Vector3.new(-447.89, 527.10, 576.56), 'run'),
Y_func(Vector3.new(-452.08, 554.10, 472.30), "run"),
Y_func(Vector3.new(-352.86, 554.10, 465.77), 'run'),
Y_func(Vector3.new(-349.44, 581.17, 571.67), "run"),
Y_func(Vector3.new(-454.37, 581.17, 573.74), "run"),
Y_func(Vector3.new(-448.42, 608.17, 475.03), "run"),
Y_func(Vector3.new(-398.27, 608.17, 473.62), 'run'),
Y_func(Vector3.new(-398.65, 607.96, 597.59), 'run'),
Y_func(Vector3.new(-417.61, 608.64, 607.74), "run"),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock18 end, .1)
})
D_routes['1M Wins'] = A_append(D_routes['600K Wins'], {
Y_func(Vector3.new(-398.68, 606.78, 608.25), 'run'),
w_Jump('z', 608.25, 839.73, 15.5),
Y_func(Vector3.new(-418.31, 608.6, 841.45), 'run'),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock19 end, .1)
})
D_routes["1.5M Wins"] = A_append(D_routes["1M Wins"], {
Y_func(Vector3.new(-400.1, 606.34, 844.76), 'run'),
Y_func(Vector3.new(-400.4, 606.34, 1069.42), 'run'),
Y_func(Vector3.new(-398.86, 606.34, 1260.08), "run"),
Y_func(Vector3.new(-415.33, 608.22, 1261.47), 'run'),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock20 end, .1)
})
D_routes["2.5M Wins"] = A_append(D_routes['1.5M Wins'], {
Y_func(Vector3.new(-398.84, 607.52, 1287.80), "run"),
Y_func(Vector3.new(-399.64, 619.24, 1332.89), "run"),
w_Jump("z", 1332.89, 1432.40, 5),
Y_func(Vector3.new(-393.64, 607.52, 1455.49), 'jump'),
Y_func(Vector3.new(-391.58, 607.52, 1463.43), 'run'),
Y_func(Vector3.new(-386.61, 607.54, 1477.10), "run"),
Y_func(Vector3.new(-364.94, 627.82, 1540.56), "run"),
Y_func(Vector3.new(-364.42, 628.31, 1600.44), "run"),
w_Jump("z", 1600.44, 1694.74, 5),
Y_func(Vector3.new(-362.27, 605.40, 1723.56), "jump"),
Y_func(Vector3.new(-362.05, 605.40, 1752.47), "run"),
Y_func(Vector3.new(-368.45, 616.15, 1789.31), "run"),
w_Jump('z', 1789.31, 1860.39, 5),
Y_func(Vector3.new(-398.33, 607.52, 1884.31), 'jump'),
Y_func(Vector3.new(-401.3, 607.52, 1917.52), "run"),
Y_func(Vector3.new(-401.18, 618.63, 1956.97), 'run'),
w_Jump('z', 1956.97, 2068.00, 5),
Y_func(Vector3.new(-398.73, 607.52, 2098.80), "run"),
Y_func(Vector3.new(-399.39, 618.21, 2136.59), 'run'),
w_Jump('z', 2136.59, 2249.81, 5),
Y_func(Vector3.new(-401.83, 607.52, 2276.35), 'run'),
Y_func(Vector3.new(-402.5, 624.35, 2314.60), "run"),
w_Jump("z", 2314.60, 2380.09, 5),
Y_func(Vector3.new(-404.03, 624, 2402.70), "run"),
Y_func(Vector3.new(-417.27, 624, 2415.65), "run"),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock21 end, .1)
})
D_routes['4M Wins'] = A_append(D_routes['2.5M Wins'], {
Y_func(Vector3.new(-400.82, 623.41, 2632.3), 'run'),
Y_func(Vector3.new(-417.27, 621.4, 2650.78), 'run'),
F_WinBlock(function(...) return workspace["WORLD 2"].Winblocks.WinBlock22 end, .1)
})
D_routes["6M Wins"] = A_append(D_routes['4M Wins'], {
Y_func(Vector3.new(-400.52, 623.43, 3153.41), 'run'),
Y_func(Vector3.new(-417.27, 621.22, 3158.65), 'run'),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock23 end, .1)
})
D_routes['10M Wins'] = A_append(D_routes['6M Wins'], {
Y_func(Vector3.new(-389.13, 623.43, 3336.43), 'run'),
Y_func(Vector3.new(-196.84, 623.43, 3348.66), 'run'),
Y_func(Vector3.new(-165.79, 623.43, 3259.28), "run"),
Y_func(Vector3.new(-111.84, 623.43, 3267.77), 'run'),
Y_func(Vector3.new(-114.05, 623.43, 3423.23), "run"),
Y_func(Vector3.new(-272.18, 623.43, 3438.41), 'run'),
Y_func(Vector3.new(-252.02, 623.43, 3627.99), "run"),
Y_func(Vector3.new(-549.29, 623.43, 3618.9), 'run'),
Y_func(Vector3.new(-566.19, 623.43, 3800.48), 'run'),
Y_func(Vector3.new(-125.02, 623.43, 3798.86), "run"),
Y_func(Vector3.new(-117.85, 623.43, 3869.58), "run"),
Y_func(Vector3.new(-61.37, 623.5, 3868.81), "run"),
Y_func(Vector3.new(-59.9, 624.76, 3881.49), "run"),
F_WinBlock(function(...) return workspace['WORLD 2'].Winblocks.WinBlock24 end, .1)
})
D_routes["15M Wins"] = A_append(D_routes["10M Wins"], {
R_SetFly(true),
Y_func(Vector3.new(-32.21, 624.22, 3864.24), "run"),
Y_func(Vector3.new(1177.52, 625.06, 3866.53), 'run'),
Y_func(Vector3.new(1211.29, 624.74, 3866.80), "run"),
R_SetFly(false),
Y_func(Vector3.new(1228.42, 621.59, 3908.94), 'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock25 end, .1)
})
D_routes['25M Wins'] = A_append(D_routes["15M Wins"], {
Y_func(Vector3.new(1321.79, 619.60, 3864.47), 'run'),
Y_func(Vector3.new(1541.89, 628.48, 3799.19), 'jump'),
Y_func(Vector3.new(1741.58, 638.05, 3943.17), "jump"),
Y_func(Vector3.new(1950.87, 635.78, 3800.74), 'jump'),
Y_func(Vector3.new(2081.97, 642.01, 3958.54), 'jump'),
Y_func(Vector3.new(2294.80, 629.97, 3870.72), "jump"),
Y_func(Vector3.new(2390.38,629.42,3871.08),"jump"),
Y_func(Vector3.new(2400.21,625.54,3887.94),'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock27 end, .1)
})

--// 40M Wins
D_routes["40M Wins"] = A_append(D_routes["25M Wins"], {
Y_func(Vector3.new(2435.81,627.63,3871.18),"run"),
Y_func(Vector3.new(2490.45,639.51,3871.59),'run'),
Y_func(Vector3.new(2546.37,639.63,3869.79),"run"),
w_Jump("x",2546.37,2674.71,8),
Y_func(Vector3.new(2703.03,634.63,3865.92),'run'),
Y_func(Vector3.new(2742.21,628.97,3869.99),'jump'),
Y_func(Vector3.new(2742.21,575.63,3869.99),'jump'),
Y_func(Vector3.new(2768.79,575.63,3870.23),'run'),
Y_func(Vector3.new(2825.36,575.63,3870.73),'run'),
Y_func(Vector3.new(2864.97,582.33,3871.07),"run"),
Y_func(Vector3.new(2884.59,592.78,3871.28),'run'),
Y_func(Vector3.new(2916.35,604.52,3871.55),'run'),
Y_func(Vector3.new(2972.13,576.61,3870.13),'jump'),
Y_func(Vector3.new(2999.43,576.61,3871.04),'run'),
Y_func(Vector3.new(3047.81,591.50,3871.40),"run"),
w_Jump('x',3047.81,3189.62,8),
Y_func(Vector3.new(3217.29,592.61,3872.60),"run"),
Y_func(Vector3.new(3263.77,592.63,3871.93),"run"),
Y_func(Vector3.new(3269.21,590.63,3887.94),'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock28 end, .1)
})

--// 60M Wins
D_routes['60M Wins'] = A_append(D_routes["40M Wins"], {
R_SetFly(true),
Y_func(Vector3.new(3324.58,668.46,3872.93),"run"),
Y_func(Vector3.new(3344.39,666.98,3947.49),"run"),
Y_func(Vector3.new(3340.76,670.38,4159.59),'run'),
Y_func(Vector3.new(3340.76,670.38,4259.59),"run"),
Y_func(Vector3.new(3340.76,670.38,4359.59),"run"),
Y_func(Vector3.new(3340.76,670.38,4459.59),"run"),
Y_func(Vector3.new(3340.76,670.38,4559.59),'run'),
Y_func(Vector3.new(3340.76,670.38,4659.59),'run'),
Y_func(Vector3.new(3340.76,670.38,4759.59),'run'),
Y_func(Vector3.new(3340.76,670.38,4859.59),"run"),
Y_func(Vector3.new(3340.76,670.38,4959.59),'run'),
Y_func(Vector3.new(3440.61,666.36,5144.65),'run'),
Y_func(Vector3.new(3540.61,666.36,5144.65),'run'),
Y_func(Vector3.new(3640.61,666.36,5144.65),"run"),
Y_func(Vector3.new(3740.61,666.36,5144.65),"run"),
Y_func(Vector3.new(3840.61,666.36,5144.65),'run'),
Y_func(Vector3.new(3940.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4040.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4140.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4240.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4340.61,666.36,5144.65),'run'),
Y_func(Vector3.new(4440.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4540.61,666.36,5144.65),"run"),
Y_func(Vector3.new(4613.28,664.56,5141.97),"run"),
R_SetFly(false),
Y_func(Vector3.new(4634.11,565.7,5159.4),'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock29 end, .1)
})

--// 100M Wins
D_routes['100M Wins'] = A_append(D_routes['60M Wins'], {
Y_func(Vector3.new(4650.84,566.84,5143.59),"run"),
Y_func(Vector3.new(4717.82,565.83,5142.59),"run"),
Y_func(Vector3.new(4808.75,592.92,5144.15),"run"),
Y_func(Vector3.new(4879.62,566.20,5142.28),'run'),
Y_func(Vector3.new(4913.15,568.72,5023.33),'run'),
Y_func(Vector3.new(4912.98,676.88,5023.31),'run'),
Y_func(Vector3.new(4805.10,675.12,5036.15),"run"),
Y_func(Vector3.new(4681.35,674.53,5038.30),"run"),
Y_func(Vector3.new(4675.33,673.67,5136.85),'run'),
Y_func(Vector3.new(4673.61,674.25,5246.92),'run'),
Y_func(Vector3.new(4892.01,672.98,5241.74),'run'),
Y_func(Vector3.new(4994.24,672.98,5244.03),'run'),
Y_func(Vector3.new(4992.15,686.16,5142.58),"run"),
Y_func(Vector3.new(4989.77,556.73,5145.89),"run"),
Y_func(Vector3.new(5033.11,555.68,5159.02),'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock30 end, .1)
})

--// 200M Wins
D_routes["200M Wins"] = A_append(D_routes['100M Wins'], {
y_Delete(function() return workspace:WaitForChild('NPC15_World2') end),
y_Delete(function() return workspace:FindFirstChild('WORLD 2'):WaitForChild("Stage15"):WaitForChild("Levels"):WaitForChild("MovingWalls") end),
y_Delete(function() return workspace:FindFirstChild('Pieges & Lava'):WaitForChild('Lava_Stage15',9e9) end),
Y_func(Vector3.new(5068.92,557.74,5144.38),"run"),
Y_func(Vector3.new(5128.76,557.74,5142.96),"run"),
Y_func(Vector3.new(5211.79,580.24,5143.06),"run"),
Y_func(Vector3.new(5296.07,556.97,5141.94),"run"),
Y_func(Vector3.new(5359.12,557.79,5143.17),"run"),
Y_func(Vector3.new(5452.83,586.31,5139.50),"run"),
Y_func(Vector3.new(5511.70,558.91,5142.62),'run'),
Y_func(Vector3.new(5590.65,558.00,5143.76),'run'),
Y_func(Vector3.new(5671.54,581.22,5143.29),'run'),
Y_func(Vector3.new(5739.79,557.29,5143.85),'run'),
Y_func(Vector3.new(6171.37,558.64,5141.97),"run"),
Y_func(Vector3.new(6183.89,557.77,5145.04),"run"),
Y_func(Vector3.new(6227.48,557.59,5082.80),"run"),
Y_func(Vector3.new(6363.85,591.62,5082.37),'run'),
Y_func(Vector3.new(6363.49,591.62,5203.34),"run"),
Y_func(Vector3.new(6227.78,625.56,5209.23),"run"),
Y_func(Vector3.new(6229.19,625.56,5086.88),"run"),
Y_func(Vector3.new(6359.62,659.58,5082.64),"run"),
Y_func(Vector3.new(6364.83,659.58,5203.34),"run"),
Y_func(Vector3.new(6224.91,693.52,5205.57),"run"),
Y_func(Vector3.new(6224.08,693.52,5145.71),'run'),
Y_func(Vector3.new(6394.67,693.52,5141.80),'run'),
Y_func(Vector3.new(6449.74,693.52,5147.57),"run"),
Y_func(Vector3.new(6533.68,713.56,5182.09),'run'),
Y_func(Vector3.new(6633.47,733.99,5186.79),"run"),
Y_func(Vector3.new(6667.66,680.66,5186.06),"run"),
Y_func(Vector3.new(6770.89,694.43,5187.80),'run'),
Y_func(Vector3.new(6955.48,680.66,5189.23),"run"),
Y_func(Vector3.new(7048.27,702.73,5187.25),"run"),
Y_func(Vector3.new(7135.76,722.04,5185.98),'run'),
Y_func(Vector3.new(7237.60,694.30,5181.04),"run"),
Y_func(Vector3.new(7292.34,709.59,5180.98),"run"),
Y_func(Vector3.new(7381.10,730.08,5184.13),'run'),
Y_func(Vector3.new(7499.82,692.23,5181.45),"run"),
Y_func(Vector3.new(7538.27,716.47,5180.83),"run"),
Y_func(Vector3.new(7585.95,716.30,5182.49),"run"),
Y_func(Vector3.new(7586.40,716.07,5150.84),'run'),
Y_func(Vector3.new(7585.95,666.35,5150.84),'run'),
Y_func(Vector3.new(7719.94,666.35,5148.50),"run"),
Y_func(Vector3.new(7774.98,682.35,5145.33),"run"),
Y_func(Vector3.new(7827.94,712.17,5145.54),"run"),
Y_func(Vector3.new(7912.64,712.30,5144.52),'run'),
Y_func(Vector3.new(7987.47,710.31,5143.42),'run'),
F_WinBlock(function(...) return workspace.Winblocks.WinBlock31 end, .1)
})

--==================================================
-- ROUTES WORLD 3
--==================================================

local J_routes = {}

--// 300M Wins
J_routes["300M Wins"] = {
Y_func(Vector3.new(-1436.38,-159.43,-934.65), 'run', false),
Y_func(Vector3.new(-1434.34,-159.43,-887.05), "run"),
w_Jump("z", -887.05, -837.57, 5, -158.57),
w_Jump("z", -837.57, -732.15, 15, -125.42),
w_Jump("z", -732.15, -630.24, 15, -93.37),
w_Jump('z', -630.24, -534.11, 15, -69.54),
Y_func(Vector3.new(-1441.31,-69.54,-526.62), "run"),
Y_func(Vector3.new(-1481.83,-71.65,-515.77), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock32 end, .1)
}

--// 500M Wins
J_routes["500M Wins"] = A_append(J_routes["300M Wins"], {
Y_func(Vector3.new(-1454.82,-70.04,-462.58), 'run'),
Y_func(Vector3.new(-1454.82,-59.06,-396.55), 'run'),
w_Jump("z", -392.9, -340.07, 7, -57.04),
Y_func(Vector3.new(-1434.52,-57.04,-305.09), "run"),
w_Jump("x", -1434.74, -1377.35, 7),
Y_func(Vector3.new(-1341.17,-57.04,-292.06), "run"),
w_Jump('x', -1341.17, -1291.83, 7),
Y_func(Vector3.new(-1271.14,-57.04,-266.85), 'run'),
w_Jump("z", -266.85, -212.67, 7),
Y_func(Vector3.new(-1272.2,-57.04,-172.78), "run"),
w_Jump('z', -172.78, -115.44, 7),
Y_func(Vector3.new(-1291.02,-57.04,-113.47), 'run'),
w_Jump("x", -1291.02, -1342.12, 7),
Y_func(Vector3.new(-1382.5,-57.04,-109.47), 'run'),
w_Jump("x", -1382.5, -1433.22, 7),
Y_func(Vector3.new(-1460.27,-57.04,-47.56), "run"),
Y_func(Vector3.new(-1480.76,-59.41,-15.81), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock33 end, .1)
})

--// 800M Wins
J_routes["800M Wins"] = A_append(J_routes["500M Wins"], {
Y_func(Vector3.new(-1454.71,-57.05,21.75), "run"),
Y_func(Vector3.new(-1453.34,-53.92,83.79), 'run'),
X_Climb(-53.92, 87.65, "south"),
Y_func(Vector3.new(-1453.08,89.95,94.88), 'run'),
Y_func(Vector3.new(-1433.74,89.94,95.68), "run"),
X_Climb(89.94, 213.81, "south"),
Y_func(Vector3.new(-1434.6,214.96,102.57), 'run'),
Y_func(Vector3.new(-1446.15,222.69,176.72), "run"),
w_Jump("z", 176.72, 232.09, 10),
Y_func(Vector3.new(-1443.58,215.96,257.46), "run"),
Y_func(Vector3.new(-1457.24,214.71,322.68), "run"),
Y_func(Vector3.new(-1480.77, 212.60, 332.14), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock34 end, .1)
})

--// 1.25B Wins
J_routes["1.25B Wins"] = A_append(J_routes["800M Wins"], {
Y_func(Vector3.new(-1458.22, 214.71, 378.48), 'run'),
Y_func(Vector3.new(-1458.94, 214.71, 461.01), 'run'),
w_Jump('z', 461.01, 535.01, 10),
Y_func(Vector3.new(-1456.73, 214.72, 627.46), "run"),
X_Climb(214.72, 363.65, "south"),
Y_func(Vector3.new(-1436.28, 360.71, 622.02), "jump"),
Y_func(Vector3.new(-1436.83, 360.71, 580.85), 'run'),
w_Jump("z", 580.85, 516.73, 10, 359.91),
w_Jump('x', -1432.85, -1370.77, 10, 359.80),
Y_func(Vector3.new(-1329.42, 363.38, 514.71), 'run'),
w_Jump('x', -1329.42, -1256.57, 10, 328.20),
Y_func(Vector3.new(-1249.38, 328.17, 518.92), "run"),
w_Jump("z", 518.92, 579.21, 10, 318.02),
Y_func(Vector3.new(-1237.0, 324.37, 604.52), 'run'),
w_Jump("z", 604.52, 641.39, 7, 328.55),
Y_func(Vector3.new(-1236.11, 328.55, 682.06), "run"),
w_Jump("z", 682.06, 754.47, 10, 334.78),
Y_func(Vector3.new(-1218.74, 345.87, 835.48), 'run'),
w_Jump("x", -1218.74, -1256.9, 10, 349.44),
Y_func(Vector3.new(-1371.46, 364.31, 839.30), 'run'),
Y_func(Vector3.new(-1402.59, 358.73, 839.35), "jump"),
Y_func(Vector3.new(-1404.02, 373.70, 724.20), "run"),
X_Climb(373.70, 561.72, 'north'),
Y_func(Vector3.new(-1404.13, 532.72, 754.06), 'jump'),
Y_func(Vector3.new(-1416.31, 532.72, 757.31), "run"),
Y_func(Vector3.new(-1431.33, 532.62, 759.62), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock35 end, .1)
})

--// 2B Wins
J_routes["2B Wins"] = A_append(J_routes["1.25B Wins"], {
y_Delete(function() return workspace:WaitForChild('NPC_LolMonster', 9e9) end),
Y_func(Vector3.new(-1391.47, 532.72, 857.95), "run"),
Y_func(Vector3.new(-1309.55, 532.72, 1216.51), "run"),
Y_func(Vector3.new(-1395.61, 532.72, 1322.67), "run"),
Y_func(Vector3.new(-1431.45, 530.61, 1329.82), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock36 end, .1)
})

--// 3.5B Wins
J_routes["3.5B Wins"] = A_append(J_routes["2B Wins"], {
Y_func(Vector3.new(-1403.92, 532.72, 1370.41), "run"),
Y_func(Vector3.new(-1440.89, 532.72, 1437.77), "run"),
Y_func(Vector3.new(-1450.16, 508.72, 1446.18), 'run'),
Y_func(Vector3.new(-2034.55, 508.72, 1447.40), 'run'),
Y_func(Vector3.new(-2061.63, 442.72, 1483.68), "jump"),
Y_func(Vector3.new(-2062.37, 440.61, 1459.37), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock37 end, .1)
})

--// 5.5B Wins
J_routes["5.5B Wins"] = A_append(J_routes["3.5B Wins"], {
Y_func(Vector3.new(-2108.13, 442.72, 1480.43), "run"),
Y_func(Vector3.new(-2167.62, 450.90, 1483.76), "run"),
w_Jump('x', -2167.62, -2277.46, 5, 438.72),
Y_func(Vector3.new(-2303.95, 438.72, 1488.53), "run"),
Y_func(Vector3.new(-2336.33, 446.07, 1489.94), 'run'),
Y_func(Vector3.new(-2377.42, 447.72, 1486.59), "run"),
Y_func(Vector3.new(-2416.13, 438.72, 1482.57), 'run'),
Y_func(Vector3.new(-2448.73, 438.72, 1483.99), 'run'),
Y_func(Vector3.new(-2495.35, 446.36, 1486.04), 'run'),
Y_func(Vector3.new(-2530.1, 458.00, 1487.55), 'run'),
Y_func(Vector3.new(-2546.52, 464.21, 1488.27), "run"),
w_Jump("x", -2546.52, -2663.29, 15, 442.72),
Y_func(Vector3.new(-2689.61, 442.72, 1489.92), 'run'),
Y_func(Vector3.new(-2728.75, 450.67, 1489.92), 'run'),
w_Jump("x", -2728.75, -2859.0, 15, 467.14),
Y_func(Vector3.new(-2863.25, 578.98, 1484.21), 'jump'),
Y_func(Vector3.new(-2936.68, 546.35, 1485.69), 'jump'),
Y_func(Vector3.new(-2935.84, 644.02, 1487.80), "jump"),
Y_func(Vector3.new(-3011.83, 615.90, 1486.04), 'jump'),
Y_func(Vector3.new(-2999.28, 720.88, 1486.99), 'jump'),
Y_func(Vector3.new(-3087.81, 674.12, 1488.96), "jump"),
Y_func(Vector3.new(-3163.04, 672.24, 1486.99), 'run'),
Y_func(Vector3.new(-3212.15, 672.23, 1486.47), 'run'),
Y_func(Vector3.new(-3217.24, 672.12, 1459.43), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock38 end, .1)
})

--// 8.5B Wins
J_routes["8.5B Wins"] = A_append(J_routes["5.5B Wins"], {
Y_func(Vector3.new(-3240.66, 672.23, 1487.13), 'run'),
Y_func(Vector3.new(-3628.39, 618.53, 1486.45), "run"),
Y_func(Vector3.new(-3653.68, 616.57, 1486.45), 'run'),
Y_func(Vector3.new(-3657.56, 614.46, 1459.28), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock39 end, .1)
})

--// 16B Wins
J_routes["16B Wins"] = A_append(J_routes["8.5B Wins"], {
y_Delete(function() return workspace.Structure.Stage9:WaitForChild("MovingWalls", 5) end),
y_Delete(function() return workspace.Structure.Stage9:WaitForChild("MovingWalls", 5) end),
Y_func(Vector3.new(-3755.15, 616.57, 1485.15), "run"),
Y_func(Vector3.new(-4020.58, 616.57, 1485.51), "run"),
Y_func(Vector3.new(-4125.63, 616.57, 1483.66), 'run'),
Y_func(Vector3.new(-4130.56, 616.57, 1458.66), "run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock40 end, .1)
})

--// 25B Wins
J_routes["25B Wins"] = A_append(J_routes["16B Wins"], {
Y_func(Vector3.new(-4139.9, 616.57, 1486.43), 'run'),
Y_func(Vector3.new(-4151.03, 616.57, 1486.04), 'run'),
Y_func(Vector3.new(-4168.21, 615.40, 1485.44), 'run'),
Y_func(Vector3.new(-4179.58, 616.51, 1494.16), "run"),
w_Jump('xz', {-4179.58, 1494.16}, {-4363.05, 1547.26}, 20),
Y_func(Vector3.new(-4400.25, 615.51, 1554.08), "run"),
w_Jump('xz', {-4400.25, 1554.08}, {-4599.12, 1447.29}, 20),
Y_func(Vector3.new(-4631.69, 616.09, 1444.71), "run"),
w_Jump('xz', {-4631.69, 1444.71}, {-4811.47, 1556.46}, 20),
Y_func(Vector3.new(-4844.01, 616.07, 1548.85), 'run'),
w_Jump("xz", {-4844.01, 1548.85}, {-4930.58, 1496.13}, 20),
Y_func(Vector3.new(-4969.32, 616.58, 1489.51), "run"),
Y_func(Vector3.new(-4967.56, 614.46, 1458.66), 'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock41 end, .1)
})

--// 40B Wins
J_routes["40B Wins"] = A_append(J_routes["25B Wins"], {
Y_func(Vector3.new(-4985.52, 616.58, 1484.81), "run"),
Y_func(Vector3.new(-5022.58, 616.58, 1484.80), 'run'),
Y_func(Vector3.new(-5072.18, 624.60, 1484.80), 'run'),
w_Jump("x", -5072.18, -5170.8, 10, 634.47),
X_Climb(634.47, 671.41, 'west'),
Y_func(Vector3.new(-5173.76, 676.22, 1485.15), "run"),
Y_func(Vector3.new(-5216.98, 675.58, 1485.15), 'run'),
Y_func(Vector3.new(-5250.32, 683.11, 1485.15), "run"),
w_Jump("x", -5250.32, -5351.21, 10, 692.65),
X_Climb(692.65, 730.63, "west"),
Y_func(Vector3.new(-5359.03,734.58,1484.16),'run'),
Y_func(Vector3.new(-5395.67,734.58,1484.16),'run'),
Y_func(Vector3.new(-5431.06,742.30,1484.16),'run'),
w_Jump('x',-5431.06,-5531.03,10,745.22),
X_Climb(745.22,790.91,'west'),
Y_func(Vector3.new(-5533.4,794.22,1484.16),"run"),
Y_func(Vector3.new(-5553.13,793.58,1484.16),'run'),
Y_func(Vector3.new(-5579.03,793.58,1484.16),"run"),
Y_func(Vector3.new(-5611.81,801.50,1484.16),"run"),
w_Jump('x',-5611.81,-5710.39,10,811.15),
X_Climb(811.15,849.05,"west"),
Y_func(Vector3.new(-5714.52,852.88,1484.16),"run"),
Y_func(Vector3.new(-5737.97,851.59,1483.68),'run'),
Y_func(Vector3.new(-5740.56,849.48,1458.59),"run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock42 end, .1)
})

--// 65B Wins
J_routes["65B Wins"] = A_append(J_routes['40B Wins'], {
y_Delete(function() return workspace["NPC & Piege"]:WaitForChild('FanEffects',5) end),
Y_func(Vector3.new(-5803.62,850.32,1484.30),"run"),
Y_func(Vector3.new(-5862.47,850.32,1482.63),"run"),
Y_func(Vector3.new(-5889.31,850.32,1455.80),"run"),
Y_func(Vector3.new(-5920.81,850.32,1422.61),'run'),
Y_func(Vector3.new(-5951.26,850.32,1390.54),'run'),
Y_func(Vector3.new(-5975.19,850.32,1365.86),"run"),
Y_func(Vector3.new(-6002.38,850.32,1390.27),'run'),
Y_func(Vector3.new(-6028.38,850.32,1414.95),'run'),
Y_func(Vector3.new(-6054.6,850.32,1439.85),"run"),
Y_func(Vector3.new(-6124.64,850.32,1518.69),"run"),
Y_func(Vector3.new(-6197.93,850.32,1588.27),"run"),
Y_func(Vector3.new(-6225.82,850.32,1588.97),'run'),
Y_func(Vector3.new(-6271.42,850.32,1536.66),"run"),
Y_func(Vector3.new(-6362.84,850.32,1441.09),"run"),
Y_func(Vector3.new(-6472.38,850.32,1410.04),'run'),
Y_func(Vector3.new(-6510.15,850.32,1443.25),"run"),
Y_func(Vector3.new(-6564.22,850.32,1473.84),"run"),
Y_func(Vector3.new(-6612.82,850.32,1483.51),'run'),
Y_func(Vector3.new(-6657.07,851.60,1488.95),'run'),
Y_func(Vector3.new(-6662.01,849.49,1458.52),"run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock43 end, .1)
})

--// 100B Wins
J_routes["100B Wins"] = A_append(J_routes['65B Wins'], {
Y_func(Vector3.new(-6676.14,851.60,1485.11),{Animation="run",Speed=200}),
Y_func(Vector3.new(-7309.39,851.60,1490.66),{Animation='run',Speed=200}),
Y_func(Vector3.new(-7387.3,851.60,1390.58),{Animation='run',Speed=200}),
Y_func(Vector3.new(-7460.04,851.60,1308.37),{Animation='run',Speed=200}),
Y_func(Vector3.new(-7519.64,851.60,1254.93),{Animation="run",Speed=200}),
Y_func(Vector3.new(-7598.44,851.60,1258.79),{Animation="run",Speed=200}),
Y_func(Vector3.new(-7677.33,851.60,1253.96),{Animation='run',Speed=200}),
Y_func(Vector3.new(-7825.59,851.60,1255.85),{Animation="run",Speed=200}),
Y_func(Vector3.new(-7904.39,851.60,1259.86),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8070.12,851.60,1248.20),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8129.69,851.60,1183.82),{Animation="run",Speed=200}),
Y_func(Vector3.new(-8195.79,851.60,1109.10),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8248.76,851.60,1049.18),{Animation="run",Speed=200}),
Y_func(Vector3.new(-8331.35,851.60,1028.80),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8430.27,851.60,1022.75),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8520.13,851.60,1017.25),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8688.67,851.60,1014.53),{Animation="run",Speed=200}),
Y_func(Vector3.new(-8893.52,851.60,1024.45),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8937.58,851.60,1063.44),{Animation='run',Speed=200}),
Y_func(Vector3.new(-8997.14,851.60,1116.13),{Animation='run',Speed=200}),
Y_func(Vector3.new(-9062.03,851.60,1173.55),{Animation='run',Speed=200}),
Y_func(Vector3.new(-9124.44,851.60,1228.77),{Animation='run',Speed=200}),
Y_func(Vector3.new(-9361.88,851.60,1480.46),{Animation='run',Speed=200}),
Y_func(Vector3.new(-9450.71,851.60,1501.86),{Animation="run",Speed=200}),
Y_func(Vector3.new(-9514.07,849.49,1458.52),"run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock44 end, .1)
})

--// 200B Wins
J_routes["200B Wins"] = A_append(J_routes["100B Wins"], {
Y_func(Vector3.new(-9523.64,851.60,1484.18),'run'),
Y_func(Vector3.new(-9619.38,859.80,1480.84),'run'),
w_Jump("x",-9619.38,-9741.35,10,851.60),
Y_func(Vector3.new(-9759.7,851.60,1479.50),"run"),
Y_func(Vector3.new(-9792.43,854.19,1480.35),"run"),
Y_func(Vector3.new(-9813.39,859.75,1480.90),'run'),
w_Jump('x',-9813.39,-9904.47,10,851.60),
Y_func(Vector3.new(-9922.79,851.60,1482.02),"run"),
Y_func(Vector3.new(-9929.09,851.60,1572.48),'run'),
Y_func(Vector3.new(-9954.64,851.60,1671.78),"run"),
Y_func(Vector3.new(-9978.88,851.60,1718.81),"run"),
w_Jump('x',-9978.88,-10078.84,10,851.60),
Y_func(Vector3.new(-10139.2,851.60,1717.19),'run'),
Y_func(Vector3.new(-10386.11,851.60,1709.46),"run"),
w_Jump("x",-10386.11,-10474.5,10,851.60),
Y_func(Vector3.new(-10482.66,851.60,1714.08),'run'),
Y_func(Vector3.new(-10492.01,851.60,1607.10),"run"),
Y_func(Vector3.new(-10547.77,851.60,1488.72),"run"),
w_Jump('x',-10547.77,-10639.19,10,851.60),
Y_func(Vector3.new(-10671.35,851.60,1489.79),'run'),
Y_func(Vector3.new(-10683.54,854.48,1489.90),'run'),
Y_func(Vector3.new(-10702.81,859.58,1490.06),'run'),
w_Jump('x',-10702.81,-10786.4,10,851.60),
Y_func(Vector3.new(-10809.74,851.60,1483.34),"run"),
Y_func(Vector3.new(-10806.21,849.48,1458.52),"run"),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock45 end, .1)
})

--==================================================
-- ROUTES BBNO (CASH WORLD)
--==================================================

local f_routes = {}

f_routes["1 Cash"] = {
Y_func(Vector3.new(-132.72,59.43,-234.29),'run',false),
Y_func(Vector3.new(-113.82,59.44,-234.29),'run'),
w_Jump('x',-113.82,-97.56,5),
Y_func(Vector3.new(-84.66,59.43,-234.29),"run"),
w_Jump("x",-84.66,-68.74,5),
Y_func(Vector3.new(-55.84,59.43,-234.3),'run'),
w_Jump("x",-55.84,-39.96,5),
Y_func(Vector3.new(-25.96,59.43,-234.3),'run'),
w_Jump('x',-25.96,-12.15,5),
Y_func(Vector3.new(2.17,59.43,-232.79),'run'),
w_Jump('x',2.17,20.56,5),
Y_func(Vector3.new(32.55,59.43,-232.86),'run'),
w_Jump("x",33.03,45.95,5),
Y_func(Vector3.new(61.60,59.43,-233.85),"run"),
w_Jump('x',61.60,78.22,5),
Y_func(Vector3.new(130.19,59.53,-229.55),"run"),
Y_func(Vector3.new(139.02,59.53,-206.93),"run"),
Y_func(Vector3.new(142.63,59.53,-193.49),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild("WinBlock1",true) end, .1)
}

f_routes["10 Cash"] = A_append(f_routes['1 Cash'], {
y_Delete(function() return workspace:WaitForChild("Stage2LocalNPC_Local",5) end),
Y_func(Vector3.new(177.88,59.53,-214.3),"run"),
Y_func(Vector3.new(240.43,59.52,-192.1),"run"),
Y_func(Vector3.new(303.10,59.52,-178.79),"run"),
Y_func(Vector3.new(343.46,59.52,-188.04),"run"),
Y_func(Vector3.new(382.64,59.52,-210.75),"run"),
Y_func(Vector3.new(446.74,59.52,-231.04),'run'),
Y_func(Vector3.new(470.86,59.52,-235.57),'run'),
Y_func(Vector3.new(493.38,59.52,-236.01),"run"),
d_WaitPos(Vector3.new(1075,167,-702.0),20),
Y_func(Vector3.new(1079.35,167.64,-682.96),'run'),
Y_func(Vector3.new(1067.85,167.66,-639.57),"run"),
w_Jump('z',-639.57,-617.47,5),
Y_func(Vector3.new(1057.62,167.66,-604.86),'run'),
w_Jump('z',-604.86,-579.66,5),
Y_func(Vector3.new(1050.03,167.66,-572.77),'run'),
w_Jump("z",-572.77,-539.64,5),
Y_func(Vector3.new(1075.53,168.65,-538.68),"run"),
w_Jump('z',-538.68,-507.89,5),
Y_func(Vector3.new(1087.46,168.65,-496.78),'run'),
w_Jump('z',-496.78,-470.13,5),
Y_func(Vector3.new(1088.57,167.66,-451.37),'run'),
Y_func(Vector3.new(1054.93,167.64,-388.9),'run'),
Y_func(Vector3.new(1032.29,167.47,-385.5),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild("WinBlock3",true) end, .1)
})

f_routes["20 Cash"] = A_append(f_routes['10 Cash'], {
Y_func(Vector3.new(1054.00,167.64,-356.57),'run'),
Y_func(Vector3.new(1068.66,167.64,-339.77),'run'),
Y_func(Vector3.new(1072.24,167.64,-113.27),"run"),
Y_func(Vector3.new(1053.44,167.64,-70.75),'run'),
Y_func(Vector3.new(1032.29,167.47,-65.5),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild('WinBlock4',true) end, .1)
})

f_routes['50 Cash'] = A_append(f_routes['20 Cash'], {
y_Delete(function() return workspace["NPC & Piege"]:WaitForChild('Stage5',5) end),
Y_func(Vector3.new(1051.58,167.64,-61.34),'run'),
Y_func(Vector3.new(1075.25,167.64,-9.33),'run'),
Y_func(Vector3.new(1074.93,167.64,201.89),'run'),
Y_func(Vector3.new(1051.58,167.64,251.63),'run'),
Y_func(Vector3.new(1032.29,165.47,254.49),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild('WinBlock5',true) end, .1)
})

f_routes['100 Cash'] = A_append(f_routes["50 Cash"], {
y_Delete(function() return workspace['NPC & Piege']:WaitForChild("Stage6",5) end),
Y_func(Vector3.new(1073.64,167.64,290.62),'run'),
Y_func(Vector3.new(1072.98,167.64,329.23),'run'),
Y_func(Vector3.new(1071.46,167.64,744.65),"run"),
Y_func(Vector3.new(1071.89,167.64,796.01),"run"),
Y_func(Vector3.new(1075.10,165.47,815.61),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild('WinBlock6',true) end, .1)
})

f_routes['150 Cash'] = A_append(f_routes["100 Cash"], {
Y_func(Vector3.new(1058.25,167.64,787.80),'run'),
Y_func(Vector3.new(1030.43,167.64,775.00),"run"),
Y_func(Vector3.new(989.49,167.39,774.46),"run"),
w_Jump('x',989.49,903.64,10),
Y_func(Vector3.new(896.68,152.78,775.28),"run"),
Y_func(Vector3.new(858.70,162.71,775.62),"run"),
w_Jump("x",858.70,804.76,10,171.39),
Y_func(Vector3.new(792.59,171.39,776.21),'run'),
Y_func(Vector3.new(766.19,167.90,776.44),'run'),
Y_func(Vector3.new(750.57,161.70,776.58),'run'),
Y_func(Vector3.new(734.33,161.02,776.72),"run"),
Y_func(Vector3.new(717.31,163.94,776.87),"run"),
Y_func(Vector3.new(700.75,166.79,777.01),"run"),
Y_func(Vector3.new(682.97,169.88,777.16),"run"),
Y_func(Vector3.new(678.30,170.83,777.20),"run"),
w_Jump('x',678.30,591.58,10,153.93),
Y_func(Vector3.new(576.58,153.93,776.55),"run"),
Y_func(Vector3.new(560.15,157.11,776.40),"run"),
Y_func(Vector3.new(548.00,160.49,776.30),'run'),
w_Jump("x",548.00,474.80,10,153.87),
Y_func(Vector3.new(461.37,153.87,776.39),'run'),
Y_func(Vector3.new(422.97,165.56,776.42),"run"),
Y_func(Vector3.new(399.79,167.64,775.21),'jump'),
Y_func(Vector3.new(375.96,167.64,754.90),"run"),
Y_func(Vector3.new(354.61,167.64,745.35),'run'),
Y_func(Vector3.new(354.29,165.47,732.48),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild("WinBlock7",true) end, .1)
})

f_routes["300 Cash"] = A_append(f_routes["150 Cash"], {
y_Delete(function() return workspace['NPC & Piege']:WaitForChild('Stage8',5) end),
Y_func(Vector3.new(327.48,167.64,758.88),"run"),
Y_func(Vector3.new(310.44,167.64,773.39),'run'),
Y_func(Vector3.new(151.04,167.64,768.83),'run'),
Y_func(Vector3.new(-113.87,167.64,779.67),'run'),
Y_func(Vector3.new(-207.99,167.64,775.43),"run"),
Y_func(Vector3.new(-387.62,167.64,773.66),'run'),
Y_func(Vector3.new(-463.2,167.64,775.82),"run"),
Y_func(Vector3.new(-493.73,166.28,775.21),'run'),
d_WaitPos(Vector3.new(-173.0,307,-897.0),20),
Y_func(Vector3.new(-172.2,305.51,-853.5),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild("WinBlock8",true) end, .1)
})

f_routes['500 Cash'] = A_append(f_routes['300 Cash'], {
y_Delete(function() return workspace["NPC & Piege"].Stage9:WaitForChild("EyesLaser",5) end),
Y_func(Vector3.new(-137.69,307.68,-896.06),"run"),
Y_func(Vector3.new(-52.99,307.67,-846.61),"run"),
Y_func(Vector3.new(219.98,307.67,-945.54),'run'),
Y_func(Vector3.new(525.09,307.67,-864.82),"run"),
Y_func(Vector3.new(555.58,307.67,-865.87),"run"),
w_Jump('x',555.58,645.77,8),
Y_func(Vector3.new(671.20,307.67,-882.11),"run"),
Y_func(Vector3.new(739.02,307.68,-870.92),'run'),
Y_func(Vector3.new(744.29,305.51,-853.49),'run'),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild('WinBlock9',true) end, .1)
})

f_routes["1000 Cash"] = A_append(f_routes['500 Cash'], {
Y_func(Vector3.new(770.32,307.68,-888.46),'run'),
Y_func(Vector3.new(1135.07,306.24,-896.29),'run'),
Y_func(Vector3.new(1528.40,307.68,-895.34),"run"),
Y_func(Vector3.new(1607.47,305.5,-896.3),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild('WinBlock10',true) end, .1)
})

f_routes['2500 Cash'] = A_append(f_routes["1000 Cash"], {
y_Delete(function() return workspace:WaitForChild('Stage11LocalNPC_Local',1) end),
Y_func(Vector3.new(1591.33,307.68,-879.96),'run'),
Y_func(Vector3.new(1590.50,306.64,-831.37),'run'),
Y_func(Vector3.new(1637.70,306.64,-774.82),"run"),
Y_func(Vector3.new(1768.62,306.64,-708.91),'run'),
Y_func(Vector3.new(1870.80,306.64,-558.7),'run'),
Y_func(Vector3.new(1961.49,306.64,-83.75),"run"),
Y_func(Vector3.new(1871.89,306.64,-47.08),'run'),
Y_func(Vector3.new(1829.88,307.68,14.27),"run"),
Y_func(Vector3.new(1799.73,307.68,24.07),'run'),
Y_func(Vector3.new(1785.29,305.51,24.49),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild('EverythingElse',true):FindFirstChild('WinBlock11',true) end, .1)
})

f_routes['10000 Cash'] = A_append(f_routes["2500 Cash"], {
y_Delete(function() return workspace['NPC & Piege']:WaitForChild('Stage12',5) end),
Y_func(Vector3.new(1820.94,307.68,58.98),'run'),
Y_func(Vector3.new(1822.18,307.68,67.28),"run"),
Y_func(Vector3.new(1826.00,307.68,168.84),"run"),
Y_func(Vector3.new(1827.18,307.68,167.82),'run'),
X_Climb(307.68,810.22,"south"),
Y_func(Vector3.new(1826.56,810.68,178.63),"run"),
Y_func(Vector3.new(1827.79,810.68,339.95),'run'),
w_Jump('z',339.95,425.76,10),
Y_func(Vector3.new(1830.23,810.68,468.44),"run"),
Y_func(Vector3.new(1827.63,810.68,600.55),'run'),
w_Jump("z",600.55,695.27,10),
Y_func(Vector3.new(1827.63,810.68,755.36),'run'),
Y_func(Vector3.new(1822.70,810.68,859.54),'run'),
Y_func(Vector3.new(1822.70,810.68,958.97),'run'),
Y_func(Vector3.new(1828.09,808.51,987.68),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild("WinBlock12",true) end, .1)
})

f_routes["25000 Cash"] = A_append(f_routes['10000 Cash'], {
Y_func(Vector3.new(1756.28,810.68,948.19),'run'),
Y_func(Vector3.new(1637.89,810.68,932.86),"run"),
Y_func(Vector3.new(1569.13,817.75,891.75),"run"),
w_Jump("x",1569.13,1428.92,15,810.67),
Y_func(Vector3.new(1424.50,810.67,871.66),'jump'),
Y_func(Vector3.new(1409.38,810.67,860.12),'run'),
Y_func(Vector3.new(1375.46,818.18,845.95),"run"),
w_Jump('x',1375.46,1210.54,15,810.67),
Y_func(Vector3.new(1085.42,810.67,852.56),'run'),
w_Jump('x',1085.42,948.61,15,804.28),
Y_func(Vector3.new(936.15,810.67,851.35),"run"),
Y_func(Vector3.new(914.45,810.67,900.74),'run'),
Y_func(Vector3.new(883.44,810.67,942.78),"run"),
Y_func(Vector3.new(855.03,810.68,951.44),"run"),
Y_func(Vector3.new(809.69,810.68,921.83),'run'),
Y_func(Vector3.new(807.29,808.51,902.49),"run"),
F_WinBlock(function(...) return workspace:FindFirstChild("EverythingElse",true):FindFirstChild('WinBlock13',true) end, .1)
})

f_routes["50000 Cash"] = A_append(f_routes['25000 Cash'], {
y_Delete(function() return workspace:WaitForChild("Stage14LocalNPC_Local",5) end),
Y_func(Vector3.new(766.63,810.68,942.38),'run'),
Y_func(Vector3.new(733.98,810.75,935.17),'run'),
Y_func(Vector3.new(714.95,810.75,699.80),'run'),
Y_func(Vector3.new(712.65,810.75,573.42),'run'),
Y_func(Vector3.new(598.73,810.75,566.76),'run'),
Y_func(Vector3.new(594.86,810.75,476.48),'run'),
Y_func(Vector3.new(403.02,810.75,468.67),'run'),
Y_func(Vector3.new(401.96,810.75,732.33),'run'),
Y_func(Vector3.new(505.19,810.75,739.38),'run'),
Y_func(Vector3.new(515.39,810.75,839.95),'run'),
Y_func(Vector3.new(320.87,810.75,840.91),'run'),
Y_func(Vector3.new(315.45,810.75,946.99),"run"),
Y_func(Vector3.new(202.00,810.75,948.63),'run'),
Y_func(Vector3.new(126.13,810.68,945.22),'run'),
Y_func(Vector3.new(100.12,808.96,945.90),'run'),
F_WinBlock(function(...) return workspace.EverythingElse.FinalSAS.WinPad:FindFirstChild("WinBlock14") end, .1)
})

--==================================================
-- ROUTE RESOLVER
--==================================================

local RouteTable = {['World 1']=z_routes,['World 2']=D_routes,['World 3']=J_routes,['World 3 Tween']=J_routes,['BBNO']=f_routes}
K.Routes = RouteTable

local function ResolveRoute(D,f)
local k=RouteTable[D]
if not k then return nil end
local A=k[f]
if not A then return nil end
return A
end

K.UpdateRoute=(function(A)
if A=='Wait' then
J_routes['300M Wins']={
Y_func(Vector3.new(-1433.18,-159.43,-918.69),'run',false),
Y_func(Vector3.new(-1443.18,-159.43,-918.69),"run"),
c_WaitTouched(function() return workspace["NPC & Piege"].Ball1.KillBall end, function() return workspace['NPC & Piege'].Ball1.BallSpawn end),
Y_func(Vector3.new(-1442.42,-160.68,-856.0),'run'),
Y_func(Vector3.new(-1433.7,-157.07,-832.8),"run"),
c_WaitTouched(function() return workspace["NPC & Piege"].Ball1.KillBall end, function() return workspace["NPC & Piege"].Ball1.BallSpawn end),
Y_func(Vector3.new(-1443.7,-157.07,-832.8),"run"),
Y_func(Vector3.new(-1442.99,-142.74,-787.21),"run"),
Y_func(Vector3.new(-1442.94,-125.83,-733.44),'run'),
Y_func(Vector3.new(-1430.96,-125.73,-733.13),'run'),
c_WaitTouched(function() return workspace["NPC & Piege"].Ball1.KillBall end, function() return workspace.Bottom_ end),
Y_func(Vector3.new(-1440.96,-125.73,-733.13),'run'),
Y_func(Vector3.new(-1444.83,-111.0,-686.28),"run"),
Y_func(Vector3.new(-1442.15,-92.21,-630.54),'run'),
Y_func(Vector3.new(-1431.08,-90.91,-630.42),"run"),
c_WaitTouched(function() return workspace["NPC & Piege"].Ball1.KillBall end, function() return workspace.Top_ end),
Y_func(Vector3.new(-1445.38,-83.54,-618.05),"run"),
Y_func(Vector3.new(-1443.04,-68.54,-532.27),'run'),
Y_func(Vector3.new(-1481.83,-68.65,-515.77),'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock32 end, .1)
}
else
J_routes["300M Wins"]={
Y_func(Vector3.new(-1436.38,-159.43,-934.65),'run',false),
Y_func(Vector3.new(-1434.34,-159.43,-887.05),'run'),
w_Jump('z',-887.05,-837.57,5,-158.57),
w_Jump('z',-837.57,-732.15,15,-125.42),
w_Jump("z",-732.15,-630.24,15,-93.37),
w_Jump("z",-630.24,-534.11,15,-69.54),
Y_func(Vector3.new(-1441.31,-69.54,-526.62),"run"),
Y_func(Vector3.new(-1481.83,-71.65,-515.77),'run'),
F_WinBlock(function(...) return workspace.Structure.Stage1.SAS.WinBlock32 end, .1)
}
end
end)

K.GetRoute = ResolveRoute

K.Run=function(A,D,J)
J=J or {}
D=K.ResolveSmartTarget(A,D)
x.AutoWinEffectiveTarget=D
local f=ResolveRoute(A,D)
if not f then return false end
K.EnsureWinRemoteListener()
x.winReceived=false
x.autoWalkRunning=true
x.autoWinRunId+=1
if q_world(A) then p_touch(true) end
local A=x.autoWinRunId
local D,D=H_char()
local k=D.Died:Connect(function()
if x.autoWinRunId==A then
x.autoWalkRunning=false
x.autoWinRunId+=1
S_reset()
end
end)
for D,Y in ipairs(f) do
if not Q_check(A) or x.winReceived then break end
if N and N['Auto Win']==false then
x.autoWalkRunning=false
break
end
if not I_step(Y,A,f,D) then break end
end
if k then k:Disconnect() end
if J.StopAfterRun~=false then x.autoWalkRunning=false end
if J.StopAfterRun~=false or not x.autoWalkRunning then p_touch(false) end
return true
end

K.Start=function(A,D,J)
J=J or {}
local f=J.DelayBetweenRuns or 1.5
if x.autoWalkRunning then return end
K.EnsureWinRemoteListener()
x.autoWalkRunning=true
task.spawn(function()
if q_world(A) then p_touch(true) end
while x.autoWalkRunning do
local q=K.ResolveSmartTarget(A,D)
x.AutoWinEffectiveTarget=q
local D=ResolveRoute(A,q)
if not D then x.autoWalkRunning=false break end
for A,q in ipairs(D) do
if not x.autoWalkRunning then break end
x.autoWinRunId+=1
local z=x.autoWinRunId
if not I_step(q,z,D,A) then break end
end
if x.autoWalkRunning then task.wait(f) end
end
p_touch(false)
end)
end

K.Stop=function()
x.autoWalkRunning=false
x.autoWinRunId+=1
x.AutoWinEffectiveTarget=nil
S_reset()
p_touch(false)
end

return K
end)()}

--// ฟังก์ชันพื้นฐาน
function AutoWin:GetRoute(world, target)
    local w = self.Routes[world]
    return w and w[target]
end

function AutoWin:ResetChar()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hum and hrp then
        hum:Move(Vector3.zero, false)
        hum.WalkSpeed = 16
        hrp.AssemblyLinearVelocity = Vector3.zero
        hum.PlatformStand = false
        for _, n in ipairs({"AutoWinBodyGyro","AutoWinBodyVelocity","FlyGyro","FlyVelocity"}) do
            local o = hrp:FindFirstChild(n)
            if o then o:Destroy() end
        end
    end
end

function AutoWin:Start(world, target)
    if self.Enabled then return end
    self.Enabled = true
    self.RunId += 1
    local runId = self.RunId
    
    task.spawn(function()
        while self.Enabled and self.RunId == runId do
            -- TODO: ใส่ลอจิกวิ่งเส้นทางตรงนี้
            -- หรือเรียก K.Start() จากโค้ด AutoWin เต็ม
            
            local route = self:GetRoute(world, target)
            if not route then 
                warn("ไม่พบเส้นทาง:", world, "→", target)
                break 
            end
            
            -- วิ่งเส้นทาง (placeholder)
            for i, step in ipairs(route) do
                if not self.Enabled or self.RunId ~= runId then break end
                -- ประมวลผลแต่ละ step
                task.wait(0.1)
            end
            
            task.wait(1.5) -- DelayBetweenRuns
        end
        self:ResetChar()
    end)
end

function AutoWin:Stop()
    self.Enabled = false
    self.RunId += 1
    self:ResetChar()
end

--==================================================
-- AUTO WIN UI
--==================================================

local AutoWinSection = Home:Section({Title = "🏆 AutoWin Settings"})

-- Dropdown World
local WorldDropdown = AutoWinSection:AddDropdown({
    Title = "เลือก World",
    Options = {"World 1", "World 2", "World 3", "BBNO"},
    Default = "World 1",
    Callback = function(Value)
        AutoWin.World = Value
        SelectedTarget = "Smart"
        TargetDropdown:Refresh(AutoWin.Targets[Value] or AutoWin.Targets["World 1"], true)
        if Auto_win then
            AutoWin:Stop()
            Auto_win = false
            Window:Notify({Title = "⚠️ AutoWin หยุดชั่วคราว", Content = "เปลี่ยน World ขณะทำงาน", Duration = 3})
        end
    end
})

-- Dropdown Target
local TargetDropdown = AutoWinSection:AddDropdown({
    Title = "เลือก Target",
    Options = AutoWin.Targets["World 1"],
    Default = "Smart",
    Callback = function(Value)
        AutoWin.Target = Value
        SelectedTarget = Value
        if Auto_win then
            AutoWin:Stop()
            Auto_win = false
            Window:Notify({Title = "⚠️ AutoWin หยุดชั่วคราว", Content = "เปลี่ยน Target ขณะทำงาน", Duration = 3})
        end
    end
})

-- Toggle AutoWin
AutoWinSection:Toggle({
    Title = "Auto Win",
    Desc = "ฟาร์มวินอัตโนมัติ (วนซ้ำจนกว่าจะปิด)",
    Callback = function(Value)
        Auto_win = Value
        if Value then
            AutoWin:Start(AutoWin.World, AutoWin.Target)
            Window:Notify({Title = "▶️ AutoWin เริ่มทำงาน", Content = AutoWin.World .. " → " .. AutoWin.Target, Duration = 3})
        else
            AutoWin:Stop()
            Window:Notify({Title = "⏹️ AutoWin หยุดทำงาน", Content = "หยุดฟาร์มแล้ว", Duration = 3})
        end
    end
})

--==================================================
-- Info
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
    Desc = "ปลดล็อกลู่วิ่งทั้งหมด",
    Callback = function(value)
        if value then
            EnableBypass()
        else
            DisableBypass()
        end
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

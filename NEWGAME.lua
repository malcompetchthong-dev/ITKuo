local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

pcall(function()
    local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))
    if ClientState and ClientState.Get then
        local oldGet = ClientState.Get
        ClientState.Get = function(self, ...)
            local result = oldGet(self, ...)
            if type(result) == "table" then
                result.AdminTreadmillActive = true
                result.DiamondTreadmillActive = true
                result.GoldTreadmillActive = true
                result.CandyTreadmillActive = true
            end
            return result
        end
        print("✅ Bypass")
    end
end)

-- ============================================
-- วิธี 2: บล็อก Remote ที่สั่งให้แสดง UI
-- ============================================
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local blocked = {"PromptAdminTreadmill", "PromptDiamondTreadmill", "PromptCandyTreadmill", "PromptGoldTreadmill"}

for _, name in ipairs(blocked) do
    local remote = Remotes:FindFirstChild(name)
    if remote and remote:IsA("RemoteEvent") then
        remote.FireServer = function() end
    end
end

-- ============================================
-- วิธี 3: ทำลาย UI ซื้อขายทันทีที่โผล่ (Nuclear)
-- ============================================
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local killWords = {"ซื้อไอเท็ม", "แทรดมิลล์แอดมิน", "แทรดมิลล์", "899", "1,029", "Admin Treadmill", "Buy Item"}

local function nukeUI()
    for _, gui in ipairs(PlayerGui:GetChildren()) do
        if not gui:IsA("ScreenGui") then continue end
        for _, desc in ipairs(gui:GetDescendants()) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") then
                local t = desc.Text
                for _, word in ipairs(killWords) do
                    if t and t:find(word) then
                        gui:Destroy()
                        return
                    end
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(nukeUI)

PlayerGui.ChildAdded:Connect(function(child)
    task.wait(0.05)
    if not child:IsA("ScreenGui") then return end
    for _, desc in ipairs(child:GetDescendants()) do
        if desc:IsA("TextLabel") or desc:IsA("TextButton") then
            local t = desc.Text
            for _, word in ipairs(killWords) do
                if t and t:find(word) then
                    child:Destroy()
                    return
                end
            end
        end
    end
end)

-- ============================================
-- วิธี 4: ลบ ProximityPrompt บนแทรดมิลล์ทั้งหมด
-- ============================================
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
workspace.DescendantAdded:Connect(function(d)
    if d:IsA("ProximityPrompt") or d:IsA("ClickDetector") then
        local p = d.Parent
        if p and (p.Name:lower():find("treadmill") or p.Name:lower():find("admin")) then
            d:Destroy()
        end
    end
end)

print("Bypassสำเร็จ")

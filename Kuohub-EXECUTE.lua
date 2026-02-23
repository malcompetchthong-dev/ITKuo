--// ================================
--// KuoHub Executor (Buttons Style)
--// ================================

print("KuoHub Loaded")

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =====================================
-- 🧱 GUI ROOT
-- =====================================
local gui = Instance.new("ScreenGui")
gui.Name = "KuoHubGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- =====================================
-- 🔘 OPEN BUTTON
-- =====================================
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,130,0,40)
openBtn.Position = UDim2.new(0,20,0.5,-20)
openBtn.Text = "Open KuoHub"
openBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = gui

-- =====================================
-- 🪟 MAIN WINDOW
-- =====================================
local main = Instance.new("Frame")
main.Size = UDim2.new(0,520,0,320)
main.Position = UDim2.new(0.5,-260,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = false
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

-- =====================================
-- 🔝 TITLE
-- =====================================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "script1.lua"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = main

-- =====================================
-- 📜 CODE BOX
-- =====================================
local codeBox = Instance.new("TextBox")
codeBox.Size = UDim2.new(0.96,0,0.6,0)
codeBox.Position = UDim2.new(0.02,0,0.12,0)
codeBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
codeBox.TextColor3 = Color3.new(1,1,1)
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.ClearTextOnFocus = false
codeBox.MultiLine = true
codeBox.Text = "-- Scripts.lua\n"
codeBox.Parent = main

-- =====================================
-- 🔘 EXECUTE BUTTON
-- =====================================
local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(0.28,0,0,40)
execBtn.Position = UDim2.new(0.02,0,0.78,0)
execBtn.Text = "EXECUTE"
execBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
execBtn.TextColor3 = Color3.new(1,1,1)
execBtn.Parent = main

-- =====================================
-- 🔘 CLEAR BUTTON
-- =====================================
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.28,0,0,40)
clearBtn.Position = UDim2.new(0.36,0,0.78,0)
clearBtn.Text = "CLEAR"
clearBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
clearBtn.TextColor3 = Color3.new(1,1,1)
clearBtn.Parent = main

-- =====================================
-- 🔘 EXECUTE CLIPBOARD
-- =====================================
local clipBtn = Instance.new("TextButton")
clipBtn.Size = UDim2.new(0.28,0,0,40)
clipBtn.Position = UDim2.new(0.70,0,0.78,0)
clipBtn.Text = "EXECUTE CLIPBOARD"
clipBtn.BackgroundColor3 = Color3.fromRGB(0,150,120)
clipBtn.TextColor3 = Color3.new(1,1,1)
clipBtn.Parent = main

-- =====================================
-- 🎬 OPEN / CLOSE
-- =====================================
openBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- =====================================
-- ▶️ EXECUTE
-- =====================================
execBtn.MouseButton1Click:Connect(function()
	local src = codeBox.Text
	if src == "" then return end

	local f,err = loadstring(src)
	if not f then warn(err) return end

	local ok,e = pcall(f)
	if not ok then warn(e) end
end)

-- =====================================
-- 🧹 CLEAR
-- =====================================
clearBtn.MouseButton1Click:Connect(function()
	codeBox.Text = "-- Scripts.lua\n"
end)

-- =====================================
-- 📋 EXECUTE CLIPBOARD
-- =====================================
clipBtn.MouseButton1Click:Connect(function()
	if getclipboard then
		local clip = getclipboard()
		if clip and clip ~= "" then
			local f,err = loadstring(clip)
			if not f then warn(err) return end
			local ok,e = pcall(f)
			if not ok then warn(e) end
		end
	else
		warn("Clipboard not supported in normal Roblox")
	end
end)

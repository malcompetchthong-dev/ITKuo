-- =====================================================
-- KUO HUB UI LIBRARY
-- Drag + Dark/Light + Minimize + Close
-- =====================================================

local Library = {}

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- ================= THEME =================

local Themes = {
    Dark = {
        BG = Color3.fromRGB(35,35,35),
        Top = Color3.fromRGB(45,45,45),
        Tab = Color3.fromRGB(40,40,40),
        Text = Color3.fromRGB(235,235,235)
    },
    Light = {
        BG = Color3.fromRGB(240,240,240),
        Top = Color3.fromRGB(220,220,220),
        Tab = Color3.fromRGB(230,230,230),
        Text = Color3.fromRGB(25,25,25)
    }
}

local CurrentTheme = Themes.Dark
local ThemeObjects = {}

local function ApplyTheme()
	for _,v in pairs(ThemeObjects) do
		if v.Type=="BG" then v.Instance.BackgroundColor3=CurrentTheme.BG end
		if v.Type=="TOP" then v.Instance.BackgroundColor3=CurrentTheme.Top end
		if v.Type=="TAB" then v.Instance.BackgroundColor3=CurrentTheme.Tab end
		if v.Type=="TEXT" then v.Instance.TextColor3=CurrentTheme.Text end
	end
end

function Library:SetTheme(theme)
	if Themes[theme] then
		CurrentTheme = Themes[theme]
		ApplyTheme()
	end
end

-- ================= DRAG =================

local function Drag(frame, dragPart)
	local dragging=false
	local dragStart,startPos

	dragPart.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true
			dragStart=input.Position
			startPos=frame.Position
		end
	end)

	dragPart.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
			local delta=input.Position-dragStart
			frame.Position=UDim2.new(
				startPos.X.Scale,startPos.X.Offset+delta.X,
				startPos.Y.Scale,startPos.Y.Offset+delta.Y
			)
		end
	end)
end

-- ================= WINDOW =================

function Library:Window(cfg)

	CurrentTheme = Themes[cfg.Theme or "Dark"]

	local gui = Instance.new("ScreenGui")
	gui.Parent = player.PlayerGui
	gui.ResetOnSpawn = false

	local main = Instance.new("Frame", gui)
	main.Size = cfg.Config and cfg.Config.Size or UDim2.new(0,500,0,400)
	main.Position = UDim2.new(0.5,-250,0.5,-200)
	main.BackgroundColor3 = CurrentTheme.BG
	main.BorderSizePixel = 0
	table.insert(ThemeObjects,{Instance=main,Type="BG"})
	Instance.new("UICorner",main)

	-- TOP BAR
	local top = Instance.new("Frame", main)
	top.Size = UDim2.new(1,0,0,34)
	top.BackgroundColor3 = CurrentTheme.Top
	top.BorderSizePixel = 0
	table.insert(ThemeObjects,{Instance=top,Type="TOP"})

	local title = Instance.new("TextLabel", top)
	title.Size = UDim2.new(1,-80,1,0)
	title.Position = UDim2.new(0,10,0,0)
	title.BackgroundTransparency = 1
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = (cfg.Title or "KUO HUB").." | "..(cfg.Desc or "")
	title.TextColor3 = CurrentTheme.Text
	title.Font = Enum.Font.GothamBold
	title.TextSize = 13
	table.insert(ThemeObjects,{Instance=title,Type="TEXT"})

	Drag(main, top)

	-- ===== BUTTONS =====

	local btnClose = Instance.new("TextButton", top)
	btnClose.Size = UDim2.new(0,24,0,24)
	btnClose.Position = UDim2.new(1,-28,0.5,-12)
	btnClose.Text = "X"
	btnClose.Font = Enum.Font.GothamBold
	btnClose.TextSize = 14
	btnClose.BackgroundColor3 = Color3.fromRGB(200,70,70)
	btnClose.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",btnClose)

	local btnMini = Instance.new("TextButton", top)
	btnMini.Size = UDim2.new(0,24,0,24)
	btnMini.Position = UDim2.new(1,-56,0.5,-12)
	btnMini.Text = "-"
	btnMini.Font = Enum.Font.GothamBold
	btnMini.TextSize = 16
	btnMini.BackgroundColor3 = Color3.fromRGB(80,80,80)
	btnMini.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",btnMini)

	local minimized = false
	local oldSize = main.Size

	-- SIDEBAR
	local sidebar = Instance.new("Frame", main)
	sidebar.Size = UDim2.new(0,150,1,-34)
	sidebar.Position = UDim2.new(0,0,0,34)
	sidebar.BackgroundColor3 = CurrentTheme.Tab
	table.insert(ThemeObjects,{Instance=sidebar,Type="TAB"})
	Instance.new("UIListLayout", sidebar).Padding = UDim.new(0,5)

	local content = Instance.new("Frame", main)
	content.Size = UDim2.new(1,-150,1,-34)
	content.Position = UDim2.new(0,150,0,34)
	content.BackgroundTransparency = 1

	btnMini.MouseButton1Click:Connect(function()
		if not minimized then
			oldSize = main.Size
			main.Size = UDim2.new(oldSize.X.Scale,oldSize.X.Offset,0,34)
			sidebar.Visible = false
			content.Visible = false
			btnMini.Text = "+"
			minimized = true
		else
			main.Size = oldSize
			sidebar.Visible = true
			content.Visible = true
			btnMini.Text = "-"
			minimized = false
		end
	end)

	btnClose.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)

	-- ================= TAB =================

	local Tabs = {}
	local Window = {}

	function Window:Tab(info)
		local btn = Instance.new("TextButton", sidebar)
		btn.Size = UDim2.new(1,-10,0,30)
		btn.Text = info.Title
		btn.BackgroundColor3 = CurrentTheme.BG
		btn.TextColor3 = CurrentTheme.Text
		btn.BorderSizePixel = 0
		Instance.new("UICorner",btn)

		local page = Instance.new("ScrollingFrame", content)
		page.Size = UDim2.new(1,0,1,0)
		page.Visible = false
		page.BackgroundTransparency = 1
		page.CanvasSize = UDim2.new()

		local layout = Instance.new("UIListLayout", page)
		layout.Padding = UDim.new(0,6)

		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
		end)

		Tabs[info.Title]=page

		btn.MouseButton1Click:Connect(function()
			for _,v in pairs(Tabs) do v.Visible=false end
			page.Visible=true
		end)

		local Tab={}

		function Tab:Section(c)
			local lbl = Instance.new("TextLabel", page)
			lbl.Size = UDim2.new(1,-10,0,25)
			lbl.BackgroundTransparency = 1
			lbl.Text = c.Title
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.TextColor3 = CurrentTheme.Text
		end

		function Tab:Toggle(t)
			local state=t.Value or false

			local b=Instance.new("TextButton",page)
			b.Size=UDim2.new(1,-10,0,40)
			b.Text=t.Title.." : "..tostring(state)
			b.BackgroundColor3=CurrentTheme.Tab
			Instance.new("UICorner",b)

			b.MouseButton1Click:Connect(function()
				state=not state
				b.Text=t.Title.." : "..tostring(state)
				if t.Callback then t.Callback(state) end
			end)
		end

		return Tab
	end

	return Window
end

return Library

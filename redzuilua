--// redzlib v5 (Single File)
--// Style: Redz / OMG Hub
--// Made for kuo hub compatible API

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

local redzlib = {}
redzlib.Tabs = {}
redzlib.Theme = "Darker"

--==============================
-- 🎨 THEMES
--==============================
redzlib.Themes = {
	Dark = {
		BG = Color3.fromRGB(40,40,40),
		Stroke = Color3.fromRGB(70,70,70),
		Text = Color3.fromRGB(255,255,255),
		Theme = Color3.fromRGB(65,150,255)
	},
	Darker = {
		BG = Color3.fromRGB(25,25,25),
		Stroke = Color3.fromRGB(45,45,45),
		Text = Color3.fromRGB(245,245,245),
		Theme = Color3.fromRGB(88,101,242)
	},
	Purple = {
		BG = Color3.fromRGB(30,25,35),
		Stroke = Color3.fromRGB(50,40,60),
		Text = Color3.fromRGB(240,240,240),
		Theme = Color3.fromRGB(150,0,255)
	}
}

--==============================
-- 🪟 WINDOW
--==============================
function redzlib:MakeWindow(cfg)
	local gui = Instance.new("ScreenGui")
	gui.Name = "redzlib_ui"
	gui.ResetOnSpawn = false
	gui.Parent = CoreGui

	local main = Instance.new("Frame", gui)
	main.Size = UDim2.fromOffset(550,380)
	main.Position = UDim2.fromScale(0.5,0.5)
	main.AnchorPoint = Vector2.new(0.5,0.5)
	main.BackgroundColor3 = redzlib.Themes[redzlib.Theme].BG
	main.Active = true
	main.Draggable = true

	local stroke = Instance.new("UIStroke", main)
	stroke.Color = redzlib.Themes[redzlib.Theme].Stroke

	local title = Instance.new("TextLabel", main)
	title.Size = UDim2.new(1,-20,0,40)
	title.Position = UDim2.fromOffset(10,0)
	title.BackgroundTransparency = 1
	title.TextXAlignment = Left
	title.Text = cfg.Title or "Window"
	title.TextColor3 = redzlib.Themes[redzlib.Theme].Text
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18

	local tabsFrame = Instance.new("Frame", main)
	tabsFrame.Size = UDim2.new(0,160,1,-50)
	tabsFrame.Position = UDim2.fromOffset(0,50)
	tabsFrame.BackgroundTransparency = 1

	local pages = Instance.new("Frame", main)
	pages.Size = UDim2.new(1,-160,1,-50)
	pages.Position = UDim2.fromOffset(160,50)
	pages.BackgroundTransparency = 1

	local window = {}
	window.Tabs = {}

	--==============================
	-- ➕ TAB
	--==============================
	function window:MakeTab(info)
		local name = info[1]

		local tabBtn = Instance.new("TextButton", tabsFrame)
		tabBtn.Size = UDim2.new(1,0,0,40)
		tabBtn.Text = name
		tabBtn.BackgroundColor3 = redzlib.Themes[redzlib.Theme].BG
		tabBtn.TextColor3 = redzlib.Themes[redzlib.Theme].Text
		tabBtn.Font = Enum.Font.Gotham
		tabBtn.TextSize = 14

		local page = Instance.new("ScrollingFrame", pages)
		page.Size = UDim2.fromScale(1,1)
		page.CanvasSize = UDim2.new(0,0,0,0)
		page.ScrollBarImageTransparency = 1
		page.Visible = false

		local layout = Instance.new("UIListLayout", page)
		layout.Padding = UDim.new(0,8)

		local tab = {}

		tabBtn.MouseButton1Click:Connect(function()
			for _,t in pairs(window.Tabs) do
				t.Page.Visible = false
			end
			page.Visible = true
		end)

		--==============================
		-- 📦 ELEMENTS
		--==============================
		function tab:AddSection(info)
			local lbl = Instance.new("TextLabel", page)
			lbl.Size = UDim2.new(1,-10,0,30)
			lbl.Text = info[1]
			lbl.BackgroundTransparency = 1
			lbl.TextColor3 = redzlib.Themes[redzlib.Theme].Theme
			lbl.Font = Enum.Font.GothamBold
			lbl.TextSize = 14
		end

		function tab:AddParagraph(info)
			local lbl = Instance.new("TextLabel", page)
			lbl.Size = UDim2.new(1,-10,0,50)
			lbl.TextWrapped = true
			lbl.TextYAlignment = Top
			lbl.Text = info[1].."\n"..info[2]
			lbl.BackgroundTransparency = 1
			lbl.TextColor3 = redzlib.Themes[redzlib.Theme].Text
			lbl.Font = Enum.Font.Gotham
			lbl.TextSize = 13
		end

		function tab:AddButton(info)
			local btn = Instance.new("TextButton", page)
			btn.Size = UDim2.new(1,-10,0,36)
			btn.Text = info[1]
			btn.BackgroundColor3 = redzlib.Themes[redzlib.Theme].Theme
			btn.TextColor3 = Color3.new(1,1,1)
			btn.Font = Enum.Font.GothamBold
			btn.TextSize = 14
			btn.MouseButton1Click:Connect(function()
				pcall(info[2])
			end)
		end

		function tab:AddDiscordInvite(cfg)
			self:AddButton({
				cfg.Name.." (Discord)",
				function()
					setclipboard(cfg.Invite)
				end
			})
		end

		tab.Page = page
		table.insert(window.Tabs, tab)
		return tab
	end

	--==============================
	-- 🧩 DIALOG
	--==============================
	function window:Dialog(cfg)
		local frame = Instance.new("Frame", gui)
		frame.Size = UDim2.fromOffset(300,180)
		frame.Position = UDim2.fromScale(0.5,0.5)
		frame.AnchorPoint = Vector2.new(0.5,0.5)
		frame.BackgroundColor3 = redzlib.Themes[redzlib.Theme].BG

		local lbl = Instance.new("TextLabel", frame)
		lbl.Size = UDim2.new(1,-20,0,80)
		lbl.Position = UDim2.fromOffset(10,10)
		lbl.TextWrapped = true
		lbl.Text = cfg.Text
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = redzlib.Themes[redzlib.Theme].Text

		for i,opt in ipairs(cfg.Options) do
			local b = Instance.new("TextButton", frame)
			b.Size = UDim2.new(1,-20,0,30)
			b.Position = UDim2.fromOffset(10,90 + (i-1)*35)
			b.Text = opt[1]
			b.BackgroundColor3 = redzlib.Themes[redzlib.Theme].Theme
			b.TextColor3 = Color3.new(1,1,1)
			b.MouseButton1Click:Connect(function()
				pcall(opt[2])
				frame:Destroy()
			end)
		end
	end

	function window:AddMinimizeButton()
		local btn = Instance.new("TextButton", gui)
		btn.Size = UDim2.fromOffset(50,50)
		btn.Position = UDim2.fromOffset(20,200)
		btn.Text = "◉"
		btn.BackgroundColor3 = redzlib.Themes[redzlib.Theme].Theme
		btn.TextColor3 = Color3.new(1,1,1)
		btn.MouseButton1Click:Connect(function()
			main.Visible = not main.Visible
		end)
	end

	function window:SelectTab(tab)
		tab.Page.Visible = true
	end

	return window
end

--==============================
-- 🎨 SET THEME
--==============================
function redzlib:SetTheme(name)
	if redzlib.Themes[name] then
		redzlib.Theme = name
	end
end

return redzlib

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
	TitleTH = "ขอภัยในความไม่สะดวกปิดปรับปรุงชั่วคราว",
	TitleEN = "Temporarily Under Maintenance",

	DescriptionTH = "ระบบกำลังอยู่ระหว่างการปรับปรุงและพัฒนา",
	DescriptionEN = "The system is currently being improved and updated.",

	StatusTH = "กำลังดำเนินการปรับปรุง",
	StatusEN = "Maintenance in progress",

	DiscordURL = "https://discord.gg/Apn2j9Fez",
	TikTokURL = "https://www.tiktok.com/@pongsakornpetchthong3?_r=1&_t=ZS-98xTCoTA7gD",

	Accent = Color3.fromRGB(145, 90, 255),
	Background = Color3.fromRGB(15, 15, 20),
	Card = Color3.fromRGB(24, 24, 32),
	Text = Color3.fromRGB(245, 245, 250),
	SubText = Color3.fromRGB(170, 170, 185),
}

--==================================================
-- CLEAN OLD GUI
--==================================================

local OldGui = PlayerGui:FindFirstChild("MaintenanceGUI")

if OldGui then
	OldGui:Destroy()
end

--==================================================
-- BLUR
--==================================================

local Blur = Lighting:FindFirstChild("MaintenanceBlur")

if Blur then
	Blur:Destroy()
end

Blur = Instance.new("BlurEffect")
Blur.Name = "MaintenanceBlur"
Blur.Size = 0
Blur.Parent = Lighting

TweenService:Create(
	Blur,
	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{Size = 12}
):Play()

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MaintenanceGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = PlayerGui

--==================================================
-- BACKGROUND
--==================================================

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.fromScale(1, 1)
Background.Position = UDim2.fromScale(0, 0)
Background.BackgroundColor3 = CONFIG.Background
Background.BackgroundTransparency = 0.08
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Gradient
local BackgroundGradient = Instance.new("UIGradient")
BackgroundGradient.Rotation = 45
BackgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 15, 30)),
	ColorSequenceKeypoint.new(0.5, CONFIG.Background),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 15, 25)),
})
BackgroundGradient.Parent = Background

--==================================================
-- MAIN CARD
--==================================================

local Card = Instance.new("Frame")
Card.Name = "MainCard"
Card.AnchorPoint = Vector2.new(0.5, 0.5)
Card.Position = UDim2.fromScale(0.5, 0.5)
Card.Size = UDim2.new(0.82, 0, 0, 480)
Card.BackgroundColor3 = CONFIG.Card
Card.BorderSizePixel = 0
Card.Parent = Background

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 22)
CardCorner.Parent = Card

local CardStroke = Instance.new("UIStroke")
CardStroke.Color = CONFIG.Accent
CardStroke.Thickness = 1.5
CardStroke.Transparency = 0.35
CardStroke.Parent = Card

local CardGradient = Instance.new("UIGradient")
CardGradient.Rotation = 90
CardGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 28, 40)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 19, 27)),
})
CardGradient.Parent = Card

-- Responsive width
local CardConstraint = Instance.new("UISizeConstraint")
CardConstraint.MinSize = Vector2.new(300, 430)
CardConstraint.MaxSize = Vector2.new(650, 500)
CardConstraint.Parent = Card

--==================================================
-- TOP ACCENT
--==================================================

local AccentBar = Instance.new("Frame")
AccentBar.Size = UDim2.new(0.35, 0, 0, 4)
AccentBar.Position = UDim2.new(0.325, 0, 0, 0)
AccentBar.BackgroundColor3 = CONFIG.Accent
AccentBar.BorderSizePixel = 0
AccentBar.Parent = Card

local AccentCorner = Instance.new("UICorner")
AccentCorner.CornerRadius = UDim.new(1, 0)
AccentCorner.Parent = AccentBar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.BackgroundTransparency = 1
Content.Size = UDim2.new(1, -50, 1, -45)
Content.Position = UDim2.new(0, 25, 0, 25)
Content.Parent = Card

local Layout = Instance.new("UIListLayout")
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 12)
Layout.Parent = Content

--==================================================
-- ICON
--==================================================

local Icon = Instance.new("TextLabel")
Icon.Name = "Icon"
Icon.LayoutOrder = 1
Icon.Size = UDim2.new(1, 0, 0, 65)
Icon.BackgroundTransparency = 1
Icon.Text = "🔧"
Icon.TextSize = 48
Icon.Font = Enum.Font.GothamBold
Icon.TextColor3 = CONFIG.Text
Icon.Parent = Content

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.LayoutOrder = 2
Title.Size = UDim2.new(1, 0, 0, 42)
Title.BackgroundTransparency = 1
Title.Text = CONFIG.TitleTH
Title.TextSize = 25
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = CONFIG.Text
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Content

--==================================================
-- ENGLISH TITLE
--==================================================

local EnglishTitle = Instance.new("TextLabel")
EnglishTitle.LayoutOrder = 3
EnglishTitle.Size = UDim2.new(1, 0, 0, 28)
EnglishTitle.BackgroundTransparency = 1
EnglishTitle.Text = CONFIG.TitleEN
EnglishTitle.TextSize = 16
EnglishTitle.Font = Enum.Font.GothamMedium
EnglishTitle.TextColor3 = CONFIG.SubText
EnglishTitle.TextXAlignment = Enum.TextXAlignment.Center
EnglishTitle.Parent = Content

--==================================================
-- DESCRIPTION
--==================================================

local Description = Instance.new("TextLabel")
Description.Name = "Description"
Description.LayoutOrder = 4
Description.Size = UDim2.new(1, 0, 0, 48)
Description.BackgroundTransparency = 1
Description.Text = CONFIG.DescriptionTH .. "\n" .. CONFIG.DescriptionEN
Description.TextSize = 14
Description.Font = Enum.Font.Gotham
Description.TextColor3 = CONFIG.SubText
Description.TextWrapped = true
Description.TextXAlignment = Enum.TextXAlignment.Center
Description.Parent = Content

--==================================================
-- STATUS
--==================================================

local Status = Instance.new("Frame")
Status.Name = "Status"
Status.LayoutOrder = 5
Status.Size = UDim2.new(0.82, 0, 0, 52)
Status.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Status.BorderSizePixel = 0
Status.Parent = Content

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 12)
StatusCorner.Parent = Status

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(10, 10)
StatusDot.Position = UDim2.new(0, 15, 0.5, -5)
StatusDot.BackgroundColor3 = Color3.fromRGB(255, 190, 70)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Status

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -45, 1, 0)
StatusText.Position = UDim2.new(0, 35, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = CONFIG.StatusTH .. "\n" .. CONFIG.StatusEN
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextColor3 = CONFIG.Text
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = Status

--==================================================
-- FOLLOW LABEL
--==================================================

local FollowLabel = Instance.new("TextLabel")
FollowLabel.LayoutOrder = 6
FollowLabel.Size = UDim2.new(1, 0, 0, 32)
FollowLabel.BackgroundTransparency = 1
FollowLabel.Text = "ติดตามความคืบหน้า / Follow the progress"
FollowLabel.TextSize = 13
FollowLabel.Font = Enum.Font.GothamMedium
FollowLabel.TextColor3 = CONFIG.SubText
FollowLabel.TextXAlignment = Enum.TextXAlignment.Center
FollowLabel.Parent = Content

--==================================================
-- BUTTON HOLDER
--==================================================

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Name = "Buttons"
ButtonHolder.LayoutOrder = 7
ButtonHolder.Size = UDim2.new(1, 0, 0, 52)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = Content

local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ButtonLayout.Padding = UDim.new(0, 10)
ButtonLayout.Parent = ButtonHolder

--==================================================
-- BUTTON CREATOR
--==================================================

local function CreateButton(Name, Text, IconText, Color)
	local Button = Instance.new("TextButton")
	Button.Name = Name
	Button.Size = UDim2.new(0.45, 0, 1, 0)
	Button.BackgroundColor3 = Color
	Button.BorderSizePixel = 0
	Button.AutoButtonColor = false
	Button.Text = ""
	Button.Parent = ButtonHolder

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 12)
	Corner.Parent = Button

	local ButtonText = Instance.new("TextLabel")
	ButtonText.Size = UDim2.fromScale(1, 1)
	ButtonText.BackgroundTransparency = 1
	ButtonText.Text = IconText .. "  " .. Text
	ButtonText.TextSize = 13
	ButtonText.Font = Enum.Font.GothamBold
	ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonText.Parent = Button

	-- Hover / Touch animation
	Button.MouseEnter:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				Size = UDim2.new(0.47, 0, 1.05, 0)
			}
		):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				Size = UDim2.new(0.45, 0, 1, 0)
			}
		):Play()
	end)

	Button.MouseButton1Down:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.08),
			{
				BackgroundTransparency = 0.2
			}
		):Play()
	end)

	Button.MouseButton1Up:Connect(function()
		TweenService:Create(
			Button,
			TweenInfo.new(0.08),
			{
				BackgroundTransparency = 0
			}
		):Play()
	end)

	return Button
end

--==================================================
-- SOCIAL BUTTONS
--==================================================

local DiscordButton = CreateButton(
	"DiscordButton",
	"Discord",
	"💬",
	Color3.fromRGB(75, 70, 150)
)

local TikTokButton = CreateButton(
	"TikTokButton",
	"TikTok",
	"♪",
	Color3.fromRGB(30, 30, 35)
)

--==================================================
-- SOCIAL LINKS
--==================================================

DiscordButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(CONFIG.DiscordURL)
	end
end)

TikTokButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(CONFIG.TikTokURL)
	end
end)

--==================================================
-- CLOSE BUTTON
--==================================================

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.AnchorPoint = Vector2.new(0.5, 1)
CloseButton.Position = UDim2.new(0.5, 0, 1, -12)
CloseButton.Size = UDim2.fromOffset(90, 28)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "Close  ✕"
CloseButton.TextSize = 12
CloseButton.Font = Enum.Font.GothamMedium
CloseButton.TextColor3 = CONFIG.SubText
CloseButton.Parent = Card

CloseButton.MouseButton1Click:Connect(function()

	TweenService:Create(
		Card,
		TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{
			Size = UDim2.new(0.82, 0, 0, 0),
			BackgroundTransparency = 1
		}
	):Play()

	TweenService:Create(
		Blur,
		TweenInfo.new(0.35),
		{
			Size = 0
		}
	):Play()

	task.wait(0.4)

	ScreenGui:Destroy()
	Blur:Destroy()
end)

--==================================================
-- OPEN ANIMATION
--==================================================

Card.Size = UDim2.new(0.82, 0, 0, 0)
Card.BackgroundTransparency = 1

TweenService:Create(
	Card,
	TweenInfo.new(
		0.55,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = UDim2.new(0.82, 0, 0, 480),
		BackgroundTransparency = 0
	}
):Play()

--==================================================
-- RESPONSIVE MOBILE ADJUSTMENT
--==================================================

local function UpdateResponsive()
	local Camera = workspace.CurrentCamera

	if not Camera then
		return
	end

	local Viewport = Camera.ViewportSize
	local IsMobile = Viewport.X < 700

	if IsMobile then

		Card.Size = UDim2.new(0.9, 0, 0, 480)

		Title.TextSize = 22
		EnglishTitle.TextSize = 14
		Description.TextSize = 13

		Status.Size = UDim2.new(0.95, 0, 0, 52)

	else

		Card.Size = UDim2.new(0.82, 0, 0, 480)

		Title.TextSize = 25
		EnglishTitle.TextSize = 16
		Description.TextSize = 14

		Status.Size = UDim2.new(0.82, 0, 0, 52)
	end
end

UpdateResponsive()

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(
	UpdateResponsive
)

--==================================================
-- END
--==================================================

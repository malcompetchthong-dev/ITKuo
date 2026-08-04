          
---          
          
-- KuoHub Responsive Engine v3          
          
local Responsive = {}          
          
Responsive.BaseResolution = Vector2.new(1920,1080)          
Responsive.Scale = 1          
          
Responsive.Items = {}          
Responsive.Layouts = {}          
Responsive.Scrolls = {}          
          
Responsive.Window = nil          
Responsive.Positions = {}          
Responsive.ThemeObjects = {}          
Responsive.ViewportConnection = nil          
          
          
---          
          
-- Camera          
          
function Responsive:GetViewport()          
          
local Camera = workspace.CurrentCamera          
          
if not Camera then          
return Vector2.new(1920,1080)          
end          
          
return Camera.ViewportSize          
          
end          
          
          
---          
          
-- Scale          
          
function Responsive:GetScale()          
          
local Viewport = self:GetViewport()          
          
local WidthScale =          
Viewport.X / self.BaseResolution.X          
          
local HeightScale =          
Viewport.Y / self.BaseResolution.Y          
          
return math.clamp(          
math.min(WidthScale,HeightScale),          
0.72,          
1.35          
)          
          
end          
          
          
---          
          
-- Font Scale          
          
function Responsive:GetFont(Size)          
          
return math.clamp(          
          
math.floor(Size * self.Scale),          
          
12,          
          
36          
          
)          
          
end          
          
          
---          
          
-- Device Detect          
          
function Responsive:IsMobile()          
          
return self:GetViewport().X < 900          
          
end          
          
function Responsive:IsTablet()          
          
local W = self:GetViewport().X          
          
return W >= 900 and W < 1400          
          
end          
          
function Responsive:IsPC()          
          
return self:GetViewport().X >= 1400          
          
end          
          
-- Auto Register          
          
function Responsive:Register(Object, Data)          
          
if not Object then          
return          
end          
          
Data = Data or {}          
          
for _,v in ipairs(self.Items) do          
if v.Object == Object then          
return          
end          
end          
          
table.insert(self.Items,{          
Object = Object,          
          
Size = Data.Size,          
          
Position = Data.Position,          
          
TextSize = Data.TextSize,          
          
Corner = Data.Corner,          
Radius = Data.Radius,          
          
Stroke = Data.Stroke,          
Thickness = Data.Thickness,          
          
Padding = Data.Padding,          
Left = Data.Left,          
Right = Data.Right,          
Top = Data.Top,          
Bottom = Data.Bottom,          
          
Icon = Data.Icon,          
IconSize = Data.IconSize          
          
})          
          
end          
          
          
---          
          
-- Auto Detect          
          
function Responsive:Auto(Object)          
          
if not Object then          
return Object          
end          
          
local Data = {}          
          
          
---          
          
-- GuiObject          
          
if Object:IsA("GuiObject") then          
          
Data.Size = Object.Size          
Data.Position = Object.Position          
          
end          
          
          
---          
          
-- Text          
          
if Object:IsA("TextLabel")          
or Object:IsA("TextButton")          
or Object:IsA("TextBox") then          
          
Data.TextSize = Object.TextSize          
          
end          
          
          
---          
          
-- Image          
          
if Object:IsA("ImageLabel")          
or Object:IsA("ImageButton") then          
          
Data.Icon = Object          
Data.IconSize = Object.Size          
          
end          
          
          
---          
          
-- UICorner          
          
local Corner = Object:FindFirstChildOfClass("UICorner")          
          
if Corner then          
          
Data.Corner = Corner          
Data.Radius = Corner.CornerRadius.Offset          
          
end          
          
          
---          
          
-- UIStroke          
          
local Stroke = Object:FindFirstChildOfClass("UIStroke")          
          
if Stroke then          
          
Data.Stroke = Stroke          
Data.Thickness = Stroke.Thickness          
          
end          
          
          
---          
          
-- UIPadding          
          
local Padding = Object:FindFirstChildOfClass("UIPadding")          
          
if Padding then          
          
Data.Padding = Padding          
          
Data.Left = Padding.PaddingLeft.Offset          
Data.Right = Padding.PaddingRight.Offset          
Data.Top = Padding.PaddingTop.Offset          
Data.Bottom = Padding.PaddingBottom.Offset          
          
end          
          
self:Register(Object,Data)          
          
return Object          
          
end          
          
          
---          
          
-- Remove          
          
function Responsive:Remove(Object)          
          
for i = #self.Layouts,1,-1 do          
if self.Layouts[i].Layout == Object then          
table.remove(self.Layouts,i)          
end          
end          
          
for i = #self.Scrolls,1,-1 do          
if self.Scrolls[i].Object == Object then          
table.remove(self.Scrolls,i)          
end          
end          
          
for i = #self.Positions,1,-1 do          
if self.Positions[i].Object == Object then          
table.remove(self.Positions,i)          
end          
end          
          
for i = #self.ThemeObjects,1,-1 do          
if self.ThemeObjects[i].Object == Object then          
table.remove(self.ThemeObjects,i)          
end          
end          
          
for i,v in ipairs(self.Items) do          
          
if v.Object == Object then          
          
table.remove(self.Items,i)          
          
break          
          
end          
          
end          
          
end          
          
          
---          
          
-- Clear          
          
function Responsive:Clear()          
          
table.clear(self.Items)          
table.clear(self.Layouts)          
table.clear(self.Scrolls)          
table.clear(self.Positions)          
table.clear(self.ThemeObjects)          
          
if self.ViewportConnection then          
self.ViewportConnection:Disconnect()          
self.ViewportConnection = nil          
end          
          
self.Window = nil          
self.Scale = 1          
          
end          
          
-- Update Engine          
          
function Responsive:Update()          
          
self.Scale = self:GetScale()          
          
for i = #self.Items,1,-1 do          
          
local Data = self.Items[i]          
local Object = Data.Object          
          
self:ApplyUIScale(Object)          
          
if not Object or not Object.Parent then          
table.remove(self.Items,i)          
continue          
end          
          
          
---          
          
-- Size          
          
if Data.Size then          
          
Object.Size = UDim2.new(          
          
Data.Size.X.Scale,          
math.floor(Data.Size.X.Offset * self.Scale),          
          
Data.Size.Y.Scale,          
math.floor(Data.Size.Y.Offset * self.Scale)          
          
)          
          
end          
          
          
---          
          
-- Position          
          
if Data.Position then          
          
Object.Position = UDim2.new(          
          
Data.Position.X.Scale,          
math.floor(Data.Position.X.Offset * self.Scale),          
          
Data.Position.Y.Scale,          
math.floor(Data.Position.Y.Offset * self.Scale)          
          
)          
          
end          
          
          
---          
          
-- Text          
          
if Data.TextSize and Object:IsA("GuiObject") then          
          
Object.TextSize = self:GetFont(Data.TextSize)          
          
end          
          
          
---          
          
-- Corner          
          
if Data.Corner then          
          
Data.Corner.CornerRadius = UDim.new(          
0,          
math.floor(Data.Radius * self.Scale)          
)          
          
end          
          
          
---          
          
-- Stroke          
          
if Data.Stroke then          
          
Data.Stroke.Thickness =          
math.max(          
1,          
Data.Thickness * self.Scale          
)          
          
end          
          
          
---          
          
-- Padding          
          
if Data.Padding then          
          
Data.Padding.PaddingLeft =          
UDim.new(          
0,          
math.floor(Data.Left * self.Scale)          
)          
          
Data.Padding.PaddingRight =          
UDim.new(          
0,          
math.floor(Data.Right * self.Scale)          
)          
          
Data.Padding.PaddingTop =          
UDim.new(          
0,          
math.floor(Data.Top * self.Scale)          
)          
          
Data.Padding.PaddingBottom =          
UDim.new(          
0,          
math.floor(Data.Bottom * self.Scale)          
)          
          
end          
          
          
---          
          
-- Image          
          
if Data.Icon and Data.IconSize then          
          
Data.Icon.Size = UDim2.new(          
          
Data.IconSize.X.Scale,          
math.floor(Data.IconSize.X.Offset * self.Scale),          
          
Data.IconSize.Y.Scale,          
math.floor(Data.IconSize.Y.Offset * self.Scale)          
          
)          
          
end          
          
end          
          
          
---          
          
-- Update Window          
          
self:UpdateWindow()          
self:UpdateLayouts()          
self:UpdateScrolls()          
self:UpdatePositions()          
          
if self.Window then          
self:ApplySafeArea(self.Window)          
self:KeepInside(self.Window)          
end          
          
self:UpdateTheme()          
          
          
---          
          
-- Auto Refresh          
          
local function ConnectViewport()          
          
if Responsive.ViewportConnection then          
Responsive.ViewportConnection:Disconnect()          
end          
          
local Camera = workspace.CurrentCamera          
          
if Camera then          
Responsive.ViewportConnection =          
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()          
Responsive:Update()          
end)          
end          
          
end          
          
Responsive:Update()          
          
ConnectViewport()          
          
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()          
          
ConnectViewport()          
          
Responsive:Update()          
          
end)          
          
-- Window Responsive          
          
function Responsive:SetWindow(Window)          
          
self.Window = Window          
          
self:UpdateWindow()          
          
end          
          
function Responsive:UpdateWindow()          
          
if not self.Window then          
return          
end          
          
local Viewport = self:GetViewport()          
          
local Width = Viewport.X          
local Height = Viewport.Y          
          
local WindowWidth          
local WindowHeight          
          
          
---          
          
-- Mobile          
          
if Width <= 600 then          
          
WindowWidth = math.floor(Width * 0.92)          
WindowHeight = math.floor(Height * 0.82)          
          
          
---          
          
-- Large Mobile / Tablet          
          
elseif Width <= 1000 then          
          
WindowWidth = math.floor(Width * 0.78)          
WindowHeight = math.floor(Height * 0.78)          
          
          
---          
          
-- Tablet Landscape          
          
elseif Width <= 1500 then          
          
WindowWidth = math.floor(Width * 0.65)          
WindowHeight = math.floor(Height * 0.76)          
          
          
---          
          
-- PC          
          
else          
          
WindowWidth = math.clamp(          
math.floor(Width * 0.45),          
650,          
920          
)          
          
WindowHeight = math.clamp(          
math.floor(Height * 0.72),          
450,          
720          
)          
          
end          
          
self.Window.Size = UDim2.fromOffset(          
WindowWidth,          
WindowHeight          
)          
          
self.Window.Position = UDim2.new(          
0.5,          
-WindowWidth/2,          
0.5,          
-WindowHeight/2          
)          
          
end          
          
-- Layout Engine          
          
function Responsive:RegisterLayout(Layout)          
          
if not Layout then          
return          
end          
          
for _,v in ipairs(self.Layouts) do          
if v.Layout == Layout then          
return          
end          
end          
          
table.insert(self.Layouts,{          
          
Layout = Layout,          
          
Padding = Layout:IsA("UIListLayout")          
and Layout.Padding          
or nil,          
          
CellPadding = Layout:IsA("UIGridLayout")          
and Layout.CellPadding          
or nil,          
          
CellSize = Layout:IsA("UIGridLayout")          
and Layout.CellSize          
or nil          
          
})          
          
end          
          
function Responsive:UpdateLayouts()          
          
local Scale = self.Scale          
          
for i = #self.Layouts,1,-1 do          
          
local Data = self.Layouts[i]          
local Layout = Data.Layout          
          
if not Layout or not Layout.Parent then          
table.remove(self.Layouts,i)          
continue          
end          
          
          
---          
          
-- UIListLayout          
          
if Layout:IsA("UIListLayout") then          
          
Layout.Padding = UDim.new(          
0,          
math.floor(Data.Padding.Offset * Scale)          
)          
          
end          
          
          
---          
          
-- UIGridLayout          
          
if Layout:IsA("UIGridLayout") then          
          
Layout.CellPadding = UDim2.new(          
          
Data.CellPadding.X.Scale,          
math.floor(Data.CellPadding.X.Offset * Scale),          
          
Data.CellPadding.Y.Scale,          
math.floor(Data.CellPadding.Y.Offset * Scale)          
          
)          
          
Layout.CellSize = UDim2.new(          
          
Data.CellSize.X.Scale,          
math.floor(Data.CellSize.X.Offset * Scale),          
          
Data.CellSize.Y.Scale,          
math.floor(Data.CellSize.Y.Offset * Scale)          
          
)          
          
end          
          
end          
          
end          
          
-- Scroll Engine          
          
function Responsive:RegisterScroll(Scroll)          
          
if not Scroll then          
return          
end          
          
for _,v in ipairs(self.Scrolls) do          
if v.Object == Scroll then          
return          
end          
end          
          
table.insert(self.Scrolls,{          
Object = Scroll,          
LastCanvas = 0          
})          
          
end          
          
function Responsive:UpdateScrolls()          
          
for i = #self.Scrolls,1,-1 do          
          
local Data = self.Scrolls[i]          
local Scroll = Data.Object          
          
if not Scroll or not Scroll.Parent then          
table.remove(self.Scrolls,i)          
continue          
end          
          
local Layout =          
Scroll:FindFirstChildOfClass("UIListLayout")          
or Scroll:FindFirstChildOfClass("UIGridLayout")          
          
if Layout then          
          
local Height          
          
if Layout:IsA("UIGridLayout") then          
          
Height =          
Layout.AbsoluteContentSize.Y +          
Layout.CellPadding.Y.Offset          
          
else          
          
Height =          
Layout.AbsoluteContentSize.Y +          
Layout.Padding.Offset          
          
end          
          
if Height ~= Data.LastCanvas then          
          
Data.LastCanvas = Height          
          
Scroll.CanvasSize = UDim2.new(          
0,          
0,          
0,          
Height + 8          
)          
          
end          
          
end          
          
end          
          
end          
          
-- Auto Register Engine          
          
function Responsive:Scan(Object)          
          
if not Object then          
return          
end          
          
-- Register Object          
          
Object.AnchorPoint = Vector2.new(0.5,0.5)          
          
Object.Position = UDim2.new(          
    0.5,          
    0,          
    0.5,          
    0          
)          
          
self:RegisterPosition(Object)          
self:RefreshPosition(Object)          
          
if Object:IsA("GuiObject") then          
self:RegisterPosition(Object)          
end          
          
if Object:IsA("Frame") then          
self:RegisterTheme(Object,"Background")          
          
elseif Object:IsA("TextButton") then          
self:RegisterTheme(Object,"Button")          
          
elseif Object:IsA("TextLabel") then          
self:RegisterTheme(Object,"Text")          
end          
          
          
---          
          
-- Auto Detect Layout          
          
if Object:IsA("UIListLayout")          
or Object:IsA("UIGridLayout") then          
          
self:RegisterLayout(Object)          
          
end          
          
          
---          
          
-- Auto Detect Scroll          
          
if Object:IsA("ScrollingFrame") then          
          
self:RegisterScroll(Object)          
          
end          
          
          
---          
          
-- Scan Children          
          
for _,Child in ipairs(Object:GetChildren()) do          
          
self:Scan(Child)          
          
end          
          
end          
          
          
---          
          
-- Register Window          
          
function Responsive:RegisterWindow(Window)          
          
if not Window then          
return          
end          
          
self.Window = Window          
          
          
---          
          
-- Scan Existing UI          
          
self:Scan(Window)          
          
self:SetWindow(Window)          
          
self:Update()          
          
          
---          
          
-- Auto Register New UI          
          
Window.DescendantAdded:Connect(function(Object)          
          
task.defer(function()          
          
self:Auto(Object)          
self:ApplyUIScale(Object)          
          
if Object:IsA("GuiObject") then          
self:RegisterPosition(Object)          
self:RefreshPosition(Object)          
end          
          
if Object:IsA("Frame") then          
self:RegisterTheme(Object,"Background")          
          
elseif Object:IsA("TextButton") then          
self:RegisterTheme(Object,"Button")          
          
elseif Object:IsA("TextLabel") then          
self:RegisterTheme(Object,"Text")          
end          
          
if Object:IsA("UIListLayout")          
or Object:IsA("UIGridLayout") then          
          
self:RegisterLayout(Object)          
          
end          
          
if Object:IsA("ScrollingFrame") then          
          
self:RegisterScroll(Object)          
          
end          
          
end)          
          
end)          
          
          
---          
          
-- Auto Remove Destroyed UI          
          
Window.DescendantRemoving:Connect(function(Object)          
          
self:Remove(Object)          
          
end)          
          
end          
          
          
---          
          
-- Register Position          
          
function Responsive:RegisterPosition(Object)          
          
if not Object then          
return          
end          
          
for _,v in ipairs(self.Positions) do          
if v.Object == Object then          
return          
end          
end          
          
table.insert(self.Positions,{          
Object = Object,          
Position = Object.Position,          
Anchor = Object.AnchorPoint          
})          
          
end          
          
function Responsive:RefreshPosition(Object)          
          
for _,Data in ipairs(self.Positions) do          
if Data.Object == Object then          
Data.Position = Object.Position          
return          
end          
end          
          
end          
          
          
---          
          
-- Auto Anchor          
          
function Responsive:AutoAnchor(Object)          
          
if not Object then          
return          
end          
          
Object.AnchorPoint =          
Vector2.new(          
0.5,          
0.5          
)          
          
Object.Position =          
UDim2.new(          
0.5,          
0,          
0.5,          
0          
)          
          
self:RegisterPosition(Object)          
          
end          
          
          
---          
          
-- Update Position          
          
function Responsive:UpdatePositions()          
          
local Viewport =          
self:GetViewport()          
          
for _,Data in ipairs(self.Positions) do          
          
local Object = Data.Object          
          
if Object          
and Object.Parent then          
          
local X =          
Viewport.X / self.BaseResolution.X          
          
local Y =          
Viewport.Y / self.BaseResolution.Y          
          
Object.Position =          
UDim2.new(          
          
Data.Position.X.Scale,          
          
Data.Position.X.Offset * X,          
          
Data.Position.Y.Scale,          
          
Data.Position.Y.Offset * Y          
          
)          
          
end          
          
end          
          
end          
          
function Responsive:GetSafePadding()          
          
local View = self:GetViewport()          
          
if View.Y > View.X then          
return 8          
end          
          
return 0          
          
end          
          
-- Safe Area          
          
function Responsive:ApplySafeArea(Object)          
          
if not Object then            
    return            
end            
          
local Padding = self:GetSafePadding()            
          
if not Object:GetAttribute("OriginalY") then            
    Object:SetAttribute("OriginalY",Object.Position.Y.Offset)            
end            
          
local OriginalY = Object:GetAttribute("OriginalY")            
          
Object.Position = UDim2.new(            
    Object.Position.X.Scale,            
    Object.Position.X.Offset,            
    Object.Position.Y.Scale,            
    OriginalY + Padding            
)          
          
end          
          
-- Orientation          
          
function Responsive:IsLandscape()          
          
local View =          
self:GetViewport()          
          
return View.X > View.Y          
          
end          
          
function Responsive:IsPortrait()          
          
return not self:IsLandscape()          
          
end          
          
-- Auto Clamp          
          
function Responsive:KeepInside(Object)          
          
if not Object then          
return          
end          
          
local View =          
self:GetViewport()          
          
local Size =          
Object.AbsoluteSize          
          
local Pos =          
Object.AbsolutePosition          
          
local X =          
math.clamp(          
Pos.X,          
0,          
View.X - Size.X          
)          
          
local Y =          
math.clamp(          
Pos.Y,          
0,          
View.Y - Size.Y          
)          
          
Object.Position = UDim2.new(          
Object.Position.X.Scale,          
X,          
Object.Position.Y.Scale,          
Y          
)          
          
end          
          
-- Responsive Theme Engine          
          
Responsive.Theme = {          
          
Background = Color3.fromRGB(          
25,          
25,          
25          
),          
          
Button = Color3.fromRGB(          
35,          
35,          
35          
),          
          
Text = Color3.fromRGB(          
240,          
240,          
240          
)          
          
}          
          
-- Register Theme          
          
function Responsive:RegisterTheme(Object,Type)          
          
if not Object then          
return          
end          
          
for _,v in ipairs(self.ThemeObjects) do          
if v.Object == Object then          
return          
end          
end          
          
table.insert(self.ThemeObjects,{          
Object = Object,          
Type = Type          
})          
          
end          
          
-- Performance Mode          
          
function Responsive:GetPerformance()          
          
if self:IsMobile() then          
          
return {          
          
Animation = 0.12,          
          
Transparency = 0.05,          
          
Blur = false          
          
}          
          
elseif self:IsTablet() then          
          
return {          
          
Animation = 0.18,          
          
Transparency = 0.1,          
          
Blur = true          
          
}          
          
else          
          
return {          
          
Animation = 0.25,          
          
Transparency = 0.15,          
          
Blur = true          
          
}          
          
end          
          
end          
          
-- Update Theme          
          
function Responsive:UpdateTheme()          
          
local Mode =          
self:GetPerformance()          
          
for _,Data in ipairs(self.ThemeObjects) do          
          
local Object =          
Data.Object          
          
if Object          
and Object.Parent then          
          
if Data.Type == "Background" then          
          
Object.BackgroundColor3 =          
self.Theme.Background          
          
elseif Data.Type == "Button" then          
          
Object.BackgroundColor3 =          
self.Theme.Button          
          
elseif Data.Type == "Text" then          
          
Object.TextColor3 =          
self.Theme.Text          
          
end          
          
if Object:IsA("Frame")          
or Object:IsA("TextButton")          
or Object:IsA("ImageButton") then          
          
Object.BackgroundTransparency =          
Mode.Transparency          
          
end          
          
end          
          
end          
          
end          
          
-- Tween Info          
          
function Responsive:GetTweenInfo(Style,Direction)          
          
local Speed          
          
if self:IsMobile() then          
          
Speed = 0.12          
          
elseif self:IsTablet() then          
          
Speed = 0.18          
          
else          
          
Speed = 0.25          
          
end          
          
return TweenInfo.new(          
          
Speed,          
          
Style or Enum.EasingStyle.Quad,          
          
Direction or Enum.EasingDirection.Out          
          
)          
          
end          
          
-- Tween          
          
function Responsive:Tween(Object, Properties, Style, Direction)          
          
if not Object then          
return          
end          
          
local Tween = game:GetService("TweenService"):Create(          
          
Object,          
          
self:GetTweenInfo(          
Style,          
Direction          
),          
          
Properties          
          
)          
          
Tween:Play()          
          
return Tween          
          
end          
function Responsive:TweenSize(Object, Size)          
          
return self:Tween(          
Object,          
{          
Size = Size          
}          
)          
          
end          
function Responsive:TweenPosition(Object, Position)          
          
return self:Tween(          
Object,          
{          
Position = Position          
}          
)          
          
end          
function Responsive:TweenTransparency(Object, Value)          
          
if Object:IsA("GuiObject") then          
          
return self:Tween(          
          
Object,          
          
{          
BackgroundTransparency = Value          
}          
          
)          
          
end          
          
end          
function Responsive:TweenRotation(Object, Rotation)          
          
return self:Tween(          
          
Object,          
          
{          
Rotation = Rotation          
}          
          
)          
          
end          
function Responsive:TweenColor(Object, Color)          
          
if Object:IsA("GuiObject") then          
          
return self:Tween(          
          
Object,          
          
{          
BackgroundColor3 = Color          
}          
          
)          
          
end          
          
end          
          
-- Pulse          
          
function Responsive:Pulse(Button)          
          
if not Button then          
return          
end          
          
local Base = Button.Size          
          
self:Tween(          
          
Button,          
          
{          
Size = Base + UDim2.fromOffset(4,4)          
}          
          
).Completed:Wait()          
          
self:Tween(          
          
Button,          
          
{          
Size = Base          
}          
          
)          
          
end          
function Responsive:FadeIn(Frame)          
          
Frame.BackgroundTransparency = 1          
          
self:Tween(          
          
Frame,          
          
{          
BackgroundTransparency = 0          
}          
          
)          
          
end          
function Responsive:FadeOut(Frame)          
          
self:Tween(          
          
Frame,          
          
{          
BackgroundTransparency = 1          
}          
          
)          
          
end          
function Responsive:ApplyUIScale(Object)          
          
if not Object or not Object:IsA("GuiObject") then          
return          
end          
          
local Scale = Object:FindFirstChildOfClass("UIScale")          
          
if not Scale then          
Scale = Instance.new("UIScale")          
Scale.Parent = Object          
end          
          
Scale.Scale = self.Scale          
          
end          

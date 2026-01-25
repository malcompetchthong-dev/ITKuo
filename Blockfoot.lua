--// Kuo Hub | Rainbow Glow UI Full v2.4 (Border Rainbow, Tabs Normal, Window Minimize)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ScreenGui              
                                        local gui = Instance.new("ScreenGui")              
                                        gui.Name = "KuoHub"              
                                        gui.ResetOnSpawn = false              
                                        gui.Parent = player:WaitForChild("PlayerGui")              
      
                                        -- Auto Detect Device              
                                        local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled              
      
                                        -- Rainbow 7 Colors              
                                        local rainbowColors = {              
                                        Color3.fromRGB(255, 0, 0),              
                                        Color3.fromRGB(255, 127, 0),              
                                        Color3.fromRGB(255, 255, 0),              
                                        Color3.fromRGB(0, 255, 0),              
                                        Color3.fromRGB(0, 0, 255),              
                                        Color3.fromRGB(75, 0, 130),              
                                        Color3.fromRGB(148, 0, 211)              
                                        }              
      
                                        -- Function: Tween UIStroke Color (for Borders only)              
                                        local function tweenStrokeColor(stroke)              
                                        task.spawn(function()              
                                        local i = 1              
                                        while true do              
                                        if stroke then              
                                        TweenService:Create(stroke, TweenInfo.new(1), {Color = rainbowColors[i]}):Play()              
                                        end              
                                        i = i + 1              
                                        if i > #rainbowColors then i = 1 end              
                                        task.wait(1)              
                                        end              
                                        end)              
                                        end              
      
                                        -- Main Frame              
                                        local main = Instance.new("Frame", gui)              
                                        main.Size = UDim2.new(0,620,0,380)              
                                        main.Position = UDim2.new(0.5,-310,0.5,-190)              
                                        main.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        main.BorderSizePixel = 0              
                                        main.Active = true              
                                        main.Draggable = true              
                                        local uiScale = Instance.new("UIScale", main)              
                                        uiScale.Scale = isMobile and 0.9 or 1              
                                        local mainCorner = Instance.new("UICorner", main)              
                                        mainCorner.CornerRadius = UDim.new(0,15)              
      
                                        -- Main Border Stroke (Rainbow)              
                                        local mainStroke = Instance.new("UIStroke", main)              
                                        mainStroke.Thickness = 5              
                                        tweenStrokeColor(mainStroke)              
      
                                        -- Title              
                                        local title = Instance.new("TextLabel", main)              
                                        title.Size = UDim2.new(1,0,0,40)              
                                        title.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        title.Text = "Kuo Hub v2.4"              
                                        title.TextColor3 = Color3.fromRGB(255,255,255)              
                                        title.Font = Enum.Font.GothamBold              
                                        title.TextSize = 16              
                                        local titleCorner = Instance.new("UICorner", title)              
                                        titleCorner.CornerRadius = UDim.new(0,15)              
      
                                        -- Sidebar              
                                        local SIDEBAR_WIDTH = isMobile and 140 or 160              
                                        local sidebar = Instance.new("Frame", main)              
                                        sidebar.Position = UDim2.new(0,0,0,40)              
                                        sidebar.Size = UDim2.new(0,SIDEBAR_WIDTH,1,-40)              
                                        sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        sidebar.BorderSizePixel = 0              
                                        local sidebarCorner = Instance.new("UICorner", sidebar)              
                                        sidebarCorner.CornerRadius = UDim.new(0,15)              
                                        local sideLayout = Instance.new("UIListLayout", sidebar)              
                                        sideLayout.Padding = UDim.new(0,6)              
                                        sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center              
                                        local sidePadding = Instance.new("UIPadding", sidebar)              
                                        sidePadding.PaddingTop = UDim.new(0,6)              
      
                                        -- Sidebar Border Stroke (Rainbow)              
                                        local sideStroke = Instance.new("UIStroke", sidebar)              
                                        sideStroke.Thickness = 4              
                                        tweenStrokeColor(sideStroke)              
      
                                        -- Content              
                                        local content = Instance.new("Frame", main)              
                                        content.Position = UDim2.new(0,SIDEBAR_WIDTH,0,40)              
                                        content.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-40)              
                                        content.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        content.BorderSizePixel = 0              
                                        local contentCorner = Instance.new("UICorner", content)              
                                        contentCorner.CornerRadius = UDim.new(0,15)              
      
                                        -- Content Border Stroke (Rainbow)              
                                        local contentStroke = Instance.new("UIStroke", content)              
                                        contentStroke.Thickness = 4              
                                        tweenStrokeColor(contentStroke)              
      
                                        -- Tab System              
                                        local CurrentTab = nil              
                                        local Tabs = {}              
      
                                        local function applyButtonStroke(btn)              
                                        local stroke = Instance.new("UIStroke", btn)              
                                        stroke.Thickness = 3              
                                        stroke.Color = Color3.fromRGB(0,140,255) -- Fixed color for buttons (not rainbow)              
                                        end              
      
                                        local function CreateTab(name)              
                                        local btn = Instance.new("TextButton", sidebar)              
                                        btn.Size = UDim2.new(1,-12,0,36)              
                                        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        btn.Text = name              
                                        btn.TextColor3 = Color3.fromRGB(255,255,255)              
                                        btn.Font = Enum.Font.Gotham              
                                        btn.TextSize = 14              
                                        btn.AutoButtonColor = false              
                                        local btnCorner = Instance.new("UICorner", btn)              
                                        btnCorner.CornerRadius = UDim.new(0,8)              
                                        applyButtonStroke(btn)              
      
                                        local page = Instance.new("ScrollingFrame", content)              
                                        page.Size = UDim2.new(1,0,1,0)              
                                        page.CanvasSize = UDim2.new(0,0,0,0)              
                                        page.ScrollBarImageTransparency = 0.6              
                                        page.Visible = false              
                                        page.BackgroundTransparency = 1              
                                        page.BorderSizePixel = 0              
                                        page.AutomaticCanvasSize = Enum.AutomaticSize.Y              
                                        local layout = Instance.new("UIListLayout", page)              
                                        layout.Padding = UDim.new(0,8)              
                                        local padding = Instance.new("UIPadding", page)              
                                        padding.PaddingTop = UDim.new(0,8)              
                                        padding.PaddingLeft = UDim.new(0,8)              
                                        padding.PaddingRight = UDim.new(0,8)              
      
                                        btn.MouseButton1Click:Connect(function()              
                                        if CurrentTab then              
                                        CurrentTab.page.Visible = false              
                                        CurrentTab.button.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        end              
                                        page.Visible = true              
                                        btn.BackgroundColor3 = Color3.fromRGB(50,50,50)              
                                        CurrentTab = {page=page, button=btn}              
                                        end)              
                                        if not CurrentTab then              
                                        task.defer(function() btn.MouseButton1Click:Fire() end)              
                                        end              
      
                                        local tabObj = {}              
                                        tabObj.Page = page              
                                        tabObj.Button = btn              
      
                                        function tabObj:AddToggle(text, callback)              
                                        local btn = Instance.new("TextButton", self.Page)              
                                        btn.Size = UDim2.new(1,0,0,38)              
                                        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        btn.Text = text.." : OFF"              
                                        btn.TextColor3 = Color3.fromRGB(255,255,255)              
                                        btn.Font = Enum.Font.Gotham              
                                        btn.TextSize = 14              
                                        btn.AutoButtonColor = false              
                                        local c = Instance.new("UICorner", btn)              
                                        c.CornerRadius = UDim.new(0,8)              
                                        applyButtonStroke(btn)              
      
                                        local state = false              
                                        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,50,50) end)              
                                        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = state and Color3.fromRGB(70,220,120) or Color3.fromRGB(25,25,25) end)              
                                        btn.MouseButton1Click:Connect(function()              
                                        state = not state              
                                        btn.Text = text..(state and " : ON" or " : OFF")              
                                        local targetColor = state and Color3.fromRGB(70,220,120) or Color3.fromRGB(25,25,25)              
                                        TweenService:Create(btn,TweenInfo.new(0.3),{BackgroundColor3=targetColor}):Play()              
                                        callback(state)              
                                        end)              
      
                                        end              
      
                                        Tabs[name] = tabObj              
                                        return tabObj              
      
                                        end              
      
                                        -- Window:AddMinimizeButton (กลับมา)              
                                        function Window_AddMinimizeButton(config)              
                                        local btnConfig = config.Button or {}              
                                        local cornerConfig = config.Corner or {}              
      
                                        local btn = Instance.new("ImageButton", gui)              
                                        btn.Size = isMobile and UDim2.new(0,60,0,60) or UDim2.new(0,50,0,50)              
                                        btn.Position = UDim2.new(0,20,0.5,-30)              
                                        btn.Image = btnConfig.Image or ""              
                                        btn.BackgroundTransparency = btnConfig.BackgroundTransparency or 0              
                                        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        btn.BorderSizePixel = 0              
                                        btn.Active = true              
                                        btn.Draggable = true              
      
                                        if cornerConfig.CornerRadius then              
                                        local c = Instance.new("UICorner", btn)              
                                        c.CornerRadius = cornerConfig.CornerRadius              
                                        end              
      
                                        local minimized = false              
                                        btn.MouseButton1Click:Connect(function()              
                                        minimized = not minimized              
                                        main.Visible = not minimized              
                                        end)              
      
                                        return btn              
      
                                        end              
      
                                        Window_AddMinimizeButton({              
                                        Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },              
                                        Corner = { CornerRadius = UDim.new(0, 35) }              
                                        })              
      
                                        -- Minimize / Close Buttons (บน Main)              
                                        local minimizeBtn = Instance.new("TextButton", main)              
                                        minimizeBtn.Size = UDim2.new(0,30,0,30)              
                                        minimizeBtn.Position = UDim2.new(1,-70,0,5)              
                                        minimizeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        minimizeBtn.Text = "-"              
                                        minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)              
                                        minimizeBtn.Font = Enum.Font.GothamBold              
                                        minimizeBtn.TextSize = 20              
                                        minimizeBtn.AutoButtonColor = false              
                                        local minCorner = Instance.new("UICorner", minimizeBtn)              
                                        minCorner.CornerRadius = UDim.new(0,5)              
      
                                        local isMinimized = false              
                                        minimizeBtn.MouseButton1Click:Connect(function()              
                                        isMinimized = not isMinimized              
                                        if isMinimized then              
                                        sidebar.Visible = false              
                                        content.Visible = false              
                                        TweenService:Create(main, TweenInfo.new(0.3), {Size=UDim2.new(0,620,0,40)}):Play()              
                                        else              
                                        sidebar.Visible = true              
                                        content.Visible = true              
                                        TweenService:Create(main, TweenInfo.new(0.3), {Size=UDim2.new(0,620,0,380)}):Play()              
                                        end              
                                        end)              
      
                                        local closeBtn = Instance.new("TextButton", main)              
                                        closeBtn.Size = UDim2.new(0,30,0,30)              
                                        closeBtn.Position = UDim2.new(1,-35,0,5)              
                                        closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)              
                                        closeBtn.Text = "X"              
                                        closeBtn.TextColor3 = Color3.fromRGB(255,255,255)              
                                        closeBtn.Font = Enum.Font.GothamBold              
                                        closeBtn.TextSize = 20              
                                        closeBtn.AutoButtonColor = false              
                                        local closeCorner = Instance.new("UICorner", closeBtn)              
                                        closeCorner.CornerRadius = UDim.new(0,5)              
                                        closeBtn.MouseButton1Click:Connect(function()              
                                        main:Destroy()              
                                        end)              
                                        -- =========================              
                                        -- Player Profile (BOTTOM FIXED)              
                                        -- =========================              
                                        local profile = Instance.new("Frame", sidebar)              
                                        profile.Size = UDim2.new(1,-12,0,70)              
                                        profile.AnchorPoint = Vector2.new(0,1)              
                                        profile.Position = UDim2.new(0,6,1,-6)              
                                        profile.BackgroundColor3 = Color3.fromRGB(20,20,20)              
                                        profile.BorderSizePixel = 0              
                                        profile.ZIndex = 10              
                                        Instance.new("UICorner", profile).CornerRadius = UDim.new(0,10)              
      
                                        -- Avatar (Circle)              
                                        local avatar = Instance.new("ImageLabel", profile)              
                                        avatar.Size = UDim2.new(0,48,0,48)              
                                        avatar.Position = UDim2.new(0,8,0.5,-24)              
                                        avatar.BackgroundTransparency = 1              
                                        avatar.ScaleType = Enum.ScaleType.Crop              
                                        avatar.ZIndex = 11              
                                        avatar.Image = Players:GetUserThumbnailAsync(              
                                        player.UserId,              
                                        Enum.ThumbnailType.HeadShot,              
                                        Enum.ThumbnailSize.Size100x100              
                                        )              
                                        Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)              
      
                                        -- DisplayName (TOP)              
                                        local displayName = Instance.new("TextLabel", profile)              
                                        displayName.BackgroundTransparency = 1              
                                        displayName.Position = UDim2.new(0,64,0,6)              
                                        displayName.Size = UDim2.new(1,-72,0,24)              
                                        displayName.Text = player.DisplayName              
                                        displayName.Font = Enum.Font.GothamBold              
                                        displayName.TextSize = 14              
                                        displayName.TextWrapped = true              
                                        displayName.TextXAlignment = Enum.TextXAlignment.Left              
                                        displayName.TextYAlignment = Enum.TextYAlignment.Top              
                                        displayName.TextColor3 = Color3.new(1,1,1)              
                                        displayName.ZIndex = 11              
                                        displayName.AutomaticSize = Enum.AutomaticSize.Y              
      
                                        -- Username (BOTTOM, NOT CUT)              
                                        local username = Instance.new("TextLabel", profile)              
                                        username.BackgroundTransparency = 1              
                                        username.Position = UDim2.new(0,64,0,30)              
                                        username.Size = UDim2.new(1,-72,0,34)              
                                        username.Text = "@"..player.Name              
                                        username.Font = Enum.Font.Gotham              
                                        username.TextSize = 12              
                                        username.TextWrapped = true              
                                        username.TextXAlignment = Enum.TextXAlignment.Left              
                                        username.TextYAlignment = Enum.TextYAlignment.Top              
                                        username.TextColor3 = Color3.fromRGB(180,180,180)              
                                        username.ZIndex = 11              
                                        username.AutomaticSize = Enum.AutomaticSize.Y

local MainTab = CreateTab("🏠 Main")
local FarmTab = CreateTab("🌲 farm")

-- Demo Toggles            
    
                                        MainTab:AddToggle("🔗 Discord", function()            
    
                                        pcall(function() setclipboard("https://discord.gg/Nv3uwZ28QZ") end)            
                                              end)

--// SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// GLOBAL
_G.AutoFarm = false

--// =====================================================
--// BASIC
--// =====================================================
local function Char()
return player.Character or player.CharacterAdded:Wait()
end

local function HRP()
return Char():WaitForChild("HumanoidRootPart")
end

local function Hum()
return Char():WaitForChild("Humanoid")
end

local function Level()
return player.Data.Level.Value
end

--// =====================================================
--// COMBAT PRIORITY
--// =====================================================
local CombatList = {
"Godhuman","Dragon Talon","Electric Claw","Sharkman Karate",
"Death Step","Superhuman","Dragon Breath","Water Kung Fu",
"Electric","Dark Step","Combat"
}

local function EquipCombat()
for _,v in ipairs(CombatList) do
if player.Backpack:FindFirstChild(v) then
Hum():EquipTool(player.Backpack[v])
break
end
end
end

--// =====================================================
--// QUEST TABLE (FULL / NO SHRINK)
--// =====================================================
local QuestTable = {
-- WORLD 1
{1,9,"BanditQuest1",1,"Bandit"},
{10,14,"BanditQuest1",2,"Monkey"},
{15,29,"JungleQuest",1,"Gorilla"},
{30,39,"JungleQuest",2,"Gorilla"},
{40,59,"BuggyQuest1",1,"Pirate"},
{60,74,"BuggyQuest1",2,"Brute"},
{75,89,"DesertQuest",1,"Desert Bandit"},
{90,99,"DesertQuest",2,"Desert Officer"},
{100,119,"SnowQuest",1,"Snow Bandit"},
{120,149,"SnowQuest",2,"Snowman"},
{150,174,"MarinefordQuest",1,"Chief Petty Officer"},
{175,199,"MarinefordQuest",2,"Sky Bandit"},
{200,224,"SkyQuest",1,"Dark Master"},
{225,249,"SkyQuest",2,"Toga Warrior"},
{250,274,"ColosseumQuest",1,"Gladiator"},
{275,299,"ColosseumQuest",2,"Gladiator"},
{300,324,"MagmaQuest",1,"Military Soldier"},
{325,374,"MagmaQuest",2,"Military Spy"},
{375,399,"FishmanQuest",1,"Fishman Warrior"},
{400,449,"FishmanQuest",2,"Fishman Commando"},
{450,474,"SkyExp1Quest",1,"God's Guard"},
{475,524,"SkyExp1Quest",2,"Shanda"},
{525,549,"SkyExp2Quest",1,"Royal Squad"},
{550,624,"SkyExp2Quest",2,"Royal Soldier"},
{625,649,"FountainQuest",1,"Galley Pirate"},
{650,700,"FountainQuest",2,"Galley Captain"},

-- WORLD 2    
{700,724,"Area1Quest",1,"Raider"},    
{725,774,"Area1Quest",2,"Mercenary"},    
{775,799,"Area2Quest",1,"Swan Pirate"},    
{800,874,"Area2Quest",2,"Factory Staff"},    
{875,899,"MarineQuest2",1,"Marine Lieutenant"},    
{900,949,"MarineQuest2",2,"Marine Captain"},    
{950,999,"ZombieQuest",1,"Zombie"},    
{1000,1049,"ZombieQuest",2,"Vampire"},    
{1050,1099,"SnowMountainQuest",1,"Snow Trooper"},    
{1100,1149,"SnowMountainQuest",2,"Winter Warrior"},    
{1150,1199,"IceSideQuest",1,"Lab Subordinate"},    
{1200,1249,"IceSideQuest",2,"Horned Warrior"},    
{1250,1299,"FireSideQuest",1,"Magma Ninja"},    
{1300,1349,"FireSideQuest",2,"Lava Pirate"},    
{1350,1399,"ShipQuest1",1,"Ship Deckhand"},    
{1400,1449,"ShipQuest1",2,"Ship Engineer"},    
{1450,1499,"ShipQuest2",2,"Ship Steward"},    

-- WORLD 3    
{1500,1524,"PiratePortQuest",1,"Pirate Millionaire"},    
{1525,1574,"PiratePortQuest",2,"Pistol Billionaire"},    
{1575,1599,"AmazonQuest",1,"Dragon Crew Warrior"},    
{1600,1624,"AmazonQuest",2,"Dragon Crew Archer"},    
{1625,1649,"AmazonQuest2",1,"Female Islander"},    
{1650,1699,"AmazonQuest2",2,"Giant Islander"},    
{1700,1724,"MarineTreeIsland",1,"Marine Commodore"},    
{1725,1774,"MarineTreeIsland",2,"Marine Rear Admiral"},    
{1775,1799,"DeepForestIsland3",1,"Fishman Raider"},    
{1800,1824,"DeepForestIsland3",2,"Fishman Captain"},    
{1825,1849,"DeepForestIsland",1,"Forest Pirate"},    
{1850,1899,"DeepForestIsland",2,"Mythological Pirate"},    
{1900,1924,"DeepForestIsland2",1,"Jungle Pirate"},    
{1925,1974,"DeepForestIsland2",2,"Musketeer Pirate"},    
{1975,1999,"HauntedQuest1",1,"Reborn Skeleton"},    
{2000,2049,"HauntedQuest1",2,"Living Zombie"},    
{2050,2099,"HauntedQuest2",1,"Demonic Soul"},    
{2100,2149,"HauntedQuest2",2,"Posessed Mummy"},    
{2150,2199,"IceCreamQuest",1,"Ice Cream Chef"},    
{2200,2249,"IceCreamQuest",2,"Ice Cream Commander"},    
{2250,2299,"PeanutQuest",1,"Peanut Scout"},    
{2300,2349,"PeanutQuest",2,"Peanut President"},    
{2350,2399,"CakeQuest1",1,"Cake Guard"},    
{2400,2449,"CakeQuest1",2,"Baking Staff"},    
{2450,2499,"CakeQuest2",1,"Head Baker"},    
{2500,2549,"CakeQuest2",2,"Cake Guard"},    
{2550,2599,"ChocQuest1",1,"Cocoa Warrior"},    
{2600,2649,"ChocQuest1",2,"Chocolate Bar Battler"},    
{2650,2699,"ChocQuest2",1,"Sweet Thief"},    
{2700,2749,"ChocQuest2",2,"Candy Rebel"},    
{2750,2800,"TikiQuest",2,"Isle Champion"},

}

local function GetQuest()
for _,v in pairs(QuestTable) do
if Level() >= v[1] and Level() <= v[2] then
return v
end
end
end

--// =====================================================
--// QUEST + FLY
--// =====================================================
local function HasQuest()
return player.PlayerGui.Main.Quest.Visible
end

local function StartQuest(q)
if HasQuest() then return end
ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q[3], q[4])
end

local function FlyTo(cf)
TweenService:Create(
HRP(),
TweenInfo.new((HRP().Position - cf.Position).Magnitude / 250, Enum.EasingStyle.Linear),
{CFrame = cf}
):Play()
end

--// =====================================================
--// AUTO CLICK
--// =====================================================
task.spawn(function()
while task.wait(0.15) do
if _G.AutoFarm then
VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
task.wait(0.05)
VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end
end
end)

--// =====================================================
--// MAIN FARM LOOP
--// =====================================================
task.spawn(function()
local hakiCD = false

while task.wait() do    
    if not _G.AutoFarm then continue end    

    -- AUTO HAKI (กันรัว)    
    local buso = Char():FindFirstChild("HasBuso")    
    if buso and not buso.Value and not hakiCD then    
        hakiCD = true    
        pcall(function()    
            ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")    
        end)    
        task.delay(1.5, function()    
            hakiCD = false    
        end)    
    end    

    local q = GetQuest()    
    if not q then continue end    

    EquipCombat()    
    StartQuest(q)    

    for _,mob in pairs(workspace.Enemies:GetChildren()) do    
        if mob.Name == q[5]    
        and mob:FindFirstChild("HumanoidRootPart")    
        and mob.Humanoid.Health > 0 then    

            FlyTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,15,0))    

            repeat    
                RunService.Heartbeat:Wait()    
                HRP().CFrame =    
                    mob.HumanoidRootPart.CFrame    
                    * CFrame.new(0,15,0)    
                    * CFrame.Angles(math.rad(-90),0,0)    
            until not _G.AutoFarm or mob.Humanoid.Health <= 0    
        end    
    end    
end

end)

--// =====================================================
--// Kuo Hub TAB
--// =====================================================
FarmTab:AddToggle("⚔ Auto Farm (ALL IN ONE)", function(state)
_G.AutoFarm = state
end)

print("✅ Kuo Hub Auto Farm Loaded | Stable Version")

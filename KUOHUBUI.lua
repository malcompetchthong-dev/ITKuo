-- =========================================================
-- KUO LIB V5 – GRAY EDITION (Redz Style Compatible)
-- Theme Gray + Rainbow Border
-- No _G | Window / Tab Only
-- =========================================================

local Kuolib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Http = game:GetService("HttpService")

local player = Players.LocalPlayer
local isMobile = UIS.TouchEnabled

-- ===================== THEME =====================
Kuolib.Themes = {
    Gray = {
        Background = Color3.fromRGB(32,32,32),
        Container  = Color3.fromRGB(38,38,38),

        Text       = Color3.fromRGB(235,235,235),
        SubText    = Color3.fromRGB(170,170,170),

        Button     = Color3.fromRGB(45,45,45),
        ButtonHover= Color3.fromRGB(55,55,55),

        Stroke     = Color3.fromRGB(60,60,60),

        Accent     = Color3.fromRGB(120,120,120),
        ToggleOn   = Color3.fromRGB(150,150,150),
        ToggleOff  = Color3.fromRGB(70,70,70),

        TabActive  = Color3.fromRGB(50,50,50),
        TabIdle    = Color3.fromRGB(36,36,36),
    }
}

local CurrentTheme = Kuolib.Themes.Gray

function Kuolib:SetTheme(name)
    if Kuolib.Themes[name] then
        CurrentTheme = Kuolib.Themes[name]
    end
end

-- ================= RAINBOW BORDER =================
local rainbow = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(75,0,130),
    Color3.fromRGB(148,0,211)
}

local function RainbowStroke(obj)
    task.spawn(function()
        local i = 1
        while obj.Parent do
            TweenService:Create(obj,TweenInfo.new(1),{
                Color = rainbow[i]
            }):Play()

            i += 1
            if i > #rainbow then i = 1 end
            task.wait(1)
        end
    end)
end

-- ================= NOTIFY =================
function Kuolib:Notify(text)
    local g = Instance.new("ScreenGui", player.PlayerGui)

    local f = Instance.new("Frame", g)
    f.Size = UDim2.new(0,220,0,60)
    f.Position = UDim2.new(1,-230,1,-80)
    f.BackgroundColor3 = CurrentTheme.Container

    Instance.new("UICorner", f)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,0,1,0)
    t.Text = text
    t.TextColor3 = CurrentTheme.Text
    t.BackgroundTransparency = 1

    task.delay(3,function()
        g:Destroy()
    end)
end

-- ================= SAVE CONFIG =================
local function Save(folder,data)
    writefile(folder, Http:JSONEncode(data))
end

local function Load(folder)
    if isfile(folder) then
        return Http:JSONDecode(readfile(folder))
    end
    return {}
end

-- ================= WINDOW =================
function Kuolib:MakeWindow(cfg)

    local gui = Instance.new("ScreenGui", player.PlayerGui)

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,640,0,400)
    main.Position = UDim2.new(0.5,-320,0.5,-200)
    main.BackgroundColor3 = CurrentTheme.Background
    main.Active = true
    main.Draggable = true

    Instance.new("UICorner", main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 3
    RainbowStroke(stroke)

    -- Title
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,0,0,36)
    title.Text = cfg.Title.." - "..(cfg.SubTitle or "")
    title.TextColor3 = CurrentTheme.Text
    title.BackgroundColor3 = CurrentTheme.Container

    -- Sidebar
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0,170,1,-36)
    sidebar.Position = UDim2.new(0,0,0,36)
    sidebar.BackgroundColor3 = CurrentTheme.Container

    Instance.new("UIListLayout", sidebar).Padding = UDim.new(0,6)

    -- Content
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-170,1,-36)
    content.Position = UDim2.new(0,170,0,36)
    content.BackgroundColor3 = CurrentTheme.Background

    -- Minimize
    function Kuolib:AddMinimizeButton(opt)
        local btn = Instance.new("ImageButton", gui)
        btn.Size = isMobile and UDim2.new(0,60,0,60) or UDim2.new(0,50,0,50)
        btn.Image = opt.Button.Image
        btn.Draggable = true

        Instance.new("UICorner", btn).CornerRadius = opt.Corner.CornerRadius

        btn.MouseButton1Click:Connect(function()
            main.Visible = not main.Visible
        end)
    end

    -- ================= TAB =================
    local Tabs = {}

    function Kuolib:MakeTab(d)
        local name = d[1]

        local btn = Instance.new("TextButton", sidebar)
        btn.Text = name
        btn.Size = UDim2.new(1,-10,0,34)
        btn.BackgroundColor3 = CurrentTheme.TabIdle

        Instance.new("UICorner", btn)

        local page = Instance.new("ScrollingFrame", content)
        page.Size = UDim2.new(1,0,1,0)
        page.Visible = false
        page.BackgroundTransparency = 1

        Instance.new("UIListLayout", page).Padding = UDim.new(0,6)

        Tabs[name] = page

        btn.MouseButton1Click:Connect(function()
            for _,v in pairs(Tabs) do
                v.Visible = false
            end
            page.Visible = true
        end)

        local Tab = {}

        -- ============== COMPONENT ==============

        function Tab:AddButton(d)
            local b = Instance.new("TextButton", page)
            b.Text = d[1]
            b.Size = UDim2.new(1,-10,0,34)
            b.BackgroundColor3 = CurrentTheme.Button

            Instance.new("UICorner", b)

            b.MouseButton1Click:Connect(function()
                d[2](true)
            end)
        end

        function Tab:AddToggle(o)
            local v = o.Default or false

            local b = Instance.new("TextButton", page)
            b.Text = o.Name.." : "..tostring(v)
            b.Size = UDim2.new(1,-10,0,34)

            b.MouseButton1Click:Connect(function()
                v = not v
                b.Text = o.Name.." : "..tostring(v)
                o.Callback(v)
            end)
        end

        function Tab:AddSlider(o)
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1,-10,0,40)

            local t = Instance.new("TextLabel", f)
            t.Text = o.Name
            t.Size = UDim2.new(1,0,0,20)

            local box = Instance.new("TextBox", f)
            box.Size = UDim2.new(1,-10,0,20)
            box.Position = UDim2.new(0,5,0,20)
            box.Text = o.Default

            box.FocusLost:Connect(function()
                local n = tonumber(box.Text)
                if n then
                    o.Callback(math.clamp(n,o.Min,o.Max))
                end
            end)
        end

        function Tab:AddDropdown(o)
            local b = Instance.new("TextButton", page)
            b.Text = o.Name.." : "..o.Default
            b.Size = UDim2.new(1,-10,0,34)

            local i = 1
            b.MouseButton1Click:Connect(function()
                i += 1
                if i > #o.Options then i = 1 end

                local v = o.Options[i]
                b.Text = o.Name.." : "..v
                o.Callback(v)
            end)
        end

        function Tab:AddDiscordInvite(d)
            local b = Instance.new("TextButton", page)
            b.Text = "Discord : "..d.Name
            b.Size = UDim2.new(1,-10,0,36)

            b.MouseButton1Click:Connect(function()
                setclipboard(d.Invite)
                Kuolib:Notify("Copied Invite!")
            end)
        end

        return Tab
    end

    -- ================= DIALOG =================
    function Kuolib:Dialog(cfg)
        local f = Instance.new("Frame", gui)
        f.Size = UDim2.new(0,300,0,160)
        f.Position = UDim2.new(0.5,-150,0.5,-80)

        Instance.new("UICorner", f)

        local y = 40
        for _,o in pairs(cfg.Options) do
            local b = Instance.new("TextButton", f)
            b.Text = o[1]
            b.Position = UDim2.new(0,10,0,y)

            b.MouseButton1Click:Connect(function()
                o[2]()
                f:Destroy()
            end)

            y += 35
        end
    end

    return Kuolib
end

return Kuolib

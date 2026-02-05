-- ======================================================
-- KUO LIB V5 FULL VERSION (REDZ STYLE COMPATIBLE)
-- Theme 3 Colors + Rainbow Border Separated
-- No _G | Use Tab / Window Only
-- AddToggle | AddSlider | AddDropdown
-- Save Config | Notification
-- ======================================================

local Kuolib = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local isMobile = UIS.TouchEnabled

-- ================= THEME SYSTEM =================
local Themes = {
    Dark = {
        Main = Color3.fromRGB(30,30,30),
        Text = Color3.fromRGB(255,255,255)
    },
    Darker = {
        Main = Color3.fromRGB(20,20,20),
        Text = Color3.fromRGB(220,220,220)
    },
    Purple = {
        Main = Color3.fromRGB(40,20,60),
        Text = Color3.fromRGB(240,200,255)
    }
}

local CurrentTheme = Themes.Dark

function Kuolib:SetTheme(name)
    if Themes[name] then
        CurrentTheme = Themes[name]
    end
end

-- ============== RAINBOW BORDER ==============
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
        while obj do
            TweenService:Create(obj, TweenInfo.new(1), {
                Color = rainbow[i]
            }):Play()

            i += 1
            if i > #rainbow then i = 1 end
            task.wait(1)
        end
    end)
end

-- ================= WINDOW =================
function Kuolib:MakeWindow(cfg)

    local gui = Instance.new("ScreenGui")
    gui.Name = "KuoHub"
    gui.Parent = player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,620,0,380)
    main.Position = UDim2.new(0.5,-310,0.5,-190)
    main.BackgroundColor3 = CurrentTheme.Main
    main.Active = true
    main.Draggable = true

    Instance.new("UICorner", main)

    local stroke = Instance.new("UIStroke", main)
    stroke.Thickness = 4
    RainbowStroke(stroke)

    -- Title
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,0,0,40)
    title.Text = cfg.Title or "Kuo Hub"
    title.BackgroundColor3 = CurrentTheme.Main
    title.TextColor3 = CurrentTheme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16

    -- Sidebar
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0,160,1,-40)
    sidebar.Position = UDim2.new(0,0,0,40)
    sidebar.BackgroundColor3 = CurrentTheme.Main

    local list = Instance.new("UIListLayout", sidebar)
    list.Padding = UDim.new(0,6)

    -- Content
    local content = Instance.new("Frame", main)
    content.Size = UDim2.new(1,-160,1,-40)
    content.Position = UDim2.new(0,160,0,40)
    content.BackgroundColor3 = CurrentTheme.Main

    -- ============= TAB SYSTEM =============
    local Tabs = {}

    function Kuolib:MakeTab(data)
        local name = data[1]

        local tabBtn = Instance.new("TextButton", sidebar)
        tabBtn.Text = name
        tabBtn.Size = UDim2.new(1,-10,0,35)
        tabBtn.BackgroundColor3 = CurrentTheme.Main
        tabBtn.TextColor3 = CurrentTheme.Text

        local page = Instance.new("ScrollingFrame", content)
        page.Size = UDim2.new(1,0,1,0)
        page.Visible = false
        page.BackgroundTransparency = 1

        local l = Instance.new("UIListLayout", page)
        l.Padding = UDim.new(0,6)

        Tabs[name] = page

        tabBtn.MouseButton1Click:Connect(function()
            for _,v in pairs(Tabs) do
                v.Visible = false
            end
            page.Visible = true
        end)

        local Tab = {}

        function Tab:AddButton(d)
            local b = Instance.new("TextButton", page)
            b.Size = UDim2.new(1,-10,0,35)
            b.Text = d[1]
            b.MouseButton1Click:Connect(function()
                d[2](true)
            end)
        end

        function Tab:AddSection(d)
            local t = Instance.new("TextLabel", page)
            t.Text = d[1]
            t.Size = UDim2.new(1,-10,0,28)
        end

        function Tab:AddParagraph(d)
            local t = Instance.new("TextLabel", page)
            t.Text = d[2]
            t.Size = UDim2.new(1,-10,0,40)
        end

        function Tab:AddDiscordInvite(d)
            local b = Instance.new("TextButton", page)
            b.Text = d.Name.." | Join"
            b.Size = UDim2.new(1,-10,0,35)

            b.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(d.Invite)
                end
            end)
        end

        -- =========================
        -- ADD TOGGLE
        -- =========================
        function Tab:AddToggle(data)
            local name = data[1]
            local callback = data[2]

            local btn = Instance.new("TextButton", page)
            btn.Size = UDim2.new(1,-10,0,35)
            btn.Text = name .. " : OFF"
            btn.BackgroundColor3 = CurrentTheme.Main

            local state = false

            btn.MouseButton1Click:Connect(function()
                state = not state
                btn.Text = name .. (state and " : ON" or " : OFF")

                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and Color3.fromRGB(70,200,120) 
                                        or CurrentTheme.Main
                }):Play()

                callback(state)
            end)
        end

        -- =========================
        -- ADD SLIDER
        -- =========================
        function Tab:AddSlider(data)
            local name = data[1]
            local min = data[2]
            local max = data[3]
            local callback = data[4]

            local frame = Instance.new("Frame", page)
            frame.Size = UDim2.new(1,-10,0,45)

            local label = Instance.new("TextLabel", frame)
            label.Text = name .. " : " .. min
            label.Size = UDim2.new(1,0,0,20)

            local slider = Instance.new("TextButton", frame)
            slider.Size = UDim2.new(1,0,0,20)
            slider.Position = UDim2.new(0,0,0,22)
            slider.Text = ""

            local dragging = false

            slider.MouseButton1Down:Connect(function()
                dragging = true
            end)

            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            UIS.InputChanged:Connect(function()
                if dragging then
                    local pos = UIS:GetMouseLocation().X - slider.AbsolutePosition.X
                    local percent = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)

                    local value = math.floor(min + (max - min) * percent)
                    label.Text = name .. " : " .. value

                    callback(value)
                end
            end)
        end

        -- =========================
        -- ADD DROPDOWN
        -- =========================
        function Tab:AddDropdown(data)
            local name = data[1]
            local list = data[2]
            local callback = data[3]

            local main = Instance.new("TextButton", page)
            main.Size = UDim2.new(1,-10,0,35)
            main.Text = name

            local open = false
            local holder = Instance.new("Frame", page)
            holder.Size = UDim2.new(1,-10,0,0)
            holder.Visible = false

            local layout = Instance.new("UIListLayout", holder)

            for _,v in pairs(list) do
                local b = Instance.new("TextButton", holder)
                b.Size = UDim2.new(1,0,0,30)
                b.Text = v

                b.MouseButton1Click:Connect(function()
                    main.Text = name .. " : " .. v
                    callback(v)
                    holder.Visible = false
                    open = false
                end)
            end

            main.MouseButton1Click:Connect(function()
                open = not open
                holder.Visible = open
                holder.Size = UDim2.new(1,-10,0, #list * 30)
            end)
        end

        return Tab
    end

    -- =========================
    -- SAVE CONFIG
    -- =========================
    local folder = "KuoHubConfigs"

    function Kuolib:SaveConfig(name, data)
        if writefile then
            writefile(folder.."/"..name..".json",
                HttpService:JSONEncode(data))
        end
    end

    function Kuolib:LoadConfig(name)
        if readfile and isfile(folder.."/"..name..".json") then
            return HttpService:JSONDecode(
                readfile(folder.."/"..name..".json"))
        end
    end

    -- =========================
    -- NOTIFICATION
    -- =========================
    function Kuolib:Notify(title, text, time)

        local f = Instance.new("Frame", gui)
        f.Size = UDim2.new(0,260,0,70)
        f.Position = UDim2.new(1,-270,1,-90)

        Instance.new("UICorner", f)

        local t = Instance.new("TextLabel", f)
        t.Size = UDim2.new(1,0,1,0)
        t.Text = title .. "\n" .. text

        task.delay(time or 3, function()
            f:Destroy()
        end)
    end

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

    return Kuolib
end

return Kuolib

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "KUO_UI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,500,0,350)
main.Position = UDim2.new(0.5,-250,0.5,-175)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.Text = "KUO EXECUTOR"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1,0,0,30)
tabBar.Position = UDim2.new(0,0,0,35)
tabBar.BackgroundTransparency = 1
tabBar.Parent = main

local scripts = {}
local currentTab

local editor = Instance.new("TextBox")
editor.Size = UDim2.new(1,-20,0,160)
editor.Position = UDim2.new(0,10,0,70)
editor.Text = "-- script here"
editor.TextXAlignment = Enum.TextXAlignment.Left
editor.TextYAlignment = Enum.TextYAlignment.Top
editor.ClearTextOnFocus = false
editor.Parent = main

local function createTab(name)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,90,0,25)
btn.Text = name
btn.Parent = tabBar

table.insert(scripts,{
    name=name,
    button=btn,
    code=""
})

btn.MouseButton1Click:Connect(function()

    if currentTab then
        currentTab.code = editor.Text
    end

    for _,v in pairs(scripts) do
        if v.button==btn then
            currentTab=v
            editor.Text=v.code
        end
    end

end)

end

createTab("script1")

local addTab = Instance.new("TextButton")
addTab.Size = UDim2.new(0,25,0,25)
addTab.Position = UDim2.new(1,-30,0,35)
addTab.Text = "+"
addTab.Parent = main

addTab.MouseButton1Click:Connect(function()
createTab("script"..#scripts+1)
end)

local console = Instance.new("TextLabel")
console.Size = UDim2.new(1,-20,0,90)
console.Position = UDim2.new(0,10,0,250)
console.BackgroundColor3 = Color3.fromRGB(15,15,15)
console.TextColor3 = Color3.new(0,1,0)
console.TextXAlignment = Enum.TextXAlignment.Left
console.TextYAlignment = Enum.TextYAlignment.Top
console.Text=""
console.Parent = main

local function log(msg)
console.Text = console.Text .. "\n" .. tostring(msg)
end

local KuoLib = {}

function KuoLib.log(msg)
log("[KUO] "..tostring(msg))
end

function KuoLib.warn(msg)
log("[KUO WARNING] "..tostring(msg))
end

function KuoLib.delay(min,max)
min = min or 2
max = max or 5
task.wait(math.random(min,max))
end

function KuoLib.safe(func)

local ok,err = pcall(func)

if not ok then
    KuoLib.warn(err)
end

end

function KuoLib.execute(code)

if not code or code == "" then
    KuoLib.warn("Empty Script")
    return
end

KuoLib.safe(function()

    if run_script then
        run_script(code)
    else
        loadstring(code)()
    end

end)

end

function KuoLib.loop(func)

task.spawn(function()

    while true do

        KuoLib.delay(2,5)

        KuoLib.safe(func)

    end

end)

end

KuoLib.tasks = 0
KuoLib.maxTasks = 50

function KuoLib.task()

KuoLib.tasks += 1

if KuoLib.tasks >= KuoLib.maxTasks then

    KuoLib.log("Reset Task Counter")
    KuoLib.tasks = 0
    task.wait(1)

end

end

local run = Instance.new("TextButton")
run.Size = UDim2.new(0.5,-10,0,35)
run.Position = UDim2.new(0,10,1,-40)
run.Text = "Execute"
run.Parent = main

run.MouseButton1Click:Connect(function()

if currentTab then
    currentTab.code = editor.Text
end

KuoLib.execute(editor.Text)

end)

local clear = Instance.new("TextButton")
clear.Size = UDim2.new(0.5,-10,0,35)
clear.Position = UDim2.new(0.5,0,1,-40)
clear.Text = "Clear"
clear.Parent = main

clear.MouseButton1Click:Connect(function()
editor.Text=""
end)

local toggle = Instance.new("ImageButton")
toggle.Size = UDim2.new(0,70,0,70)
toggle.Position = UDim2.new(0,30,0,120)
toggle.BackgroundTransparency = 1
toggle.Image = "rbxassetid://74658005309613"
toggle.Parent = gui

toggle.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

local dragging=false
local dragInput
local dragStart
local startPos

toggle.InputBegan:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1
or input.UserInputType==Enum.UserInputType.Touch then

    dragging=true
    dragStart=input.Position
    startPos=toggle.Position

    input.Changed:Connect(function()
        if input.UserInputState==Enum.UserInputState.End then
            dragging=false
        end
    end)

end

end)

toggle.InputChanged:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseMovement
or input.UserInputType==Enum.UserInputType.Touch then
    dragInput=input
end

end)

UIS.InputChanged:Connect(function(input)

if input==dragInput and dragging then

    local delta=input.Position-dragStart

    toggle.Position=UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset+delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset+delta.Y
    )

end

end)

KuoLib.log("KUO Executor Loaded")

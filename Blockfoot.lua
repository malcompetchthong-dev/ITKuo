local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})
-- =========================
-- UI
-- =========================
local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

Home:Section("Main")

Home:AddDiscordInvite({
    Name = "Kuo Hub",
    Description = "Join server",
    Logo = "rbxassetid://103308551113442",
    Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title = "Kill Aura",
    Desc = "ฟาร์มเลเวลอัตโมมัส",
    Callback = function(v)
        KILLAURA = v
    end
})

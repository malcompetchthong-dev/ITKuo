--// Kuo Hub | Rainbow Glow UI Full v2.3 Full Menu (Thai/English) with Full Window Controls

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "KuoHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Auto Detect Device
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

-- Rainbow Colors
local rainbowColors = {
    Color3.fromRGB(255,0,0),
	    Color3.fromRGB(255,127,0),
		    Color3.fromRGB(255,255,0),
			    Color3.fromRGB(0,255,0),
				    Color3.fromRGB(0,0,255),
					    Color3.fromRGB(75,0,130),
						    Color3.fromRGB(148,0,211)
							}

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
																																		Instance.new("UICorner", main).CornerRadius = UDim.new(0,15)

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
																																		title.TextYAlignment = Enum.TextYAlignment.Top
																																		title.TextWrapped = true
																																		Instance.new("UICorner", title).CornerRadius = UDim.new(0,15)

																																		-- Sidebar
																																		local SIDEBAR_WIDTH = isMobile and 140 or 160
																																		local sidebar = Instance.new("Frame", main)
																																		sidebar.Position = UDim2.new(0,0,0,40)
																																		sidebar.Size = UDim2.new(0,SIDEBAR_WIDTH,1,-40)
																																		sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
																																		sidebar.BorderSizePixel = 0
																																		Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,15)
																																		local sideLayout = Instance.new("UIListLayout", sidebar)
																																		sideLayout.Padding = UDim.new(0,6)
																																		sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
																																		Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0,6)

																																		local sideStroke = Instance.new("UIStroke", sidebar)
																																		sideStroke.Thickness = 4
																																		tweenStrokeColor(sideStroke)

																																		-- Content
																																		local content = Instance.new("Frame", main)
																																		content.Position = UDim2.new(0,SIDEBAR_WIDTH,0,40)
																																		content.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-40)
																																		content.BackgroundColor3 = Color3.fromRGB(25,25,25)
																																		content.BorderSizePixel = 0
																																		Instance.new("UICorner", content).CornerRadius = UDim.new(0,15)

																																		local contentStroke = Instance.new("UIStroke", content)
																																		contentStroke.Thickness = 4
																																		tweenStrokeColor(contentStroke)

																																		-- Tab System
																																		local CurrentTab = nil
																																		local Tabs = {}

																																		local function applyButtonStroke(btn)
																																		    local stroke = Instance.new("UIStroke", btn)
																																			    stroke.Thickness = 3
																																				    stroke.Color = Color3.fromRGB(0,140,255)
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
																																													    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
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
																																																																																													        btn.Text = text -- ไทยบน/อังกฤษล่าง
																																																																																															        btn.TextColor3 = Color3.fromRGB(255,255,255)
																																																																																																	        btn.Font = Enum.Font.Gotham
																																																																																																			        btn.TextSize = 14
																																																																																																					        btn.AutoButtonColor = false
																																																																																																							        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
																																																																																																									        applyButtonStroke(btn)

																																																																																																											        local state = false
																																																																																																													        btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
																																																																																																															        btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(25,25,25) end)
																																																																																																																	        btn.MouseButton1Click:Connect(function()
																																																																																																																			            state = not state
																																																																																																																						            callback(state)
																																																																																																																									        end)
																																																																																																																											    end

																																																																																																																												    function tabObj:AddSlider(text,min,max,default,callback)
																																																																																																																													        local sliderFrame = Instance.new("Frame", self.Page)
																																																																																																																															        sliderFrame.Size = UDim2.new(1,0,0,38)
																																																																																																																																	        sliderFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
																																																																																																																																			        Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0,8)

																																																																																																																																					        local label = Instance.new("TextLabel", sliderFrame)
																																																																																																																																							        label.Size = UDim2.new(1,-10,1,0)
																																																																																																																																									        label.Position = UDim2.new(0,5,0,0)
																																																																																																																																											        label.BackgroundTransparency = 1
																																																																																																																																													        label.Text = text.." : "..tostring(default)
																																																																																																																																															        label.TextColor3 = Color3.fromRGB(255,255,255)
																																																																																																																																																	        label.Font = Enum.Font.Gotham
																																																																																																																																																			        label.TextSize = 14
																																																																																																																																																					        label.TextXAlignment = Enum.TextXAlignment.Left

																																																																																																																																																							        local slider = Instance.new("TextButton", sliderFrame)
																																																																																																																																																									        slider.Size = UDim2.new(1,0,1,0)
																																																																																																																																																											        slider.BackgroundTransparency = 1
																																																																																																																																																													        slider.AutoButtonColor = false

																																																																																																																																																															        local function updateValue(x)
																																																																																																																																																																	            local size = math.clamp(x / sliderFrame.AbsoluteSize.X,0,1)
																																																																																																																																																																				            local value = math.floor(min + (max-min)*size)
																																																																																																																																																																							            label.Text = text.." : "..tostring(value)
																																																																																																																																																																										            callback(value)
																																																																																																																																																																													        end

																																																																																																																																																																															        slider.MouseButton1Down:Connect(function()
																																																																																																																																																																																	            updateValue(UIS:GetMouseLocation().X - sliderFrame.AbsolutePosition.X)
																																																																																																																																																																																				            local conn
																																																																																																																																																																																							            conn = UIS.InputChanged:Connect(function(input)
																																																																																																																																																																																										                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
																																																																																																																																																																																														                    updateValue(input.Position.X - sliderFrame.AbsolutePosition.X)
																																																																																																																																																																																																			                end
																																																																																																																																																																																																							            end)
																																																																																																																																																																																																										            local upConn
																																																																																																																																																																																																													            upConn = UIS.InputEnded:Connect(function(input)
																																																																																																																																																																																																																                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
																																																																																																																																																																																																																				                    conn:Disconnect()
																																																																																																																																																																																																																									                    upConn:Disconnect()
																																																																																																																																																																																																																														                end
																																																																																																																																																																																																																																		            end)
																																																																																																																																																																																																																																					        end)
																																																																																																																																																																																																																																							    end

																																																																																																																																																																																																																																								    Tabs[name] = tabObj
																																																																																																																																																																																																																																									    return tabObj
																																																																																																																																																																																																																																										end

																																																																																																																																																																																																																																										-- Tabs
																																																																																																																																																																																																																																										local MainTab = CreateTab("🏠 หน้าแรก / Main")
																																																																																																																																																																																																																																										local PlayerTab = CreateTab("👤 ผู้เล่น / Player")
																																																																																																																																																																																																																																										local MiscTab = CreateTab("📦 อื่น ๆ / Misc")

																																																																																																																																																																																																																																										-- Main Tab Toggles
																																																																																																																																																																																																																																										MainTab:AddToggle("🔗 Discord", function()
																																																																																																																																																																																																																																										    pcall(function() setclipboard("https://discord.gg/Nv3uwZ28QZ") end)
																																																																																																																																																																																																																																											end)

																																																																																																																																																																																																																																											-- Player Tab Toggles
																																																																																																																																																																																																																																											local WalkOnAirEnabled = false
																																																																																																																																																																																																																																											local platform, followConnection
																																																																																																																																																																																																																																											local function ToggleWalkOnAir(state)
																																																																																																																																																																																																																																											    WalkOnAirEnabled = state
																																																																																																																																																																																																																																												    if not state then
																																																																																																																																																																																																																																													        if followConnection then followConnection:Disconnect() end
																																																																																																																																																																																																																																															        if platform then platform:Destroy() end
																																																																																																																																																																																																																																																	        return
																																																																																																																																																																																																																																																			    end
																																																																																																																																																																																																																																																				    local char = player.Character or player.CharacterAdded:Wait()
																																																																																																																																																																																																																																																					    local hrp = char:WaitForChild("HumanoidRootPart")
																																																																																																																																																																																																																																																						    platform = Instance.new("Part", workspace)
																																																																																																																																																																																																																																																							    platform.Anchored = true
																																																																																																																																																																																																																																																								    platform.Size = Vector3.new(6,1,6)
																																																																																																																																																																																																																																																									    platform.Transparency = 1
																																																																																																																																																																																																																																																										    followConnection = RunService.RenderStepped:Connect(function()
																																																																																																																																																																																																																																																											        platform.CFrame = hrp.CFrame * CFrame.new(0,-3.2,0)
																																																																																																																																																																																																																																																													    end)
																																																																																																																																																																																																																																																														end

																																																																																																																																																																																																																																																														PlayerTab:AddToggle("✈️ Fly 360", function(state)
																																																																																																																																																																																																																																																														    if state then
																																																																																																																																																																																																																																																															        loadstring(game:HttpGet("https://pastebin.com/raw/WAV2j9rz"))()
																																																																																																																																																																																																																																																																	    end
																																																																																																																																																																																																																																																																		end)
																																																																																																																																																																																																																																																																		PlayerTab:AddToggle("☁️ เดินกลางอากาศ / Walk On Air", ToggleWalkOnAir)
																																																																																																																																																																																																																																																																		PlayerTab:AddSlider("⚡ ความเร็ว / Speed",16,100,16,function(v)
																																																																																																																																																																																																																																																																		    if player.Character and player.Character:FindFirstChild("Humanoid") then
																																																																																																																																																																																																																																																																			        player.Character.Humanoid.WalkSpeed = v
																																																																																																																																																																																																																																																																					    end
																																																																																																																																																																																																																																																																						end)
																																																																																																																																																																																																																																																																						-- Misc Tab Toggles
																																																																																																																																																																																																																																																																						MiscTab:AddToggle("🛡️ โหมดอมตะ / God Mode", function(state)
																																																																																																																																																																																																																																																																						    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
																																																																																																																																																																																																																																																																							    if hum then
																																																																																																																																																																																																																																																																								        hum.MaxHealth = state and math.huge or 100
																																																																																																																																																																																																																																																																										        hum.Health = hum.MaxHealth
																																																																																																																																																																																																																																																																												    end
																																																																																																																																																																																																																																																																													end)
																																																																																																																																																																																																																																																																													MiscTab:AddToggle("🪄 Admin Tools", function(state)
																																																																																																																																																																																																																																																																													    print("Admin Tools Toggled:",state)
																																																																																																																																																																																																																																																																														end)

																																																																																																																																																																																																																																																																														-- =======================
																																																																																																																																																																																																																																																																														-- Window Controls
																																																																																																																																																																																																																																																																														-- =======================
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

																																																																																																																																																																																																																																																																																																							-- Main Open/Close Button
																																																																																																																																																																																																																																																																																																							Window_AddMinimizeButton({
																																																																																																																																																																																																																																																																																																							    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
																																																																																																																																																																																																																																																																																																								    Corner = { CornerRadius = UDim.new(0, 35) }
																																																																																																																																																																																																																																																																																																									})

																																																																																																																																																																																																																																																																																																									-- Minimize (-) Button
																																																																																																																																																																																																																																																																																																									local minimizeBtn = Instance.new("TextButton", main)
																																																																																																																																																																																																																																																																																																									minimizeBtn.Size = UDim2.new(0,30,0,30)
																																																																																																																																																																																																																																																																																																									minimizeBtn.Position = UDim2.new(1,-70,0,5)
																																																																																																																																																																																																																																																																																																									minimizeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
																																																																																																																																																																																																																																																																																																									minimizeBtn.Text = "-"
																																																																																																																																																																																																																																																																																																									minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
																																																																																																																																																																																																																																																																																																									minimizeBtn.Font = Enum.Font.GothamBold
																																																																																																																																																																																																																																																																																																									minimizeBtn.TextSize = 20
																																																																																																																																																																																																																																																																																																									minimizeBtn.AutoButtonColor = false
																																																																																																																																																																																																																																																																																																									Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,5)

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

																																																																																																																																																																																																																																																																																																																									-- Close (X) Button
																																																																																																																																																																																																																																																																																																																									local closeBtn = Instance.new("TextButton", main)
																																																																																																																																																																																																																																																																																																																									closeBtn.Size = UDim2.new(0,30,0,30)
																																																																																																																																																																																																																																																																																																																									closeBtn.Position = UDim2.new(1,-35,0,5)
																																																																																																																																																																																																																																																																																																																									closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
																																																																																																																																																																																																																																																																																																																									closeBtn.Text = "X"
																																																																																																																																																																																																																																																																																																																									closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
																																																																																																																																																																																																																																																																																																																									closeBtn.Font = Enum.Font.GothamBold
																																																																																																																																																																																																																																																																																																																									closeBtn.TextSize = 20
																																																																																																																																																																																																																																																																																																																									closeBtn.AutoButtonColor = false
																																																																																																																																																																																																																																																																																																																									Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,5)
																																																																																																																																																																																																																																																																																																																									closeBtn.MouseButton1Click:Connect(function()
																																																																																																																																																																																																																																																																																																																									    main:Destroy()
																																																																																																																																																																																																																																																																																																																										end)

																																																																																																																																																																																																																																																																																																																										print("✅ Kuo Hub Full Version Loaded")

local correctKey = "edexaltaccistuff"

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0.5,-100,0.5,-60)
frame.BackgroundTransparency = 1

local box = Instance.new("TextBox")
box.Parent = frame
box.Size = UDim2.new(0,180,0,40)
box.Position = UDim2.new(0,10,0,10)
box.PlaceholderText = "Enter Key"

local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0,180,0,40)
button.Position = UDim2.new(0,10,0,60)
button.Text = "Submit"

button.MouseButton1Click:Connect(function()

	if box.Text ~= correctKey then
		box.Text = "Wrong Key"
		return
	end

	gui:Destroy()

	-- Intro Screen
	local intro = Instance.new("ScreenGui")
	intro.Parent = game.CoreGui

	local text = Instance.new("TextLabel")
	text.Parent = intro
	text.Size = UDim2.new(1,0,1,0)
	text.BackgroundTransparency = 1
	text.Text = "edexaltacc / cinaroguzhan"
	text.TextScaled = true
	text.Font = Enum.Font.GothamBold
	text.TextColor3 = Color3.fromRGB(255,255,255)

	task.wait(2)

	intro:Destroy()

	-- Script Start
	local player = game.Players.LocalPlayer
	local char
	local root
	local vim = game:GetService("VirtualInputManager")
	local UIS = game:GetService("UserInputService") -- Service für Dragging hinzugefügt

	local function updateChar(c)
		char = c
		root = char:WaitForChild("HumanoidRootPart")
	end

	updateChar(player.Character or player.CharacterAdded:Wait())
	player.CharacterAdded:Connect(updateChar)

	local mainGui = Instance.new("ScreenGui")
	mainGui.Parent = game.CoreGui
	mainGui.ResetOnSpawn = false

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Parent = mainGui
	mainFrame.Size = UDim2.new(0,145,0,60)
	mainFrame.Position = UDim2.new(0,20,0,100)
	mainFrame.BackgroundTransparency = 1
	mainFrame.Active = true

	-- === Drag Box (Die leere Box zum Verschieben links daneben) ===
	local dragBox = Instance.new("TextButton")
	dragBox.Name = "DragBox"
	dragBox.Parent = mainFrame
	dragBox.Size = UDim2.new(0,35,0,60) -- Volle Höhe des GUIs
	dragBox.Position = UDim2.new(0,0,0,0)
	dragBox.Text = "" -- Leer lassen
	dragBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50) 
	dragBox.BackgroundTransparency = 0.5 -- Halbtransparent, damit man sie sieht

	-- Drag-Funktionalität
	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	dragBox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	dragBox.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	-- =============================================================

	local moveBox1 = Instance.new("TextBox")
	moveBox1.Parent = mainFrame
	moveBox1.Size = UDim2.new(0,35,0,30)
	moveBox1.Position = UDim2.new(0,35,0,0) -- Um 35 nach rechts verschoben wegen DragBox
	moveBox1.Text = "5"

	local glideBtn1 = Instance.new("TextButton")
	glideBtn1.Parent = mainFrame
	glideBtn1.Size = UDim2.new(0,75,0,30)
	glideBtn1.Position = UDim2.new(0,70,0,0) -- Position angepasst
	glideBtn1.Text = "Glide1"

	local moveBox2 = Instance.new("TextBox")
	moveBox2.Parent = mainFrame
	moveBox2.Size = UDim2.new(0,35,0,30)
	moveBox2.Position = UDim2.new(0,35,0,30) -- Um 35 nach rechts verschoben
	moveBox2.Text = "5"

	local glideBtn2 = Instance.new("TextButton")
	glideBtn2.Parent = mainFrame
	glideBtn2.Size = UDim2.new(0,75,0,30)
	glideBtn2.Position = UDim2.new(0,70,0,30) -- Position angepasst
	glideBtn2.Text = "Glide2"

	glideBtn1.MouseButton1Click:Connect(function()
		if root then
			vim:SendKeyEvent(true,"Three",false,game)
			vim:SendKeyEvent(false,"Three",false,game)
			task.wait(0.5)
			local amt = tonumber(moveBox1.Text) or 5
			root.CFrame = root.CFrame * CFrame.new(0,0,-amt)
		end
	end)

	glideBtn2.MouseButton1Click:Connect(function()
		if root then
			local amt = tonumber(moveBox2.Text) or 5
			root.CFrame = root.CFrame * CFrame.new(0,0,amt)
			task.wait(0.2)
			vim:SendKeyEvent(true,"Q",false,game)
			vim:SendKeyEvent(false,"Q",false,game)
		end
	end)
end)

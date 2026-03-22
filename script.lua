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

	-- Intro
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
	local UIS = game:GetService("UserInputService")

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

	-- Drag Box
	local dragBox = Instance.new("TextButton")
	dragBox.Parent = mainFrame
	dragBox.Size = UDim2.new(0,35,0,40)
	dragBox.Position = UDim2.new(0,0,0,0)
	dragBox.Text = ""
	dragBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
	dragBox.BackgroundTransparency = 0.5

	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	dragBox.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- UI
	local moveBox1 = Instance.new("TextBox")
	moveBox1.Parent = mainFrame
	moveBox1.Size = UDim2.new(0,35,0,20)
	moveBox1.Position = UDim2.new(0,35,0,0)
	moveBox1.Text = "5"

	local glideBtn1 = Instance.new("TextButton")
	glideBtn1.Parent = mainFrame
	glideBtn1.Size = UDim2.new(0,75,0,20)
	glideBtn1.Position = UDim2.new(0,70,0,0)
	glideBtn1.Text = "Glide1"

	local moveBox2 = Instance.new("TextBox")
	moveBox2.Parent = mainFrame
	moveBox2.Size = UDim2.new(0,35,0,20)
	moveBox2.Position = UDim2.new(0,35,0,19)
	moveBox2.Text = "5"

	local glideBtn2 = Instance.new("TextButton")
	glideBtn2.Parent = mainFrame
	glideBtn2.Size = UDim2.new(0,75,0,20)
	glideBtn2.Position = UDim2.new(0,70,0,19)
	glideBtn2.Text = "Glide2"

	-- FUNCTIONS
	local function glide1()
		if root then
			vim:SendKeyEvent(true,"Three",false,game)
			vim:SendKeyEvent(false,"Three",false,game)
			task.wait(0.5)
			local amt = tonumber(moveBox1.Text) or 5
			root.CFrame = root.CFrame * CFrame.new(0,0,-amt)
		end
	end

	local function glide2()
		if root then
			local amt = tonumber(moveBox2.Text) or 5
			root.CFrame = root.CFrame * CFrame.new(0,0,amt)
			task.wait(0.2)
			vim:SendKeyEvent(true,"Q",false,game)
			vim:SendKeyEvent(false,"Q",false,game)
		end
	end

	-- BUTTONS
	glideBtn1.MouseButton1Click:Connect(glide1)
	glideBtn2.MouseButton1Click:Connect(glide2)

	-- KEYBINDS (DAS WOLLTEST DU)
	UIS.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end

		if input.KeyCode == Enum.KeyCode.X then
			glide1()
		elseif input.KeyCode == Enum.KeyCode.Z then
			glide2()
		end
	end)

end)

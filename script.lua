local correctKey = "edexaltaccistuff"

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0.5,-100,0.5,-60)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

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

	-- SCRIPT START

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

	local gui = Instance.new("ScreenGui")
	gui.Parent = game.CoreGui
	gui.ResetOnSpawn = false

	local frame = Instance.new("Frame")
	frame.Parent = gui
	frame.Size = UDim2.new(0,120,0,70)
	frame.Position = UDim2.new(0,20,0,100)
	frame.BackgroundTransparency = 0.3
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	frame.Active = true
	frame.Draggable = true

	local moveBox1 = Instance.new("TextBox")
	moveBox1.Parent = frame
	moveBox1.Size = UDim2.new(0,40,0,25)
	moveBox1.Position = UDim2.new(0,0,0,7)
	moveBox1.Text = "5"

	local glideBtn1 = Instance.new("TextButton")
	glideBtn1.Parent = frame
	glideBtn1.Size = UDim2.new(0,70,0,25)
	glideBtn1.Position = UDim2.new(0,45,0,7)
	glideBtn1.Text = "Glide 1"

	local moveBox2 = Instance.new("TextBox")
	moveBox2.Parent = frame
	moveBox2.Size = UDim2.new(0,40,0,25)
	moveBox2.Position = UDim2.new(0,0,0,37)
	moveBox2.Text = "5"

	local glideBtn2 = Instance.new("TextButton")
	glideBtn2.Parent = frame
	glideBtn2.Size = UDim2.new(0,70,0,25)
	glideBtn2.Position = UDim2.new(0,45,0,37)
	glideBtn2.Text = "Glide 2"

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

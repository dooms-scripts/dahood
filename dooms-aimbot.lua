aimbot = {}

aimbot.enabled = true
aimbot.config = {
	keybind		= 'q',
	range		= 250,
	prediction	= 1.678,
	notifications   = false,
	predictions     = false,
	highlights      = false,
	borders         = false,
	labels          = false,
	vis_check       = false,
}

-- Services
local uis = game:GetService('UserInputService')
local players = game:GetService('Players')
local sgui = game:GetService('StarterGui')

-- Variables
local plr = game.Players.LocalPlayer
local char = plr.Character
local cam = workspace.CurrentCamera
local cursor = plr:GetMouse()

local locking = false
local target = nil

-- Functions
function findNearestCursor()
	local closestTarget = nil
	local closestDistance = 999

	local range = aimbot.config.range

	local plr = game.Players.LocalPlayer
	local char = plr.Character
	local root = char:WaitForChild('HumanoidRootPart')

	for _,human in ipairs(workspace:GetDescendants()) do
		if human:IsA('Humanoid') and human.Parent:FindFirstChild('HumanoidRootPart') and human.Parent.Name ~= plr.Name and human.Health ~= 0 then
			local cursorPos = Vector2.new(cursor.X, cursor.Y)
			local vector, onScreen = cam:WorldToScreenPoint(human.Parent.HumanoidRootPart.Position)

			if onScreen then 
				local dist = (cursorPos - Vector2.new(vector.X, vector.Y)).Magnitude
				if dist < closestDistance and (human.Parent.HumanoidRootPart.Position - players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < range then closestDistance = dist closestTarget = human.Parent end
			end
		end
	end

	return closestTarget
end

function createLabel(model)
	for _,box in ipairs(workspace:GetDescendants()) do if box.Name == 'doom#1000_bb' then box:Destroy() end end

	local BillboardGui = Instance.new("BillboardGui", model)
	local TextLabel = Instance.new("TextLabel")

	BillboardGui.Name = 'doom#1000_bb'
	BillboardGui.Adornee = model
	BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	BillboardGui.Active = true
	BillboardGui.AlwaysOnTop = true
	BillboardGui.LightInfluence = 1.000
	BillboardGui.Size = UDim2.new(75, 0, 15, 0)

	TextLabel.Parent = BillboardGui
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Font = Enum.Font.Code
	TextLabel.TextColor3 = Color3.fromRGB(158, 40, 208)
	TextLabel.TextSize = 16.000
	TextLabel.TextStrokeTransparency = 0.000
	TextLabel.Text = game.Players[model.Name].DisplayName
end

function createOutline(model)
	for _,box in ipairs(workspace:GetDescendants()) do if box.Name == 'doom#1000_sb' then box:Destroy() end end
	local box = Instance.new('SelectionBox', model)

	box.Name = 'doom#1000_sb'
	box.Adornee = model
	box.LineThickness = 0.01
	box.SurfaceTransparency = 0.95

	box.Color3 = Color3.fromRGB(158, 40, 208)
	box.SurfaceColor3 = Color3.fromRGB(158, 40, 208)
end

function createHighlight(model)
	for _,hl in ipairs(workspace:GetDescendants()) do if hl.Name == 'doom#1000_hl' then hl:Destroy() end end

	local highlight = Instance.new('Highlight', model)
	highlight.Name = 'doom#1000_hl'
	highlight.Adornee = model
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0

	highlight.FillColor = Color3.fromRGB(193, 49, 255)
	highlight.OutlineColor = Color3.fromRGB(193, 49, 255)
end

-- Input Handler
uis.InputBegan:Connect(function(keyPressed)
	if keyPressed.KeyCode == Enum.KeyCode[string.upper(aimbot.config.keybind)] and aimbot.enabled then
		locking = not locking

		if locking == true then 
			local mt = getrawmetatable(game)
			local old = mt.__namecall

			target = findNearestCursor()
			if target == nil and aimbot.config.notifications == true then
				game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Cannot find target",Text = "Target couldn't be found.",Duration = "1",})
				locking = false
			elseif target ~= nil then 				
				if aimbot.config.labels == true then createLabel(target) end
				if aimbot.config.borders == true then createOutline(target) end
				if aimbot.config.highlights == true then createHighlight(target) end
				if aimbot.config.notifications == true then game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Locked on",Text = "Target: ".. target.Name,Duration = "1",}) end
			
				local root = target.HumanoidRootPart
				local human = target.Humanoid
				local move_direction = human.MoveDirection
				
				if aimbot.config.predictions == true then
					setreadonly(mt, false)
					mt.__namecall = newcclosure(function(...)
						local args = {...}
						if aimbot.enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
							args[3] = Vector3.new(
								target.HumanoidRootPart.Position.X + move_direction.X * aimbot.config.prediction, 
								target.HumanoidRootPart.Position.Y + move_direction.Y * aimbot.config.prediction, 
								target.HumanoidRootPart.Position.Z + move_direction.Z * aimbot.config.prediction)
							return old(unpack(args))
						end
						return old(...)
					end)
				else
					setreadonly(mt, false)
					mt.__namecall = newcclosure(function(...)
						local args = {...}
						if aimbot.enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
							args[3] = root.Position
							return old(unpack(args))
						end
						return old(...)
					end)
				end

			end
		end

		if locking == false then 
			local mouse = plr:GetMouse()
			local mt = getrawmetatable(game)
			local old = mt.__namecall
			setreadonly(mt, false)
			mt.__namecall = newcclosure(function(...)
				local args = {...}
				if aimbot.enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
					args[3] = Vector3.new(mouse.Hit.p)
					return old(unpack(args))
				end
				return old(...)
			end)
			--mt = old
			--setreadonly(mt, true)	
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_bb' then v:Destroy() end end
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_hl' then v:Destroy() end end
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_sb' then v:Destroy() end end
			if aimbot.config.notifications == true then game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Unlocked",Text = "Unlocked aim",Duration = "1",}) end
			target = nil	
		end
	end	
end)

warn("doom's aimbot loaded v1.2.4")

return aimbot

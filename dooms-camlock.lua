-- doom#1000
camlock = {}

camlock.config = {
	keybind='q',
	range=250,
	prediction=0.168,
	notifications=true,
	predictions=true,
	borders=true,
  vis_check=false,
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

	local range = 250

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

function createOutline(model)
	for _,box in ipairs(workspace:GetDescendants()) do if box.Name == 'doom#1000' then box:Destroy() end end
	local box = Instance.new('SelectionBox', model)

	box.Name = 'doom#1000'
	box.Adornee = model
	box.LineThickness = 0.01
	box.SurfaceTransparency = 0.95

	box.Color3 = Color3.fromRGB(158, 40, 208)
	box.SurfaceColor3 = Color3.fromRGB(158, 40, 208)
end

-- Input Handler
uis.InputBegan:Connect(function(keyPressed)
	if keyPressed.KeyCode == Enum.KeyCode[string.upper(CONFIG.KEYBIND)] then
		locking = not locking

		if locking == true then 
			target = findNearestCursor()
			if target == nil and camlock.config.notifications == true then
				game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Cannot find target",Text = "Target couldn't be found.",Duration = "1",})
			elseif target ~= nil and camlock.config.notifications == true then
				game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Locked on",Text = "Target: ".. target.Name,Duration = "1",})
				if camlock.config.borders == true then createOutline(target) end
			end
		end

		if locking == false then 
			for _,box in ipairs(workspace:GetDescendants()) do if box.Name == 'doom#1000' then box:Destroy() end end
			game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Unlocked",Text = "Unlocked camera",Duration = "1",}) 
			target = nil	
		end

		coroutine.wrap(function()
			while wait() do 
				if locking == true and target ~= nil then
					if camlock.config.predictions then 
						local root = target.HumanoidRootPart
						local human = target.Humanoid
						local move_direction = human.MoveDirection
						cam.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position,
                        Vector3.new(root.Position.X + move_direction.X * camlock.config.prediction, root.Position.Y + move_direction.Y * camlock.config.prediction, root.Position.Z + move_direction.Z * camlock.config.prediction))
					  else
						cam.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position, target.HumanoidRootPart.Position)
					end
				end 
			end
		end)()
	end	
end)

return camlock

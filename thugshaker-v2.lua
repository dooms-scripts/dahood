-- Local
local plr = game.Players.LocalPlayer
local char = plr.Character
local root = char.HumanoidRootPart
local money = plr.DataFolder.Currency

-- Tables
local autobuy = {
    { category = "guns", items = { 'Revolver', 'Double-Barrel SG', 'Drum-Shotgun', 'TacticalShotgun', 'Shotgun', 'DrumGun', 'SilencerAR', 'Silencer', 'Glock', 'Rifle', 'AK47', 'AUG', 'SMG', 'LMG', 'P90', 'AR' } },
	{ category = "ammo", items = {} },
	{ category = "supers", items = { 'Flamethrower', 'GrenadeLauncher', 'RPG' } },
    { category = "armor", items = { 'Fire Armor', 'Medium Armor', 'High-Medium Armor' } },
    { category = "melee", items = { 'SledgeHammer', 'StopSign', 'Shovel', 'Pitchfork', 'Pencil', 'Bat', 'Knife' } },
}

local autobuy2 = {
    { category = "food", items = { 'Taco', 'Pizza', 'Hamburger', 'HotDog', 'Chicken', 'Popcorn', 'Meat', 'Lettuce', 'Donut', 'Starblox Latte', 'Da Milk', 'Cranberry', 'Lemonade' } },
    { category = "other", items = { 'Grenade', 'Flashbang', 'Crossbow', 'PepperSpray', 'TearGas', 'Taser' } },
    { category = "random", items = { 'LockPicker', 'Riot Mask', 'Skull Mask', 'Ninja Mask', 'Hockey Mask', 'Breathing Mask', 'Paintball Mask', 'Weights', 'HeavyWeights', 'Money Gun', 'Flowers', 'Basketball', 'BrownBag', 'Flashlight' } }
}

-- loading UI library
local encrypt_lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/ui-libraries/main/encrypt'))()
--local camlock = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/dooms-camlock.lua'))()
--local camlock_config = camlock.config

encrypt_lib.color = Color3.fromRGB(30, 146, 254)
encrypt_lib.color = Color3.fromRGB(255, 45, 45)
encrypt_lib.color = Color3.fromRGB(255, 146, 146)
encrypt_lib.color = Color3.fromRGB(161, 99, 255)
encrypt_lib.color = Color3.fromRGB(158, 40, 208)

local window = encrypt_lib.new_window('thugshaker v2')
local main_tab = window.new_tab('main')
local teleport_tab = window.new_tab('teleport')
local autobuy_tab = window.new_tab('autobuy')
local aimlock_tab = window.new_tab('aimlock')
local esp_tab = window.new_tab('esp')
-- main tab
group1 = main_tab.new_group('group1')
gui = group1.new_category('GUI')
gui.new_button('exit', function() encrypt_lib:exit() end)

-- autobuy tab
group1 = autobuy_tab.new_group('group1')
group2 = autobuy_tab.new_group('group2')

-- functions
function get_shop(filter)
	shop = nil
	for _,s in ipairs(workspace.Ignored.Shop:GetChildren()) do
		if string.match(s.Name, 'Ammo') ==  'Ammo' then
			else
			if string.match(s.Name, "%[(.-)%]") == filter and s:FindFirstChild('Head') then
				shop = s
			end
		end
	end
	return shop
end

function owns_gun(gun_name)
	local plr = game.Players.LocalPlayer
	local char = plr.Character
	local owns = false
	if char:FindFirstChild(gun_name) then owns = true end
	if plr.Backpack:FindFirstChild(gun_name) then owns = true end
	return owns
end

for _, category_data in ipairs(autobuy) do
    local table_category = group1.new_category(category_data.category)

	if category_data.category == 'ammo' then	
		-- ammo category
		for _, shop in ipairs(workspace.Ignored.Shop:GetChildren()) do
			if shop.Name:match('Ammo') and shop:FindFirstChild('Head') then
				local filtered_name = shop.Name:match('%[(.-)%]')
				local gun_name = '['..filtered_name:gsub(' Ammo','')..']'
				table_category.new_button(string.lower(filtered_name), function()
					warn('Buying ammo for: '..gun_name)
					if owns_gun(gun_name) == true then
						local plr = game.Players.LocalPlayer
						local char = plr.Character
						local root = char.HumanoidRootPart
						local oldpos = root.Position
						local oldmoney = money.Value
						root.CFrame = CFrame.new(shop.Head.Position)
						task.wait(0.25)
						repeat task.wait(0.01)
						fireclickdetector(shop.ClickDetector)
						until money.Value < oldmoney
						
						task.wait(.45)
						root.CFrame = CFrame.new(oldpos)
					else
						warn('You do not own the gun you are attempting to buy ammo for.')
					end
				end)
			end
		end
	end

    for _, item in ipairs(category_data.items) do
        table_category.new_button(string.lower(item), function()
			shop = get_shop(item)
			gun_name = '[' ..shop.Name:match("%[(.-)%]").. ']'
			local plr = game.Players.LocalPlayer
			local char = plr.Character
			local root = char.HumanoidRootPart
			local oldpos = root.Position
			root.CFrame = CFrame.new(shop.Head.Position)
			task.wait(0.25)
			repeat task.wait(0.01)
			fireclickdetector(shop.ClickDetector)
			until plr.Backpack:FindFirstChild(gun_name)

			task.wait(0.45)
			root.CFrame = CFrame.new(oldpos)
        end)
    end
end

for _, category_data in ipairs(autobuy2) do
    local table_category = group2.new_category(category_data.category)
    for _, item in ipairs(category_data.items) do
        table_category.new_button(string.lower(item), function()
			shop = get_shop(item)
			gun_name = '[' ..shop.Name:match("%[(.-)%]").. ']'
			local plr = game.Players.LocalPlayer
			local char = plr.Character
			local root = char.HumanoidRootPart
			local oldpos = root.Position
			root.CFrame = CFrame.new(shop.Head.Position)
			task.wait(0.25)
			repeat task.wait(0.1)
			fireclickdetector(shop.ClickDetector)
			until
			plr.Backpack:FindFirstChild(gun_name)

			task.wait(0.45)
			root.CFrame = CFrame.new(oldpos)
        end)
    end
end

-- aimlock tab
-- doom#1000
camlock = {}

camlock.enabled = true

camlock_keybind = 'q'
camlock_range = 250
camlock_prediction = 1.368
camlock_notifications   = false
camlock_predictions     = false
camlock_highlights      = false
camlock_borders         = false
camlock_labels          = false
camlock_vis_check       = false

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

	local range = camlock_range

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
	if keyPressed.KeyCode == Enum.KeyCode[string.upper(camlock_keybind)] and camlock.enabled then
		locking = not locking

		if locking == true then 
			target = findNearestCursor()
			if target == nil and camlock_notifications == true then
				game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Cannot find target",Text = "Target couldn't be found.",Duration = "1",})
				locking = false
			elseif target ~= nil then 				
				if camlock_labels == true then createLabel(target) end
				if camlock_borders == true then createOutline(target) end
				if camlock_highlights == true then createHighlight(target) end
				if camlock_notifications == true then game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Locked on",Text = "Target: ".. target.Name,Duration = "1",}) end
			end
		end

		if locking == false then 	
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_bb' then v:Destroy() end end
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_hl' then v:Destroy() end end
			for _,v in ipairs(workspace:GetDescendants()) do if v.Name == 'doom#1000_sb' then v:Destroy() end end
			if camlock_notifications == true then game:GetService('StarterGui'):SetCore('SendNotification', {Title ="Unlocked",Text = "Unlocked camera",Duration = "1",}) end
			target = nil	
		end

		coroutine.wrap(function()
			while wait() do 
				if locking == true and target ~= nil then
					if camlock_predictions == true then 
						local root = target.HumanoidRootPart
						local human = target.Humanoid
						local move_direction = human.MoveDirection
						cam.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position, Vector3.new(root.Position.X + move_direction.X * camlock_prediction, root.Position.Y + move_direction.Y * camlock_prediction, root.Position.Z + move_direction.Z * camlock_prediction))
					else
						cam.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position, target.HumanoidRootPart.Position)
					end
				end 
			end
		end)()
	end	
end)

warn('camlock loaded')
camlock_auto_predict = false
camlock.enabled = false

autopred = function(ping)
    local starter = 0.1
    local pred = starter + (0.000698800 * ping - 0.000001)
    print(pred)
    return pred
end

coroutine.wrap(function()
    while camlock_auto_predict == true do task.wait(.01)
        local ping = plr:GetNetworkPing() * 2000
        camlock_prediction = autopred(ping)
    end
end)()

group1 = aimlock_tab.new_group('group1')
camlock_category = group1.new_category('camlock')
toggle_camlock = camlock_category.new_toggle('camlock', function()
    camlock.enabled = not camlock.enabled
end)

predictions = camlock_category.new_toggle('borders', function()
    camlock_borders = not camlock_borders
end)

predictions = camlock_category.new_toggle('labels', function()
    camlock_labels = not camlock_labels
end)

predictions = camlock_category.new_toggle('highlights', function()
    camlock_highlights = not camlock_highlights
end)

predictions = camlock_category.new_toggle('notifications', function()
    camlock_notifications = not camlock_notifications
end)

predictions = camlock_category.new_toggle('predictions', function()
    camlock_predictions = not camlock_predictions
end)

predictions = camlock_category.new_toggle('auto prediction', function()
    camlock_auto_predict = not camlock_auto_predict
end)

prediction = camlock_category.new_textbox('prediction', '1.368', function()
	camlock_prediction = tonumber(prediction.text)
end)

keybind = camlock_category.new_textbox('keybind', 'q', function()
    camlock_keybind = keybind.text
end)

importc = camlock_category.new_textbox('custom config', 'code here', function() 
	--camlock.config = importc.text
end)

camlock_category.new_button('export config', function() 
	local config_export = [[
-- thugshakerv2 config export testing
camlock.config = {
	camlock_keybind = %s,
	camlock_range = %s,
	camlock_prediction = %s,
	camlock_notifications   = %s,
	camlock_predictions     = %s,
	camlock_highlights      = %s,
	camlock_borders         = %s,
	camlock_labels          = %s,
	camlock_vis_check       = %s,
}
	]]

	formatted = (string.format(config_export, 
	tostring(camlock_keybind), 
	tostring(camlock_range),
	tostring(camlock_prediction),
	tostring(camlock_notifications), 
	tostring(camlock_predictions), 
	tostring(camlock_highlights), 
	tostring(camlock_borders), 
	tostring(camlock_labels), 
	tostring(camlock_vis_check)
	))

	setclipboard(formatted)
end)

warn('thugshaker v2; beta release loaded')

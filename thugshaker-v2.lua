-- Local
local plr = game.Players.LocalPlayer
local char = plr.Character
local root = char.HumanoidRootPart
local money = plr:WaitForChild('DataFolder').Currency

local toggle_keybind = 'x'

-- Services
local input_service = game:GetService('UserInputService')

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
local encrypt_lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/ui-libraries/main/encrypt.lua'))()
local camlock = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/dooms-camlock'))()
local aimbot = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/dooms-aimbot'))()

-- toggle ui
input_service.InputBegan:Connect(function(k)
	if k.KeyCode == Enum.KeyCode[string.upper(toggle_keybind)] then	
		encrypt_lib:toggle()
	end
end)

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

toggle_bind = gui.new_textbox('toggle gui', toggle_keybind, function() toggle_keybind = toggle_bind.text end)
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
					if owns_gun(gun_name) == false then 
						return warn('You do not own the gun you are attempting to buy ammo for.') 
					end
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
				end)
			end
		end
	end

	for _, item in ipairs(category_data.items) do
		table_category.new_button(string.lower(item), function()
			shop = get_shop(item)
			local gun_name = '[' ..shop.Name:match("%[(.-)%]").. ']'
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

--[[
		                                        
	 ▄▀█ █ █▀▄▀█ █   █▀█ █▀▀ █▄▀    ▀█▀ ▄▀█ █▄▄
	 █▀█ █ █░▀░█ █▄▄ █▄█ █▄▄ █░█    ░█░ █▀█ █▄█

]]

group1 = aimlock_tab.new_group('group1')
group2 = aimlock_tab.new_group('group2')
camlock_category = group1.new_category('camlock')
aimbot_category = group2.new_category('aimlock')

-->> CAMLOCK CATEGORY
camlock_auto_predict = false
camlock.enabled = false

coroutine.wrap(function()
	local autopred = function(ping)
		local starter = 0.1
		local pred = starter + (0.000698800 * ping - 0.000001)
		print(pred)
		return pred
	end
	
	while camlock.config.auto_predict == true do task.wait(.01)
		local ping = plr:GetNetworkPing() * 2000
		camlock.config.prediction = autopred(ping)
	end
end)()


toggle_camlock = camlock_category.new_toggle('camlock', function()
	camlock.enabled = not camlock.enabled
end)

predictions = camlock_category.new_toggle('borders', function()
	camlock.config.borders = not camlock.config.borders
end)

predictions = camlock_category.new_toggle('labels', function()
	camlock.config.labels = not camlock.config.labels
end)

predictions = camlock_category.new_toggle('highlights', function()
	camlock.config.highlights = not camlock.config.highlights
end)

predictions = camlock_category.new_toggle('notifications', function()
	camlock.config.notifications = not camlock.config.notifications
end)

predictions = camlock_category.new_toggle('predictions', function()
	camlock.config.predictions = not camlock.config.predictions
end)

auto_predictions = camlock_category.new_toggle('auto prediction', function()
	camlock_auto_predict = not camlock_auto_predict
end)

prediction = camlock_category.new_textbox('prediction', '1.368', function()
	camlock.config.prediction = tonumber(prediction.text)
end)

range = camlock_category.new_textbox('range', '250', function()
	camlock.config.range = tonumber(range.text)
end)

keybind = camlock_category.new_textbox('keybind', 'q', function()
	camlock.config.keybind = keybind.text
end)

importc = camlock_category.new_textbox('custom config', 'code here', function() 
	--camlock.config = importc.text
end)

camlock_category.new_button('export config', function() 
	local config_export = [[
-- thugshakerv2 config export testing
camlock.config = {
	camlock.config.keybind = %s,
	camlock.config.range = %s,
	camlock.config.prediction = %s,
	camlock.config.notifications   = %s,
	camlock.config.predictions     = %s,
	camlock.config.highlights      = %s,
	camlock.config.borders         = %s,
	camlock.config.labels          = %s,
	camlock.config.vis_check       = %s,
}
	]]

	local formatted = (string.format(config_export, 
		tostring(camlock.config.keybind), 
		tostring(camlock.config.range),
		tostring(camlock.config.prediction),
		tostring(camlock.config.notifications), 
		tostring(camlock.config.predictions), 
		tostring(camlock.config.highlights), 
		tostring(camlock.config.borders), 
		tostring(camlock.config.labels), 
		tostring(camlock.config.vis_check)
		))

	setclipboard(formatted)
end)

-->> CAMLOCK CATEGORY
aimbot_auto_predict = false
aimbot.enabled = false

coroutine.wrap(function()
	local autopred = function(ping)
		local starter = 0.1
		local pred = starter + (0.000698800 * ping - 0.000001)
		print(pred)
		return pred
	end

	while aimbot.config.auto_predict == true do task.wait(.01)
		local ping = plr:GetNetworkPing() * 2000
		aimbot.config.prediction = autopred(ping)
	end
end)()

toggle_aimbot = aimbot_category.new_toggle('aimlock', function()
	aimbot.enabled = not aimbot.enabled
end)

aimbot_borders = aimbot_category.new_toggle('borders', function()
	aimbot.config.borders = not aimbot.config.borders
end)

aimbot_labels = aimbot_category.new_toggle('labels', function()
	aimbot.config.labels = not aimbot.config.labels
end)

aimbot_highlights = aimbot_category.new_toggle('highlights', function()
	aimbot.config.highlights = not aimbot.config.highlights
end)

aimbot_notifications = aimbot_category.new_toggle('notifications', function()
	aimbot.config.notifications = not aimbot.config.notifications
end)

aimbot_predictions = aimbot_category.new_toggle('predictions', function()
	aimbot.config.predictions = not aimbot.config.predictions
end)

aimbot_autopred = aimbot_category.new_toggle('auto prediction', function()
	aimbot_auto_predict = not aimbot_auto_predict
end)

aimbot_prediction = aimbot_category.new_textbox('prediction', '1.368', function()
	aimbot.config.prediction = tonumber(aimbot_prediction.text)
end)

aimbot_range = aimbot_category.new_textbox('range', '250', function()
	aimbot.config.range = tonumber(aimbot_range.text)
end)

aimbot_keybind = aimbot_category.new_textbox('keybind', 'q', function()
	aimbot.config.keybind = aimbot_keybind.text
end)

importc = aimbot_category.new_textbox('custom config', 'code here', function() 
	--camlock.config = importc.text
end)

aimbot_category.new_button('export config', function() 
	local config_export = [[
-- thugshakerv2 config export testing
aimbot.config = {
	aimbot.config.keybind = %s,
	aimbot.config.range = %s,
	aimbot.config.prediction = %s,
	aimbot.config.notifications   = %s,
	aimbot.config.predictions     = %s,
	aimbot.config.highlights      = %s,
	aimbot.config.borders         = %s,
	aimbot.config.labels          = %s,
	aimbot.config.vis_check       = %s,
}
	]]

	local formatted = (string.format(config_export, 
		tostring(aimbot.config.keybind), 
		tostring(aimbot.config.range),
		tostring(aimbot.config.prediction),
		tostring(aimbot.config.notifications), 
		tostring(aimbot.config.predictions), 
		tostring(aimbot.config.highlights), 
		tostring(aimbot.config.borders), 
		tostring(aimbot.config.labels), 
		tostring(aimbot.config.vis_check)
	))

	setclipboard(formatted)
end)


warn('thugshaker v2; beta release loaded')

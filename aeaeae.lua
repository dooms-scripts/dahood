f__=[[ 
		888    888                                 888               888                           
		888    888                                 888               888                          
		888    888                                 888               888                         
		888888 88888b.  888  888  .d88b.  .d8888b  88888b.   8888b.  888  888  .d88b.  888d888    
		888    888 "88b 888  888 d88P"88b 88K      888 "88b     "88b 888 .88P d8P  Y8b 888P"      
		888    888  888 888  888 888  888 "Y8888b. 888  888 .d888888 888888K  88888888 888        
		Y88b.  888  888 Y88b 888 Y88b 888      X88 888  888 888  888 888 "88b Y8b.     888         
		 "Y888 888  888  "Y88888  "Y88888  88888P' 888  888 "Y888888 888  888  "Y8888  888         
									  888                                                                               
								Y8b d88P                                                                               
								"Y88P"                                                                    
[[---------------------------------------------------------------------------------------------------------------------------]]

getgenv().usefireclickdetector = true

--[ Wait for the game to load ]-------------------------------
print('check 1')
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild('FULLY_LOADED_CHAR')

--[ Variables ]-----------------------------------------------
print('check 2')
local plr = game.Players.LocalPlayer
local backpack = plr.Backpack
local data = plr:WaitForChild('DataFolder')
local money = data.Currency
--local money = plr:WaitForChild('DataFolder').Currency

local toggle_keybind = 'X'

--[ Toggles ]-------------------------------------------------
local tasers_muted	 = false
local chat_spy		 = false
local cash_aura		 = false

local noclip		 = false
local noclipping	 = false

local cframe_walk    = false
local cframe_enabled = false
local cframe_key	 = 'y'
local cframe_speed	 = 2

local desync		 = false
local resolver	 	 = false
local anti_lock		 = false
local strafing 		 = false

local target         = nil

--[ Services ]------------------------------------------------
local input_service = game:GetService('UserInputService')
local run_service = game:GetService('RunService')
local tp_service = game:GetService('TeleportService')

--[ Tables ]--------------------------------------------------
local autobuy = {
	{ category = "guns", items = { 
		'Revolver', 
		'Double-Barrel SG', 
		'Drum-Shotgun', 
		'TacticalShotgun', 
		'Shotgun', 
		'DrumGun', 
		'SilencerAR', 
		'Silencer', 
		'Glock', 
		'Rifle', 
		'AK47', 
		'AUG', 
		'SMG', 
		'LMG', 
		'P90', 
		'AR' 
	}},

	{ category = "supers", items = { 
		'Flamethrower', 
		'GrenadeLauncher', 
		'RPG' 
	}},

	{ category = "armor", items = { 
		'Fire Armor', 
		'Medium Armor', 
		'High-Medium Armor',
	}},

	{ category = "melee", items = { 
		'SledgeHammer', 
		'Pitchfork', 
		'StopSign', 
		'Shovel', 
		'Pencil', 
		'Knife',
		'Bat', 
	}},

	{ category = "food", items = { 
		'Taco', 
		'Pizza', 
		'Hamburger', 
		'HotDog', 
		'Chicken', 
		'Popcorn', 
		'Meat', 
		'Lettuce', 
		'Donut', 
		'Starblox Latte', 
		'Da Milk', 
		'Cranberry', 
		'Lemonade' 
	}},

	{ category = "other", items = { 
		'Grenade', 
		'Flashbang', 
		'Crossbow', 
		'PepperSpray', 
		'TearGas', 
		'Taser' 
	}},

	{ category = "random", items = { 
		'LockPicker', 
		'Riot Mask', 
		'Skull Mask', 
		'Ninja Mask', 
		'Hockey Mask', 
		'Breathing Mask', 
		'Paintball Mask', 
		'Weights', 
		'HeavyWeights', 
		'Money Gun', 
		'Flowers', 
		'Basketball', 
		'BrownBag', 
		'Flashlight' 
	}},

	{ category = "ammo", items = {} },
}

--[ Functions ]-----------------------------------------------
function distance_check(object)
	local distance = 0

	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart') 
	if root then
		distance = (object.Position - root.Position).Magnitude
	end

	return distance
end

function get_root(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local root = nil

	if player.Character then
		local root = character.HumanoidRootPart or character:WaitForChild('HumanoidRootPart')
	elseif player.Character == nil then
		return warn('Could not find root of player: ' .. player.Name)
	end

	return root
end

function toggle_chatspy(bool)
	local chat = plr.PlayerGui:WaitForChild('Chat')
	local chat_box = chat.Frame.ChatChannelParentFrame
	local chat_bar = chat.Frame.ChatBarParentFrame
	chat_box.Visible = bool

	if bool then
		game.StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = '[ thugshaker v2 ] > chat spy enabled';
			Font = Enum.Font.GothamBold;
			Color = Color3.fromRGB(158, 40, 208);
			FontSize = Enum.FontSize.Size96;
			RichText = true;	
		})

		chat_bar.AnchorPoint = Vector2.new(0, 1)
		chat_bar.Position = UDim2.new(0, 0, 1, 0)
	elseif not bool then
		chat_bar.AnchorPoint = Vector2.new(0, 0)
		chat_bar.Position = UDim2.new(0, 0, 0, 0)
	end
end

function move_mouse()

end

--[ Loading UI library ]--------------------------------------
local repo = 'https://raw.githubusercontent.com/dooms-scripts/ui-libraries/refs/heads/main/encrypt/'

local encrypt       = loadstring(game:HttpGet('https://www.doom-is-a-skid.lol/cranberry-sprite/sprite2.lua'))()
local notifications = loadstring(game:HttpGet(repo .. 'encrypt-notifications.lua'))()
local esp			= loadstring(game:HttpGet(repo .. 'encrypt-esp.lua'))()

local camlock = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-private/dahood/refs/heads/main/camlock'))()
--/qvlyll/drwoolin/seekmyaffection
--[ Configuration ]-------------------------------------------
local notification_format = '<font face="Gotham"><font color="rgb(255,12,243)">thugshaker v2</font></font><font face="SourceSans"><font color="rgb(255,255,255)"> > '
camlock.config.custom_text = 'DOOM'
encrypt.colors.accent = Color3.fromRGB(255, 255, 255)
encrypt.colors.accent = Color3.fromRGB(255, 0, 0)
encrypt.colors.accent = Color3.fromRGB(215, 70, 255)
encrypt.colors.accent = Color3.fromRGB(255, 152, 220)

--[ Create window ]-------------------------------------------
local window = encrypt:new_window({ title = 'doom.lol // dahood', bg_img_transparency = 1 })--bg_img = 'http://www.roblox.com/asset/?id=11104447788', bg_img_transparency = 0.85 })

--[ Create tabs ]---------------------------------------------
local main_tab	   = window:add_tab({ name = 'main' })
--local teleport_tab = window:add_tab({ name = 'teleport' })
local autobuy_tab  = window:add_tab({ name = 'autobuy' })
local aimlock_tab  = window:add_tab({ name = 'aimlock' })
local visuals_tab	   = window:add_tab({ name = 'visuals' })

------------------------------------------------------
----	88888b.d88b.   8888b.  888 88888b.        ----
----	888 "888 "88b     "88b 888 888 "88b       ----
------------------------------------------------------
-- group1 = main_tab.new_group('group1')
-- group2 = main_tab.new_group('group2')

gui_category	= main_tab:add_category({ name = 'GUI'})
game_category	= main_tab:add_category({ name = 'game'})
player_category = main_tab:add_category({ name = 'local player'})
target_category = main_tab:add_category({ name = 'target'})

--[ COROUTINES ]----------------------------------------------
local threads = {}
threads.cash_aura = coroutine.create(function()
	while cash_aura do
		task.wait(0.1)
		local char = plr.Character or plr.CharacterAdded:Wait()
		local root = char:WaitForChild('HumanoidRootPart')
		for _, money in ipairs(workspace.Ignored.Drop:GetChildren()) do
			if money.Name == 'MoneyDrop' and distance_check(money) < 16 then
				local s, err = pcall(function()
					fireclickdetector(money.ClickDetector, 9999)
				end)

				if err then warn('err') end
			end
		end
	end
end)

threads.mute_tasers = coroutine.create(function()
	while task.wait() do
		if tasers_muted then
			for _, taser in ipairs(game:GetDescendants()) do
				if taser.Name == '[Taser]' then
					taser.Handle.Sound.Volume = 0
				end
			end
		elseif not tasers_muted then
			for _, taser in ipairs(game:GetDescendants()) do
				if taser.Name == '[Taser]' then
					taser.Handle.Sound.Volume = 1
				end
			end
		end
	end
end)

threads.cframe_walk_thread = coroutine.wrap(function()
	run_service.Stepped:Connect(function()
		task.wait()
		if cframe_walk then
			local char = plr.Character or plr.CharacterAdded:Wait()
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')

			if root then
				root.CFrame = root.CFrame + char.Humanoid.MoveDirection * cframe_speed
			end
		end
	end)
end)()

threads.noclip_thread = coroutine.wrap(function()
	run_service.Stepped:Connect(function()
		task.wait()
		if noclipping then
			local char = plr.Character or plr.CharacterAdded:Wait()
			for _, basePart in ipairs(char:GetDescendants()) do
				if basePart:IsA('BasePart') then
					if basePart.Name == 'RootRigAttachment' then return end
					basePart.CanCollide = false
				end
			end
		end

		if not noclipping then
			local char = plr.Character or plr.CharacterAdded:Wait()
			for _, basePart in ipairs(char:GetDescendants()) do
				if basePart:IsA('BasePart') and basePart.Name == 'UpperTorso' or 'LowerTorso' or 'HumanoidRootPart'  then
					if basePart.Name == 'RootRigAttachment' then return end
					basePart.CanCollide = true
				end
			end
		end
	end)
end)()

--[ UI ELEMENTS ]---------------------------------------------
gui_category:new_keybind({ text = 'toggle gui', callback = function() window:toggle() end})
gui_category:new_button({ text = 'exit', callback = function()  encrypt:exit()  end})

game_category:new_toggle({ text = 'chat spy', callback = function()
	chat_spy = not chat_spy
	-- notifications.notify(string.format('%s chat spy: %s </font></font>', notification_format, tostring(chat_spy)), 3)

	toggle_chatspy(chat_spy)
end})

game_category:new_toggle({ text = 'mute tasers', callback = function()
	tasers_muted = not tasers_muted
	coroutine.resume(threads.mute_tasers)
	-- notifications.notify(string.format('%s tasers muted: %s </font></font>',  notification_format, tostring(tasers_muted)), 3)
end})

game_category:new_toggle({ text = 'cash aura', callback = function()
	cash_aura = not cash_aura
	coroutine.resume(threads.cash_aura)
	-- notifications.notify(string.format('%s cash aura: %s </font></font>',  notification_format, tostring(cash_aura)), 3)
end})

game_category:new_button({ text = 'rejoin server', callback = function()
	tp_service:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
end})

game_category:new_button({ text = 'serverhop', callback = function()
	tp_service:Teleport(game.PlaceId, plr)
end})

game_category:new_button({ text = 'anti recoil', callback = function()
	local cam = workspace.CurrentCamera

	coroutine.wrap(function()
		local cf = cam.CFrame
		cam:Destroy()

		local Instance = Instance.new('Camera', game:GetService('Workspace'))
		Instance.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		Instance.CameraType = Enum.CameraType.Custom
		Instance.CFrame = cf
	end)()
end})

game_category:new_button({ text = 'anti afk', callback = function()
	coroutine.wrap(function()
		local GC = getconnections or get_signal_cons
		if GC then
			for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
				if v["Disable"] then
					v["Disable"](v)
				elseif v["Disconnect"] then
					v["Disconnect"](v)
				end
			end
		else
			game.Players.LocalPlayer.Idled:Connect(function()
				local VirtualUser = game:GetService("VirtualUser")
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end
	end)()
	warn('Loaded anti-afk')
end})

game_category:new_button({ text = 'disable seats', callback = function()
	for _, seat in ipairs(workspace:GetDescendants()) do
		if seat:IsA('Seat') or seat:IsA('VehicleSeat') then
			seat.Disabled = true
		end
	end
end})

player_category:new_label({ text = 'cframe walk', alignment = 'Center' }) --.alignment('center')

cframe_walk_toggle = player_category:new_toggle({ text = 'cframe walk', callback = function() 
	cframe_enabled = not cframe_enabled 
end})

cframe_walk_speed = player_category:new_textbox({ text = 'cframe speed', placeholder_text = '2', callback = function(text) 
	cframe_speed = tonumber(cframe_walk_speed.value) 
end})

cframe_walk_keybind = player_category:new_keybind({ text = 'cframe keybind', keybind = 'E', callback = function()
	if cframe_enabled then 	
		cframe_walk = not cframe_walk 

		-- notifications.notify(string.format('%s toggled cframe speed </font></font>',  notification_format), 3)
	end
end})

player_category:new_label({ text = 'noclip', alignment = 'Center' })

noclip_toggle = player_category:new_toggle({ text = 'noclip', callback = function() 
	noclip = not noclip 
end})

noclip_keybind = player_category:new_keybind({ text = 'noclip keybind', callback = function()
	if noclip_enabled then noclipping = not noclipping end
	notifications.notify(string.format('%s toggled noclip </font></font>',  notification_format), 3)
end})

target_box = target_category:new_textbox({ text = 'target', placeholder_text = 'user', callback = function(input)
	target = game.Players[input]
end})

target_keybind = target_category:new_keybind({ text = 'change target', callback = function()
	-- print('no workie yet')
	function find_nearest()
		local players = game:GetService('Players')
		local cursor = plr:GetMouse()

		local closest_target = nil
		local closest_distance = 999

		local s,error = pcall(function()
			local plr = players.LocalPlayer
			local char = plr.Character or plr.CharacterAdded:Wait()
			local root = char:WaitForChild('HumanoidRootPart')
			-- local body_effects = char.BodyEffects or char:WaitForChild('BodyEffects')

			for _, player in ipairs(game.Players:GetPlayers()) do
				if player.Character and root and player.Name ~= plr.Name then --and body_effects['K.O'].Value ~= true then
					local human = player.Character.Humanoid
					local mouse_pos = Vector2.new(cursor.X, cursor.Y)
					local vector, on_screen = workspace.CurrentCamera:WorldToScreenPoint(human.Parent.HumanoidRootPart.Position)

					if on_screen then 
						local dist = (mouse_pos - Vector2.new(vector.X, vector.Y)).Magnitude
						if dist < closest_distance then 
							closest_distance = dist 
							closest_target = human.Parent 
						end
					end
				end
			end
		end)

		if error then warn(error) end

		return closest_target
	end

	nearest = find_nearest()
	target = game.Players[nearest.Name]

	if target ~= nil then
		target_box:update({ text = nearest.Name })
	end
end})

view_toggle = target_category:new_toggle({ text = 'view', callback = function(value)
	if value then
		workspace.CurrentCamera.CameraSubject = target.Character:WaitForChild('Humanoid')
	elseif not value then
		workspace.CurrentCamera.CameraSubject = plr.Character:WaitForChild('Humanoid')
	end
end})

target_category:new_button({ text = 'go to', callback = function()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')

	local target_char = target.Character or target.CharacterAdded:Wait()
	local target_root = target_char.HumanoidRootPart or target_char:WaitForChild('HumanoidRootPart')

	root.CFrame = target.Character.HumanoidRootPart.CFrame
end})

target_category:new_button({ text = 'target random', callback = function()
	players = game:GetService('Players')
	random = math.random(1, #players:GetChildren())

	target = players:GetChildren()[random]
	target_box:update({ text = target.Name})
end})

---- ------------------------------------------------------                          
----	▄▀█ █░█ ▀█▀ █▀█ █▄▄ █░█ █▄█                    ----
----	█▀█ █▄█ ░█░ █▄█ █▄█ █▄█ ░█░                    ----
-----------------------------------------------------------

-- group1 = autobuy_tab.new_group('group1')
-- group2 = autobuy_tab.new_group('group2')

local guns_category	  = autobuy_tab:add_category({ name = 'guns'})
local supers_category = autobuy_tab:add_category({ name = 'supers'})
local ammo_category	  = autobuy_tab:add_category({ name = 'ammo'})
local melee_category  = autobuy_tab:add_category({ name = 'melee'})
local armor_category  = autobuy_tab:add_category({ name = 'armor'})
local food_category   = autobuy_tab:add_category({ name = 'food'})
local other_category  = autobuy_tab:add_category({ name = 'other'})
local random_category = autobuy_tab:add_category({ name = 'random'})


--[ FUNCTIONS ]--------------------------------------------
function owns_item(item_name)
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local owns = false
	if char:FindFirstChild(item_name) then owns = true end
	if plr.Backpack:FindFirstChild(item_name) then owns = true end
	return owns
end

function get_shop(filter, item_type)
	if not item_type then item_type = 'Gun' end

	local shop = nil
	for _, s in ipairs(workspace.Ignored.Shop:GetChildren()) do
		if item_type == 'Gun' then
			--// gun
			if string.match(s.Name, "%[(.-)%]") == filter and s:FindFirstChild('Head') then
				shop = s
			end
		elseif item_type == 'Ammo' then
			--// ammo
			if string.match(s.Name, 'Ammo') ==  'Ammo' and item_type == 'Ammo' then
				if string.match(s.Name, "%[(.-)%]") == filter and s:FindFirstChild('Head') then
					shop = s
				end
			end
		end
	end
	return shop
end

function buy_item(shop, item_name)
	if item_name == nil then item_name = '' end

	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
	local old_position = root.Position
	local old_money = money.Value

	root.CFrame = CFrame.new(shop.Head.Position)
	task.wait(.15)

	local mouse = plr:GetMouse()
	local camera = workspace.CurrentCamera
	local old_cam_pos = camera.CFrame

	local old_pos = Vector2.new(mouse.X, mouse.Y)

	repeat 
		task.wait()
		if getgenv().usefireclickdetector then
			fireclickdetector(shop.ClickDetector) 
		elseif not getgenv().usefireclickdetector then
			camera.CFrame = CFrame.lookAt(camera.CFrame.Position, shop.Head.Position)

			warn('buying with NEW FIRE CLICKDETECT METHOD!!!')
			task.wait(0.1) 
			local vector2, _ = camera:WorldToViewportPoint(shop.Head.Position)

			mousemoveabs(vector2.X, vector2.Y)
			mouse1click()
		end
	until money.Value < old_money or backpack:FindFirstChild(item_name)

	task.wait()
	root.CFrame = CFrame.new(old_position)
	camera.CFrame = old_cam_pos

	if not getgenv().usefireclickdetector then
		mousemoveabs(old_pos.X, old_pos.Y)
	end
end

local refill_button = ammo_category:new_button({
	text = 'buy ammo for current gun',
	callback = function()
		local char = plr.Character
		local backpack = plr:WaitForChild('Backpack')

		for _, tool in ipairs(char:GetChildren()) do
			if tool:IsA('Tool') and tool:FindFirstChild('GunScript') then

				local filtered_name = tool.Name:gsub('[%[%]]', '') .. ' Ammo'
				local shop = get_shop(filtered_name, 'Ammo')
				print(shop)
				print(filtered_name)


				if shop then
					if not pcall(function()
						tool.Parent = backpack

						buy_item(shop, tool.Name)

						tool.Parent = char
					end) then warn('failed') end
				end
			end
		end
	end
})

for _, data in ipairs(autobuy) do
	if data.category == 'guns' then
		for _, item_name in ipairs(data.items) do
			pcall(function()
				local shop = get_shop(item_name)
				local filtered_name = shop.Name:match('%[(.-)%]')
				local formatted_name = '['..item_name..']'

				guns_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})	
			end)
		end
	end

	if data.category == 'supers' then
		for _, item_name in ipairs(data.items) do
			pcall(function()
				local shop = get_shop(item_name)
				local filtered_name = shop.Name:match('%[(.-)%]')
				local formatted_name = '['..item_name..']'

				supers_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})	
			end)
		end
	end




	-- if data.category == 'ammo' then
	-- 	for _, shop in ipairs(workspace.Ignored.Shop:GetChildren()) do
	-- 		pcall(function()
	-- 			-- if shop.Name:match('Ammo') and shop:FindFirstChild('Head') then
	-- 			-- 	local filtered_name = shop.Name:match('%[(.-)%]')
	-- 			-- 	local gun_name = '['..filtered_name:gsub(' Ammo','')..']'

	-- 			-- 	ammo_category:new_button({ text = string.lower(filtered_name), callback = function()
	-- 			-- 		warn('Buying ammo for: '..gun_name)
	-- 			-- 		if owns_item(gun_name) == false then 
	-- 			-- 			return warn('You do not own the gun you are attempting to buy ammo for.') 
	-- 			-- 		end

	-- 			-- 		buy_item(shop)
	-- 			-- 	end})
	-- 			-- end
	-- 		end)
	-- 	end
	-- end

	-- if data.category == 'melee' then
	-- 	for _, item_name in ipairs(data.items) do
	-- 		pcall(function()
	-- 			local shop = get_shop(item_name)
	-- 			local filtered_name = shop.Name:match('%[(.-)%]')
	-- 			local formatted_name = '['..item_name..']'

	-- 			melee_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})
	-- 		end)
	-- 	end
	-- end

	if data.category == 'armor' then
		for _, item_name in ipairs(data.items) do
			pcall(function()
				local shop = get_shop(item_name)
				local filtered_name = shop.Name:match('%[(.-)%]')
				local formatted_name = '['..item_name..']'

				armor_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})
			end)
		end
	end

	-- if data.category == 'food' then
	-- 	for _, item_name in ipairs(data.items) do
	-- 		pcall(function()
	-- 			local shop = get_shop(item_name)
	-- 			local filtered_name = shop.Name:match('%[(.-)%]')
	-- 			local formatted_name = '['..item_name..']'

	-- 			food_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})
	-- 		end)
	-- 	end
	-- end

	-- if data.category == 'other' then
	-- 	for _, item_name in ipairs(data.items) do
	-- 		pcall(function()
	-- 			local shop = get_shop(item_name)
	-- 			local filtered_name = shop.Name:match('%[(.-)%]')
	-- 			local formatted_name = '['..item_name..']'

	-- 			other_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})
	-- 		end)
	-- 	end
	-- end

	-- if data.category == 'random' then
	-- 	for _, item_name in ipairs(data.items) do
	-- 		pcall(function()
	-- 			local shop = get_shop(item_name)
	-- 			local filtered_name = shop.Name:match('%[(.-)%]')
	-- 			local formatted_name = '['..item_name..']'

	-- 			random_category:new_button({ text = string.lower(filtered_name), callback = function() if shop ~= nil and owns_item(formatted_name) == false then buy_item(shop, formatted_name) end end})
	-- 		end)
	-- 	end
	-- end
end

--[[                                
		▄▀█ █ █▀▄▀█ █   █▀█ █▀▀ █▄▀    ▀█▀ ▄▀█ █▄▄
		█▀█ █ █░▀░█ █▄▄ █▄█ █▄▄ █░█    ░█░ █▀█ █▄█
]]--
-- group1 = aimlock_tab.new_group('group1')
-- group2 = aimlock_tab.new_group('group2')

--[ CAMLOCK CATEGORY ]--------------------------------
camlock_category = aimlock_tab:add_category({ name = 'camlock' })
camlock_auto_pred = false
camlock.enabled = false

--[ COROUTINES ]--------------------------------------


--[ UI ELEMENTS ]-------------------------------------
toggle_camlock	 = camlock_category:new_toggle({ text = 'camlock',			  callback = function() camlock.enabled = not camlock.enabled end})
-- borders			 = camlock_category:new_toggle({ text = 'borders',			  callback = function() camlock.config.borders = not camlock.config.borders end})
-- labels			 = camlock_category:new_toggle({ text = 'labels',			  callback = function() camlock.config.labels = not camlock.config.labels end})
-- higlights		 = camlock_category:new_toggle({ text = 'highlights', 		  callback = function() camlock.config.highlights = not camlock.config.highlights end})
notifications	 = camlock_category:new_toggle({ text = 'notifications', 	  callback = function() camlock.config.notifications = not camlock.config.notifications end})
predictions		 = camlock_category:new_toggle({ text = 'predictions', 		  callback = function() camlock.config.predictions = not camlock.config.predictions end})
auto_predictions = camlock_category:new_toggle({ text = 'auto prediction', 	  callback = function() camlock_auto_pred = not camlock_auto_pred  end})
keybind			 = camlock_category:new_keybind({ text = 'keybind', 	  callback = function(key) camlock.config.keybind = key end})
x_prediction	 = camlock_category:new_textbox({ text = 'x prediction',  placeholder_text = '0',	callback = function() camlock.config.x_prediction = tonumber(x_prediction.text) end})
y_prediction	 = camlock_category:new_textbox({ text = 'y prediction',  placeholder_text = '0', 	callback = function() camlock.config.y_prediction = tonumber(y_prediction.text) end})
range			 = camlock_category:new_textbox({ text = 'range', 		  placeholder_text = '250', 	callback = function() camlock.config.range = tonumber(range.text) end})

--[ COROUTINES ]--------------------------------------
coroutine.wrap(function()
	function autopred(ping)
		local starter = 0.1
		local pred = (0.1 + (0.000698800 * ping - 0.000001))*10

		return pred
	end

	run_service.Stepped:Connect(function()
		if camlock_auto_pred then
			local ping = plr:GetNetworkPing() * 2000
			camlock.config.x_prediction = autopred(ping)
			camlock.config.y_prediction = autopred(ping) * 1.25

			-- x_prediction:disable()
			-- y_prediction:disable()

			x_prediction:update({ text = tostring(camlock.config.x_prediction):sub(1, 5)})
			y_prediction:update({ text = tostring(camlock.config.y_prediction):sub(1, 5)})
		elseif not camlock_auto_pred then
			-- x_prediction:enable()
			-- y_prediction:enable()

			-- x_prediction.update('0')
			-- y_prediction.update('0')
		end
	end)
end)()

-- camlock_category:new_button({ text = 'export config', callback = function() 
-- 	local config_export = [[
-- -- thugshakerv2 config export testing
-- camlock.config = {
-- 	keybind = %s,
-- 	range = %s,
-- 	prediction = %s,
-- 	notifications   = %s,
-- 	predictions     = %s,
-- 	highlights      = %s,
-- 	borders         = %s,
-- 	labels          = %s,
-- 	vis_check       = %s,
-- }
-- 	]]

-- 	local formatted = (string.format(config_export, 
-- 		tostring(camlock.config.keybind), 
-- 		tostring(camlock.config.range),
-- 		tostring(camlock.config.prediction),
-- 		tostring(camlock.config.notifications), 
-- 		tostring(camlock.config.predictions), 
-- 		tostring(camlock.config.highlights), 
-- 		tostring(camlock.config.borders), 
-- 		tostring(camlock.config.labels), 
-- 		tostring(camlock.config.vis_check)
-- 		))

-- 	setclipboard(formatted)
-- end})

--[ AIMLOCK CATEGORY ]---------------------
local aimlock = false
local aimlock_locked = false
local aimlock_target = nil
local aimlock_range = 250
local aimlock_predictions = false
local aimlock_autopredict = false
local aimlock_x_prediction = 0
local aimlock_y_prediction = 0

local mouse = plr:GetMouse()

local beam_part = Instance.new('Part', workspace)
beam_part.Name = 'CursorBeam'
beam_part.CanCollide = false
beam_part.CanQuery = false
beam_part.CanTouch = false
beam_part.Anchored = true
beam_part.Transparency = 1

local beam_part_2 = Instance.new('Part', workspace)
beam_part_2.Name = 'CursorBeam'
beam_part_2.CanCollide = false
beam_part_2.CanQuery = false
beam_part_2.CanTouch = false
beam_part_2.Anchored = true
beam_part_2.Transparency = 1

local dot_gui = Instance.new("BillboardGui", beam_part_2)
local dot = Instance.new("Frame")
local round = Instance.new("UICorner")

dot_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
dot_gui.Active = true
dot_gui.AlwaysOnTop = true
dot_gui.LightInfluence = 1.000
dot_gui.Size = UDim2.new(1, 0, 1, 0)
dot_gui.Enabled = false

dot.Parent = dot_gui
dot.AnchorPoint = Vector2.new(0.5, 0.5)
dot.BackgroundColor3 = Color3.fromRGB(255, 75, 255)
dot.BorderColor3 = Color3.fromRGB(0, 0, 0)
dot.BorderSizePixel = 0
dot.Position = UDim2.new(0.5, 0, 0.5, 0)
dot.Size = UDim2.new(0.5, 0, 0.5, 0)

round.CornerRadius = UDim.new(1, 0)
round.Parent = dot

local beam_attachment_1 = Instance.new('Attachment', beam_part)
local beam_attachment_2 = Instance.new('Attachment', beam_part_2)

local beam = Instance.new('Beam', beam_part)
beam.Attachment0 = beam_attachment_1
beam.Attachment1 = beam_attachment_2
beam.FaceCamera = true
beam.Enabled = false
beam.Width0 = 0.15
beam.Width1 = 0.15

beam.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 75, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 75, 255))
})

local aimlock_tracer = Drawing.new('Line')
local aimlock_square = Drawing.new('Square')
aimlock_square.Color = Color3.fromRGB(255, 255, 255)
aimlock_square.Size = Vector2.new(3, 3)
aimlock_square.Filled = true
aimlock_tracer.Color = Color3.fromRGB(255, 255, 255)

game:GetService('RunService').Stepped:Connect(function()
	beam_part.Position = plr:GetMouse().Hit.p
	if aimlock_target then
		if aimlock_predictions then
			local character = aimlock_target.Character or aimlock_target.CharacterAdded:Wait()
			character:WaitForChild('Humanoid')
			local move_direction = character.Humanoid.MoveDirection 
			local target_root = character:WaitForChild('HumanoidRootPart')

			beam_part_2.Position = Vector3.new(
				target_root.Position.X + move_direction.X * aimlock_x_prediction,
				target_root.Position.Y + move_direction.Y * aimlock_y_prediction,
				target_root.Position.Z + move_direction.Z * aimlock_x_prediction
			)

		elseif not aimlock_predictions then
			local character = aimlock_target.Character or aimlock_target.CharacterAdded:Wait()
			local target_root = character:WaitForChild('HumanoidRootPart')

			beam_part_2.Position = target_root.Position
		end

		beampos, on_screen = workspace.CurrentCamera:WorldToViewportPoint(beam_part_2.Position)

		if on_screen then 
			aimlock_tracer.Visible = aimlock_locked
			aimlock_square.Visible = aimlock_locked
		else 
			aimlock_tracer.Visible = false 
			aimlock_square.Visible = false
		end

		aimlock_tracer.From = Vector2.new(mouse.X, (mouse.Y + 35))
		aimlock_tracer.To = Vector2.new(beampos.X, beampos.Y)
		aimlock_square.Position = Vector2.new(beampos.X - 1, beampos.Y - 1)
	end
end)

aimlock_category = aimlock_tab:add_category({ name = 'aimlock'})

--[ FUNCTIONS ]----------------------------
coroutine.wrap(function()
	run_service.Stepped:Connect(function()
		local player_gui = plr:WaitForChild('PlayerGui')
		local main_gui = player_gui:WaitForChild('MainScreenGui')
		local crosshair = main_gui:WaitForChild('Aim')

		if not aimlock_locked and aimlock then
			crosshair.Rotation = 0
		elseif aimlock_locked and aimlock then
			crosshair.Rotation += 3.5
			task.wait()

			if crosshair.Rotation >= 360 then
				crosshair.Rotation = 0
			end
		end
	end)
end)()

coroutine.wrap(function()
	function autopred(ping)
		local starter = 0.1
		local pred = (0.1 + (0.000698800 * ping - 0.000001))*10

		return pred
	end

	run_service.Stepped:Connect(function()
		if aimlock_autopredict then
			local ping = plr:GetNetworkPing() * 2000
			aimlock_x_prediction = autopred(ping)
			aimlock_y_prediction = autopred(ping) * 1.25

			-- aimlock_x_pred:disable()
			-- aimlock_y_pred:disable()

			aimlock_x_pred:update({ text = tostring(aimlock_x_prediction):sub(1, 5)})
			aimlock_y_pred:update({ text = tostring(aimlock_y_prediction):sub(1, 5)})
		elseif not aimlock_autopredict then
			-- aimlock_x_pred:enable()
			-- aimlock_y_pred:enable()

			-- x_prediction.update('0')
			-- y_prediction.update('0')
		end
	end)
end)()

coroutine.wrap(function()
	local count = 0
	local speed = 10
	local radius = 20
	run_service.Stepped:Connect(function()
		if strafing and aimlock_target then
			local char = plr.Character or plr.CharacterAdded:Wait()
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')

			local target_char = aimlock_target.Character or aimlock_target.CharacterAdded:Wait()
			local target_root = target_char.HumanoidRootPart or target_char:WaitForChild('HumanoidRootPart')

			if target_root then
				count += 1

				local rad = math.rad(count * speed)
				local angles = Vector3.new(math.cos(rad) * radius, 0, math.sin(rad) * radius)

				root.CFrame = CFrame.new(target_root.Position + angles + Vector3.new(0, 3, 0), root.Position)
			end
		end
	end)
end)()

function get_distance(obj)
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')

	local distance = (root.Position - obj.Position).Magnitude
	return distance
end

function find_nearest()
	local cursor = plr:GetMouse()
	local cam = workspace.CurrentCamera

	local closest_target = nil
	local closest_distance = 9999

	local s,error = pcall(function()
		local range = aimlock_range

		local char = plr.Character or plr.CharacterAdded:Wait()
		local root = char:WaitForChild('HumanoidRootPart')

		for _, player in ipairs(game.Players:GetPlayers()) do
			local target_char = player.Character or player.CharacterAdded:Wait()
			-- local body_effects = target_char.BodyEffects or target_char:WaitForChild('BodyEffects')

			if player.Character and root and player.Name ~= plr.Name then --and target_char.BodyEffects['K.O'].Value ~= true then
				local human = player.Character.Humanoid
				if get_distance(human.Parent.HumanoidRootPart) < range then
					local mouse_pos = Vector2.new(cursor.X, cursor.Y)
					local vector, on_screen = cam:WorldToScreenPoint(human.Parent.HumanoidRootPart.Position)

					if on_screen then 
						local dist = (mouse_pos - Vector2.new(vector.X, vector.Y)).Magnitude
						if dist < closest_distance then 
							closest_distance = dist 
							closest_target = human.Parent 
						end
					end
				end
			end
		end
	end)

	if error then warn(error) end

	return closest_target
end

--// hook to updatemousepos remote
local meta = getrawmetatable(game)
local old_nc = meta.__namecall

setreadonly(meta, false)
meta.__namecall = newcclosure(function(...)
	local args = {...}

	if aimlock and aimlock_locked and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePosI2" then
		local character = aimlock_target.Character or aimlock_target.CharacterAdded:Wait()
		local target_root = character.HumanoidRootPart or character:WaitForChild('HumanoidRootPart')

		if aimlock_predictions then
			local move_direction = character.Humanoid.MoveDirection

			args[3] = Vector3.new(
				target_root.Position.X + move_direction.X * aimlock_x_prediction,
				target_root.Position.Y + move_direction.Y * aimlock_y_prediction,
				target_root.Position.Z + move_direction.Z * aimlock_x_prediction
			)
		elseif not aimlock_predictions then
			args[3] = target_root.Position
		end

		return old_nc(unpack(args))
	end

	return old_nc(...)
end)

--hook
-- local lock

-- lock = hookmetamethod(game, '__index', function(self, method)
--     if self:IsA('Mouse') and method == 'Hit' and aimlock_target then
--         local character = aimlock_target.Character or aimlock_target.CharacterAdded:Wait()
--         local target_root = character.HumanoidRootPart or character:WaitForChild('HumanoidRootPart')
--         local new_position = target_root.Position

--         if aimlock_predictions then
--             local move_direction = character.Humanoid.MoveDirection

--             new_position = Vector3.new(
--                 target_root.Position.X + move_direction.X * aimlock_x_prediction,
--                 target_root.Position.Y + move_direction.Y * aimlock_y_prediction,
--                 target_root.Position.Z + move_direction.Z * aimlock_x_prediction
--         	)
--         end

--         return new_position
--     end

--     return lock(self, method)
-- end)

function lock_on(target_character)
	root = target_character.HumanoidRootPart or target_character:WaitForChild('HumanoidRootPart')

	aimlock_target = game.Players:GetPlayerFromCharacter(root.Parent)
end

--[ UI ELEMENTS ]--------------------------
aimlock_toggle = aimlock_category:new_toggle({
	text = 'aimlock',
	callback = function()
		aimlock = not aimlock
	end
})

strafe_toggle = aimlock_category:new_toggle({ text = 'strafe', callback = function()
	strafing = not strafing
end})

aimlock_predictions_toggle = aimlock_category:new_toggle({ 
	text = 'predictions', 
	callback = function()
		aimlock_predictions = not aimlock_predictions
	end
})

aimlock_auto_predictions = aimlock_category:new_toggle({ 
	text = 'auto prediction', 	  
	callback = function() 
		aimlock_autopredict = not aimlock_autopredict  
	end
})

aimlock_auto_predictions = aimlock_category:new_toggle({ 
	text = 'auto lock', 	  
	callback = function(autolock) 
		aimlock_locked = true
		repeat task.wait()
			local new_target = find_nearest()

			if new_target then
				aimlock_target = game.Players:GetPlayerFromCharacter(new_target)
			end
		until not autolock
			aimlock_locked = false
	end
})

aimlock_keybind = aimlock_category:new_keybind({
	text = 'keybind',
	callback = function()
		if not aimlock then return end
		aimlock_locked = not aimlock_locked

		if aimlock_locked then
			local new_target = find_nearest()

			if new_target == nil then  
				aimlock_locked = false 
				aimlock_target = nil

				game.StarterGui:SetCore('SendNotification', {
					Title = 'failed to lock on',
					Text = 'could not find target',
					Duration = 1
				})

				return
			end

			aimlock_target = game.Players:GetPlayerFromCharacter(new_target)
			game.StarterGui:SetCore('SendNotification', {
				Title = 'locked on',
				Text = 'locked onto: '..aimlock_target.DisplayName,
				Duration = 3
			})

			dot_gui.Enabled = false
			beam.Enabled = false
		elseif not aimlock_locked then
			game.StarterGui:SetCore('SendNotification', {
				Title = 'unlocked',
				Text = 'aim unlocked.',
				Duration = 3
			})

			dot_gui.Enabled = false
			beam.Enabled = false
		end
	end
})

aimlock_x_pred = aimlock_category:new_textbox({
	text = 'x prediction',
	callback = function(input)
		aimlock_x_prediction = input 
	end
})

aimlock_y_pred = aimlock_category:new_textbox({
	text = 'y prediction',
	callback = function(input)
		aimlock_y_prediction = input 
	end
})

--[ CURSOR LOCK CATEGORY ]--------------
local cursor_lock = false
local cursor_locking = false
local cursor_lock_target = nil

--[coroutine]--
coroutine.wrap(function()
	repeat task.wait()
		local target = cursor_lock_target
		local camera = workspace.CurrentCamera

		if target and cursor_locking and cursor_lock then
			local root = target.HumanoidRootPart or target:WaitForChild('HumanoidRootPart')

			if target and root then
				local pos, _ = camera:WorldToScreenPoint(root.Position)

				mousemoveabs(pos.X + root.Velocity.X, pos.Y + root.Velocity.Y)
			end
		end
	until nil
end)()

local cursorlock_category = aimlock_tab:add_category({ name = 'cursor lock' })

local toggle = cursorlock_category:new_toggle({
	text = 'cursor lock',
	callback = function()
		cursor_lock = not cursor_lock
		print(cursor_lock)
	end
})

local keybind = cursorlock_category:new_keybind({
	text = 'keybind',
	callback = function()
		if not cursor_lock then return end

		cursor_locking = not cursor_locking
		cursor_lock_target = find_nearest()
		print('yes')
		print(cursor_locking)

		if cursor_lock_target == nil then cursor_locking = false return end
	end
})


--[ ANTILOCK CATEGORY ]-----------------
antilock_category = aimlock_tab:add_category({ name = 'anti lock' })
antilock = false
antilock_mode = 'sky'

--[ FUNCTIONS ]-------------------------
coroutine.wrap(function()
	run_service.Heartbeat:Connect(function()
		if antilock then
			local char = plr.Character or plr.CharacterAdded:Wait()
			local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')
			local vel = root.Velocity

			if antilock_mode == 'sky' then
				root.Velocity = Vector3.new(0, 999, 0)
			end

			if antilock_mode == 'ground' then
				root.Velocity = Vector3.new(0, -999, 0)
			end

			if antilock_mode == 'left' then
				root.Velocity = Vector3.new(999, 0, 0)
			end

			if antilock_mode == 'right' then
				root.Velocity = Vector3.new(-999, 0, 0)
			end

			run_service.RenderStepped:Wait()
			root.Velocity = vel
		end
	end)
end)()

--[ UI ELEMENTS ]-----------------------
antilock_toggle = antilock_category:new_toggle({
	text = 'anti-lock',
	callback = function()
		antilock = not antilock
	end
})

antiresolve_toggle = antilock_category:new_toggle({
	text = 'anti-resolve',
})

-- antilock_type = antilock_category.new_dropdown({
--     text = 'mode',
--     callback = function(option)
--         antilock_mode = option
--     end
-- })

-- antilock_type:add_option('sky')
-- antilock_type:add_option('ground')
-- antilock_type:add_option('left')
-- antilock_type:add_option('right')

-- ESP
local boxes = false
local tracers = false
local labels = false
local outlines = false
local chams = false
local esp_color = Color3.fromRGB(255, 255, 255)
local outline_color = Color3.fromRGB(0, 0, 0)

local box_table = {}
local tracer_table = {}
local label_table = {}
local skeleton_table = {}
local chams_table = {}

-- group1 = visuals_tab.new_group('group1')
visuals_category = visuals_tab:add_category({ name = 'visuals' })

local fov_thread
local fov_gui
local fov_radius = 50

local fov_toggle = visuals_category:new_toggle({
	text = 'fov circle',
	callback = function(value)
		if value then
			local function create(instance, properties)
				local i = Instance.new(instance)
				for p,v in pairs(properties) do
					local s, err = pcall(function()
						i[p] = v
					end)

					if err then 
						warn('[!] PROBLEM CREATING INSTANCE "'..instance..'": '..err) 
					end
				end

				return i
			end

			fov_gui = create("ScreenGui", {Parent = nil;ZIndexBehavior = Enum.ZIndexBehavior.Sibling;})
			fov_drawing = create("Frame", {Parent = fov_gui;BorderSizePixel = 35;Size = UDim2.new(0, fov_radius*2, 0, fov_radius*2);BorderColor3 = Color3.fromRGB(0, 0, 0);BackgroundTransparency = 1;BackgroundColor3 = Color3.fromRGB(255, 255, 255);})
			stroke = create("UIStroke", {Parent = fov_drawing;Color = Color3.fromRGB(255, 255, 255);})
			round = create("UICorner", {Parent = fov_drawing;CornerRadius = UDim.new(1, 0);})

			local safe_load = loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/ui-libraries/main/safe-load.lua'))()
			safe_load(fov_gui, false)

			fov_thread = coroutine.create(function()
				repeat task.wait()
					local plr = game.Players.LocalPlayer
					local mouse = plr:GetMouse()
					local mouse_x = mouse.X
					local mouse_y = mouse.Y

					fov_drawing.Position = UDim2.new(0, mouse_x - (fov_drawing.Size.X.Offset/2), 0, mouse_y - (fov_drawing.Size.Y.Offset/2))
				until nil
			end)
			coroutine.resume(fov_thread)
		elseif not value then
			fov_gui:Destroy()
			coroutine.close(fov_thread)
		end
	end
})

box_toggle = visuals_category:new_toggle({ text = 'boxes', callback = function()
	boxes = not boxes

	if boxes then
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player and player.Character and player ~= plr then
				box_table[player.Name] = esp.new_box(player, {
					color = esp_color,
					outline = outlines,
					outline_color = outline_color,
				})
			end
		end
	elseif not boxes then
		for _, box in pairs(box_table) do
			local _, __ = pcall(function() box.destroy() end)
		end
	end
end})

tracer_toggle = visuals_category:new_toggle({ text = 'tracers', callback = function()
	tracers = not tracers

	if tracers then
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player and player.Character and player ~= plr then
				tracer_table[player.Name] = esp.new_tracer(player, {
					color = esp_color,
					outline = outlines,
					outline_color = outline_color,
				})
			end
		end
	elseif not tracers then
		for _, tracer in pairs(tracer_table) do
			local _, __ = pcall(function() tracer.destroy() end)
		end
	end
end})

text_toggle = visuals_category:new_toggle({ text = 'names', callback = function()
	labels = not labels

	if labels then
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player and player.Character and player ~= plr then
				label_table[player.Name] = esp.new_text(player, {
					color = esp_color,
					outline = outlines,
					outline_color = outline_color,
				})
			end
		end
	elseif not labels then
		for _, label in pairs(label_table) do
			local _, __ = pcall(function() label.destroy() end)
		end
	end
end})

skeletons_toggle = visuals_category:new_toggle({
	text = 'skeletons',
	callback = function()
		skeletons = not skeletons

		if skeletons then
			for _, player in ipairs(game.Players:GetPlayers()) do
				if player and player.Character and player ~= plr then
					skeleton_table[player.Name] = esp.draw_skeleton(player, {
						color = esp_color,
					})
				end
			end
		elseif not skeletons then
			for _, skele in pairs(skeleton_table) do
				local _, __ = pcall(function() 
					skele.destroy() 
				end)
			end
		end
	end
})

chams_toggle = visuals_category:new_toggle({
	text = 'chams',
	callback = function()
		chams = not chams

		if chams then
			for _, player in ipairs(game.Players:GetPlayers()) do
				if player and player.Character and player ~= plr then
					chams_table[player.Name] = esp.new_highlight(player, {
						color = esp_color,
						outline_color = esp_color,
						fill_transparency = 0.75,
						outline_transparency = 0,
						outline = true
					})
				end
			end
		elseif not chams then
			for _, cham in pairs(chams_table) do
				local _, __ = pcall(function() 
					cham.destroy() 
				end)
			end
		end
	end
})

visuals_category:new_label({ text = 'settings', alignment = 'Center' })

color_picker = visuals_category.new_colorpicker({
	text = 'esp color',
	callback = function(color)
		esp_color = color
	end
})

outline_color_picker = visuals_category.new_colorpicker({
	text = 'outline color',
	callback = function(color)
		outline_color = color
	end
})

outline_toggle = visuals_category:new_toggle({
	text = 'outlines',
	callback = function()
		outlines = not outlines
	end
})

warn('thugshaker v2; beta release loaded')

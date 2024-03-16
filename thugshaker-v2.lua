-- the OFFICIAL first thugshaker v2 release.

-- Tables
local autobuy = {
    { category = "guns", items = { 'Revolver', 'Double-Barrel SG', 'TacticalShotgun', 'Shotgun', 'DrumGun', 'SilencerAR', 'Silencer', 'Glock', 'Rifle', 'AK47', 'AUG', 'SMG', 'LMG', 'P90', 'AR' } },
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
encrypt_lib.color = Color3.fromRGB(30, 146, 254)
encrypt_lib.color = Color3.fromRGB(255, 146, 146)

local window = encrypt_lib.new_window('thugshaker v2')
local main_tab = window.new_tab('main')
local teleport_tab = window.new_tab('teleport')
local autobuy_tab = window.new_tab('autobuy')
local aimlock_tab = window.new_tab('aimlock')
local aimlock_tab = window.new_tab('esp')
-- main tab
group1 = main_tab.new_group('group1')
gui = group1.new_category('GUI')
gui.new_button('exit', function() encrypt_lib:exit() end)

-- autobuy tab
group1 = autobuy_tab.new_group('group1')
group2 = autobuy_tab.new_group('group2')

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

for _, categoryData in ipairs(autobuy) do
    local table_category = group1.new_category(categoryData.category)
    for _, item in ipairs(categoryData.items) do
        table_category.new_button(item, function()
			shop = get_shop(item)
			gun_name = '[' ..shop.Name:match("%[(.-)%]").. ']'
			print(gun_name)
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

for _, categoryData in ipairs(autobuy2) do
    local table_category = group2.new_category(categoryData.category)
    for _, item in ipairs(categoryData.items) do
        table_category.new_button(item, function()
			shop = get_shop(item)
			gun_name = '[' ..shop.Name:match("%[(.-)%]").. ']'
			print(gun_name)
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

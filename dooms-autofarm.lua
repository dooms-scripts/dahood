------------------------
--   DOOMS AUTOFARM
------------------------
-- doom#1000
-- discord.gg/doomdhc
------------------------
-- VERSION: 1.2.3
-- PATCH:
-- >> Added time elapsed
-- >> Added farm settings
-- >> Added formatting to stats
-- >> Added new settings

if _G.farm_settings ~= nil then
	farm_settings = _G.farm_settings
	if farm_settings.optimize == true then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/ultra-optimize.lua'))()
	end

	if farm_settings.acbypass == true then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/anticheat-bypass.lua'))()
	end

	if farm_settings.muteaudio == true then
		UserSettings().GameSettings.MasterVolume = 0
	end
end

loadstring(game:HttpGet("https://pastebin.com/raw/2MqFBmsU", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dooms-scripts/roblox/main/anti-idle.lua"))()
settings().Rendering.QualityLevel = 1


if _G.farmloaded then
	game.StarterGui:SetCore("SendNotification", {
		Title = 'Already loaded',
		Text = 'Autofarm is already loaded on this client!',
		Icon = 'http://www.roblox.com/asset/?id=14173970804',
		Duration = 10,
	})
	return
end

warn('1.2.3')

if game.Players.LocalPlayer.Backpack:FindFirstChild('Combat') then else
	game.StarterGui:SetCore("SendNotification", {
		Title = 'Notice',
		Text = 'Please wait for the game to load before executing.',
		Icon = 'http://www.roblox.com/asset/?id=14173970804',
		Duration = 10,
	})
	return
end


game.StarterGui:SetCore("SendNotification", {
	Title = 'dooms autofarm v1.0.1',
	Text = 'autofarm will start in 5 seconds',
	Icon = 'rbxassetid://14067565428',
	Duration = 5,
})


wait(5)

_G.farmloaded = true

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local label1 = Instance.new("TextLabel")
label1.Name = 'label1'
local onground = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local amountfarmed = Instance.new("TextLabel")
local onfloor = Instance.new("TextLabel")
local timeelapsed = Instance.new("TextLabel")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(1, 1)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(1, 0, 1, 0)
Frame.Size = UDim2.new(0, 494, 0, 100)
onground.Name = "onground"
onground.Parent = Frame
onground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
onground.BackgroundTransparency = 0
onground.BorderColor3 = Color3.fromRGB(0, 0, 0)
onground.BorderSizePixel = 0
onground.Size = UDim2.new(1, 0, 0.2, 0)
onground.Font = Enum.Font.RobotoMono
onground.Text = " doom#1000"
onground.TextColor3 = Color3.fromRGB(0, 255, 0)
onground.TextSize = 16.000
onground.TextStrokeTransparency = 1
onground.TextTransparency = 0
onground.TextWrapped = true
onground.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.Name

amountfarmed.Name = "amountfarmed"
amountfarmed.Parent = Frame
amountfarmed.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
amountfarmed.BackgroundTransparency = 0
amountfarmed.BorderColor3 = Color3.fromRGB(0, 0, 0)
amountfarmed.BorderSizePixel = 0
amountfarmed.Size = UDim2.new(1, 0, 0.2, 0)
amountfarmed.Font = Enum.Font.RobotoMono
amountfarmed.Text = " derp :p "
amountfarmed.TextColor3 = Color3.fromRGB(0, 255, 0)
amountfarmed.TextSize = 16.000
amountfarmed.TextStrokeTransparency = 1
amountfarmed.TextWrapped = true
amountfarmed.TextXAlignment = Enum.TextXAlignment.Left

timeelapsed.Name = "amountfarmed"
timeelapsed.Parent = Frame
timeelapsed.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
timeelapsed.BackgroundTransparency = 0
timeelapsed.BorderColor3 = Color3.fromRGB(0, 0, 0)
timeelapsed.BorderSizePixel = 0
timeelapsed.Size = UDim2.new(1, 0, 0.2, 0)
timeelapsed.Font = Enum.Font.RobotoMono
timeelapsed.Text = " derp :p "
timeelapsed.TextColor3 = Color3.fromRGB(0, 255, 0)
timeelapsed.TextSize = 16.000
timeelapsed.TextStrokeTransparency = 1
timeelapsed.TextWrapped = true
timeelapsed.TextXAlignment = Enum.TextXAlignment.Left

label1.Name = "1label1"
label1.Parent = Frame
label1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label1.BackgroundTransparency = 0
label1.BorderColor3 = Color3.fromRGB(0, 0, 0)
label1.BorderSizePixel = 0
label1.Size = UDim2.new(1, 0, 0.2, 0)
label1.Font = Enum.Font.RobotoMono
label1.Text = " doom's autofarm"
label1.TextColor3 = Color3.fromRGB(255, 255, 255)
label1.TextSize = 16.000
label1.TextStrokeTransparency = 1
label1.TextWrapped = true
label1.TextXAlignment = Enum.TextXAlignment.Left

onfloor.Name = "onfloor"
onfloor.Parent = Frame
onfloor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
onfloor.BackgroundTransparency = 0
onfloor.BorderColor3 = Color3.fromRGB(0, 0, 0)
onfloor.BorderSizePixel = 0
onfloor.Size = UDim2.new(1, 0, 0.2, 0)
onfloor.Font = Enum.Font.RobotoMono
onfloor.Text = " doom#1000"
onfloor.TextColor3 = Color3.fromRGB(0, 255, 0)
onfloor.TextSize = 16.000
onfloor.TextStrokeTransparency = 1
onfloor.TextTransparency = 0
onfloor.TextWrapped = true
onfloor.TextXAlignment = Enum.TextXAlignment.Left

local plr = game.Players.LocalPlayer
local char = plr.Character
local root = char:WaitForChild('HumanoidRootPart')

local combat = plr.Backpack['Combat']
local run = game:GetService('RunService')

_G.farming = true

amtfarmed = 0
_G.amtfarmed = 0
_G.time_elapsed = 0

for _,seat in ipairs(workspace:GetDescendants()) do
	if seat:IsA('Seat') then seat.Disabled = true end
	if seat:IsA('VehicleSeat') then seat.Disabled = true end
end

function spin()
	for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end

	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,50,0)
end

function stopspin()
	for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
end

function cashaura()
	_G.noclip = false
	stopspin()
	for _,cashdrop in ipairs(workspace.Ignored.Drop:GetChildren()) do
		if cashdrop.Name == 'MoneyDrop' then
			dist = (cashdrop.Position - root.Position).Magnitude

			if dist < 15 then
				--if _G.farm_settings ~= nil and _G.farm_settings.tp_to_money == true then 
					root.CFrame = CFrame.new(cashdrop.Position)
				--end
				wait(.15)
				amtfarmed = amtfarmed + tonumber(cashdrop.BillboardGui.TextLabel.Text:sub(2, 99))
				_G.amtfarmed = _G.amtfarmed + tonumber(cashdrop.BillboardGui.TextLabel.Text:sub(2, 99))
				fireclickdetector(cashdrop.ClickDetector)
				wait(.75)
			end
		end
	end
	_G.noclip = true
end

-- noclip
_G.noclip = true
run.Stepped:Connect(function()
	for _,part in ipairs(char:GetDescendants()) do
		if part:IsA('BasePart') and part.CanCollide and _G.farming and _G.noclip then part.CanCollide = false end
		if part:IsA('MeshPart') and part.CanCollide and _G.farming and _G.noclip  then part.CanCollide = false end
		if part:IsA('Part') and part.CanCollide and _G.farming and _G.noclip  then part.CanCollide = false end
	end
end)

lastatm = nil
count = 0

-- start clock
function format_time(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local remainingSeconds = seconds % 60
	return string.format("%02dh, %02dm, %02ds", hours, minutes, remainingSeconds)
end

function format_money(amount)
	local formatted = tostring(amount)
	local k = 0
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

function get_floor_money()
	local floor_money = 0

	for _,money in ipairs(workspace.Ignored.Drop:GetChildren()) do
		if money.Name == 'MoneyDrop' then
			floor_money += tonumber(money.BillboardGui.TextLabel.Text:sub(2, 99))
		end
	end

	return floor_money
end

coroutine.wrap(function()
	while task.wait(1) do
		_G.time_elapsed += 1
		timeelapsed.Text = ' time elapsed: '..tostring(format_time(_G.time_elapsed))
		onground.Text = " wallet: "..tostring(format_money(game.Players.LocalPlayer.DataFolder.Currency.Value))
		amountfarmed.Text = " amount farmed: "..tostring(format_money(_G.amtfarmed))
		-- onfloor.Text = " money on floor: " ..tostring(format_money(get_floor_money())) causes issues so i just commented it
	end
end)()

coroutine.wrap(function()
	while wait() do
		if root.Position.Y < -20 then
			root.Anchored = false
			root.CFrame = CFrame.new(lastatm.Head.Position)
			--root.CFrame = CFrame.new(-404, 21, 88)
			wait(.1)
			root.Anchored = true
		end

		if count > 7 then
			root.Anchored = false
			root.CFrame = CFrame.new(lastatm.Head.Position)
			_G.noclip = true
			wait(.1)
			root.Anchored = true
			count = 0
		end
	end
end)()

warn('Loaded dooms autofarm')

-- autofarm
while _G.farming == true do
	wait()
	combat.Parent = char

	for _,atm in ipairs(workspace.Cashiers:GetChildren()) do
		if atm.Humanoid.Health == 100 and _G.farming == true then
			lastatm = atm
			count=0
			root.CFrame = CFrame.new(Vector3.new(
				atm.Head.Position.X,
				atm.Head.Position.Y-2,
				atm.Head.Position.Z
				))
			wait(.25) 
			root.Anchored = true wait() 
			root.Anchored = false 
			spin()

			repeat 
				char.Combat:Activate()
				count=count+.55
				wait(.55) 
			until
			atm.Humanoid.Health<1
			wait(.5) root.Anchored = false
			cashaura()
		end
	end
end

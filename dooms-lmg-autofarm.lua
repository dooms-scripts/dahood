--game.StarterGui:SetCore("SendNotification", {
--	Title = 'dooms autofarm',
--	Text = 'this script is being rewritten. check back later',
--	Icon = 'rbxassetid://14173970804',
--	Duration = 25,
--})

if _G.loaded == true then
	warn('loaded already')
	return
end

coroutine.wrap(function()
	game_settings = settings()
	game_settings.Rendering.QualityLevel = 1
	UserSettings().GameSettings.MasterVolume = 0
end)()

game.StarterGui:SetCore("SendNotification", {
	Title = 'dooms autofarm rewritten',
	Text = 'hi tester :p!! waiting for game to load..',
	Icon = 'rbxassetid://14173825435',
	Duration = 25,
})

warn('1.1.2')

_G.WebhookInterval = 600
_G.AmountEarned = 0
_G.AmountSpent = 0

if getgenv().settings then
	settings = getgenv().settings

	if settings['WEBHOOK'] then
		_G.Webhook = settings['WEBHOOK']
	end

	if settings['FPS'] then
		setfpscap(settings['FPS'])
	end

	if settings['HOOK_INTERVAL'] then
		_G.WebhookInterval = settings['HOOK_INTERVAL']
	end

	if settings['CPU_SAVER'] then
		local ranSuccessfully, error = pcall(function()
			loadstring(game:HttpGet("https://pastebin.com/raw/2MqFBmsU", true))()	
		end)
		if ranSuccessfully == false then warn('ERROR LOADING CPU SAVER: '..error) end
	end
end

local data = game.Players.LocalPlayer:WaitForChild('DataFolder')

coroutine.wrap(function()
	_G.Elapsed = 0
	while wait(1) do
		_G.Elapsed = _G.Elapsed + 1
	end
end)()

if _G.Webhook then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/disconnect-hook.lua'))()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/stats-hook.lua'))()
end

-- loadstring(game:HttpGet('https://raw.githubusercontent.com/MsorkyScripts/OpenSourceAntiCheat/main/AntiCheatBypass.txt'))()

-------------------------------------------------------
-- dooms lmg farm
_G.farming = true

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local root = char:WaitForChild('HumanoidRootPart')

local money = data.Currency

local backpack = plr.Backpack

local amountFarmed = 0
local amountSpent = 0
local timeElapsed = 0
local atmsRobbed = 0

-- create debug menu ---------------------

local debugMenu = Instance.new("ScreenGui")
local window = Instance.new("Frame")
local title = Instance.new("TextLabel")

debugMenu.Name = "debugMenu"
debugMenu.Parent = game.CoreGui
debugMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

window.Name = "window"
window.Parent = debugMenu
window.AnchorPoint = Vector2.new(0, 1)
window.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
window.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.BorderSizePixel = 0
window.Position = UDim2.new(0, 0, 1, 0)
window.Size = UDim2.new(0, 294, 0, 139)

title.Name = "123"
title.Parent = window
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Size = UDim2.new(0, 294, 0, 20)
title.Font = Enum.Font.Cartoon
title.Text = "debug menu"
title.TextColor3 = Color3.fromRGB(216, 216, 216)
title.TextSize = 14.000

local earnedlabel = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local elapsedlabel = Instance.new("TextLabel")
local robbedlabel = Instance.new("TextLabel")
local spacer = Instance.new("Frame")
local ticklabel = Instance.new("TextLabel")
local spentlabel = Instance.new("TextLabel")

spentlabel.Name = "earnedlabel"
spentlabel.Parent = window
spentlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spentlabel.BackgroundTransparency = 1.000
spentlabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
spentlabel.BorderSizePixel = 0
spentlabel.Size = UDim2.new(0, 294, 0, 20)
spentlabel.Font = Enum.Font.Gotham
spentlabel.Text = " Amount Spent: "
spentlabel.TextColor3 = Color3.fromRGB(16, 172, 21)
spentlabel.TextSize = 14.000
spentlabel.TextXAlignment = Enum.TextXAlignment.Left

earnedlabel.Name = "earnedlabel"
earnedlabel.Parent = window
earnedlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
earnedlabel.BackgroundTransparency = 1.000
earnedlabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
earnedlabel.BorderSizePixel = 0
earnedlabel.Size = UDim2.new(0, 294, 0, 20)
earnedlabel.Font = Enum.Font.Gotham
earnedlabel.Text = " Amount Earned: "
earnedlabel.TextColor3 = Color3.fromRGB(16, 172, 21)
earnedlabel.TextSize = 14.000
earnedlabel.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = window
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

elapsedlabel.Name = "elapsedlabel"
elapsedlabel.Parent = window
elapsedlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
elapsedlabel.BackgroundTransparency = 1.000
elapsedlabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
elapsedlabel.BorderSizePixel = 0
elapsedlabel.Size = UDim2.new(0, 294, 0, 20)
elapsedlabel.Font = Enum.Font.Gotham
elapsedlabel.Text = " Time Elapsed:"
elapsedlabel.TextColor3 = Color3.fromRGB(16, 172, 21)
elapsedlabel.TextSize = 14.000
elapsedlabel.TextXAlignment = Enum.TextXAlignment.Left

robbedlabel.Name = "robbedlabel"
robbedlabel.Parent = window
robbedlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
robbedlabel.BackgroundTransparency = 1.000
robbedlabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
robbedlabel.BorderSizePixel = 0
robbedlabel.Size = UDim2.new(0, 294, 0, 20)
robbedlabel.Font = Enum.Font.Gotham
robbedlabel.Text = " ATMS Robbed:"
robbedlabel.TextColor3 = Color3.fromRGB(16, 172, 21)
robbedlabel.TextSize = 14.000
robbedlabel.TextXAlignment = Enum.TextXAlignment.Left

spacer.Name = "spacer"
spacer.Parent = window
spacer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spacer.BackgroundTransparency = 1.000
spacer.BorderColor3 = Color3.fromRGB(0, 0, 0)
spacer.BorderSizePixel = 0
spacer.Position = UDim2.new(0, 0, 0.473372787, 0)
spacer.Size = UDim2.new(0, 100, 0, 28)
spacer.Visible = false

ticklabel.Name = "ticklabel"
ticklabel.Parent = window
ticklabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ticklabel.BackgroundTransparency = 1.000
ticklabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ticklabel.BorderSizePixel = 0
ticklabel.Size = UDim2.new(0, 294, 0, 20)
ticklabel.Font = Enum.Font.Gotham
ticklabel.Text = " Tick:"
ticklabel.TextColor3 = Color3.fromRGB(255, 207, 131)
ticklabel.TextSize = 14.000
ticklabel.TextXAlignment = Enum.TextXAlignment.Left

------------------------------------------

-- teleport
function teleport(pos)
    local s,e=pcall(function()
        root.CFrame = CFrame.new(pos)
    end)

    if not s and e then warn(e) end
end

function anchor(cooldown)
    if cooldown == nil then cooldown = 0.1 end
    wait(cooldown)
    local success, error = pcall(function()
        root.Anchored = true        
    end)
    
    if not success and error then
        warn('ERROR ANCHORING ROOT: '..error)
    end
    wait(cooldown)
end

function unanchor(cooldown)
    if cooldown == nil then cooldown = 0.1 end
    wait(cooldown)
    local success, error = pcall(function()
        root.Anchored = false        
    end)
    
    if not success and error then
        warn('ERROR UNANCHORING ROOT: '..error)
    end
    wait(cooldown)
end

-- disable seats
for _,seat in ipairs(workspace:GetDescendants()) do
    if seat:IsA('Seat') or seat:IsA('VehicleSeat') then
        seat.Disabled = true
    end
end

--
function buyLMG()
	boughtAmount = 0
	wait(2)
    	-- If player already has LMG, returns
	if backpack:FindFirstChild('[LMG]') then return warn('Player already owns LMG; Returning')  end
	if char:FindFirstChild('[LMG]') then return warn('Player already owns LMG; Returning') end

	local shop=nil
	local bought = false

    	-- Finds the LMG shop
	for _,s in ipairs(workspace.Ignored.Shop:GetChildren()) do
        if s.Name:sub(1,5) == '[LMG]' then
            shop=s
        end
	end

	oldpos = root.Position
	unanchor()
	teleport(Vector3.new(-620.8822631835938, 20.29998779296875, -305.3392639160156)) 
	anchor()

	oldMoney = money.Value
	money.Changed:Connect(function(e)
		newMoney = money.Value
		if newMoney == oldMoney - 3863 then 
			-- amountSpent = amountSpent + 3863
			bought = true
		end
	end)

	repeat 
		fireclickdetector(shop.ClickDetector) 
		boughtAmount = boughtAmount + 1
		print('bought amount:' .. boughtAmount)
		if boughtAmount == 1 then
			bought=true
		end
		wait(.1)
	until bought == true

	unanchor()
	teleport(oldpos)
	wait()
end

function buyAmmo()
	boughtAmount = 0
   	wait(.1)
	if char:FindFirstChild('[LMG]') then
		char:FindFirstChild('[LMG]').Parent = backpack
	end

	local shop=nil
   	local bought = false

    	-- Finds the ammo shop
	for _,s in ipairs(workspace.Ignored.Shop:GetChildren()) do
		if s.Name:sub(1,14) == '200 [LMG Ammo]' then
			print(s.Name)
			shop=s
		end
	end

	oldpos = root.Position
	unanchor()
	teleport(Vector3.new(-616.1823120117188, 20.300010681152344, -305.33917236328125)) 
	anchor()


	oldMoney = money.Value
	money.Changed:Connect(function(e)
		newMoney = money.Value
		if newMoney == oldMoney - 309 then 
			amountSpent = amountSpent + 309
			bought = true
		end
	end)

	repeat fireclickdetector(shop.ClickDetector) 
		wait(.1)
		boughtAmount = boughtAmount + 1
		print('bought amount:' .. boughtAmount)
		if boughtAmount == 1 then
			bought=true
		end
	until bought == true

	unanchor()
	teleport(oldpos)
	wait()
	
	
	if backpack:FindFirstChild('[LMG]') then
		backpack:FindFirstChild('[LMG]').Parent = char
	end
	wait(.1)
end


-- cash aura
function cashAura()
    local s,error=pcall(function()
        for _,money in ipairs(workspace.Ignored.Drop:GetChildren()) do
            if money.Name == 'MoneyDrop' then
                dist = (money.Position - root.Position).Magnitude

                if dist < 24 then
                    root.CFrame=CFrame.new(money.Position) wait()
                    amountFarmed = amountFarmed+tonumber(money.BillboardGui.TextLabel.Text:sub(2,99))
                    fireclickdetector(money.ClickDetector)
                    wait(.55)
                end
            end
        end
    end)

    -- catches all possible errors
    if not s then
        warn('--> ERROR [ SEND THIS TO DOOM ]: '..error)
        errornotify('An error has occured, check console log for more details.', 15)

    end
end

-- anchor cash
coroutine.wrap(function()
    while wait() do
        for _,cash in ipairs(workspace.Ignored.Drop:GetChildren()) do
            if cash.Name=='MoneyDrop' then
                -- cash.Anchored = true
            end
        end
    end 
end)()

-- reload lmg
function reload()
	local s,e = pcall(function()
		local args = {
			[1] = "Reload",
			[2] = game:GetService("Players").LocalPlayer.Character:WaitForChild("[LMG]")
		}
	
		game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
	end)

	if not s and e then
		warn('RECOIL ERR: '..e)
	end
end

buyLMG()
buyAmmo()

-- AUTO REFILL AMMO --------------------------------------------------------
local refill = task.spawn(function()
	waitTime = 0
	ammo = plr.PlayerGui.MainScreenGui.AmmoFrame.AmmoText
	
	local s,err = pcall(function()
		boughtAmount = 0
		while wait() do
			if ammo.Text == '0' then
		             	_G.farming = false
				buyAmmo()
				_G.farming = true
				-- wait(.1)
				-- repeat
				-- buyAmmo()
				-- boughtAmount = boughtAmount + 1
				-- waitTime = waitTime + 1
	
				-- if waitTime > 10 then
				-- 	warn("You've been buying ammo too long; Cancelling")
				-- 	coroutine.yield()
				-- 	_G.farming = true
				-- end
				
				-- print('bought amount:' .. boughtAmount)
				-- if boughtAmount > 10 then
				-- 	break
				-- end

				-- until ammo.Text == '2000'
		  --           	wait(.1)
	   --          		_G.farming = true
			end
		end
	end)
	
	if not s then
		warn('ERROR: '..err)
		warn('An error has occured, check console log for more details.', 15)
	end
end)()
---------------------------------------------------------------------------

-- ANTI AFK ---------------------------------------------------------------
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
---------------------------------------------------------------------------

-- lock
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if _G.farming and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then

        args[3] = target.Position

        return old(unpack(args))
    end
    return old(...)
end)

function lockOn(atm) target = atm.Head end

coroutine.wrap(function()
	while wait(1) do
		timeElapsed = timeElapsed + 1
	end
end)()


-- anti-recoil
local cam = workspace.CurrentCamera

coroutine.wrap(function()
	local cf = cam.CFrame
	cam:Destroy()

	local Instance = Instance.new('Camera', game:GetService('Workspace'))
	Instance.CameraSubject = char.Humanoid
	Instance.CameraType = Enum.CameraType.Custom
	Instance.CFrame = cf
end)()

-- atms
reload()

tick=0

coroutine.wrap(function()
	while wait() do
		elapsedlabel.Text = ' Time Elapsed: '.._G.Elapsed
		robbedlabel.Text = ' ATMS Robbed: '..atmsRobbed
		earnedlabel.Text = ' Amount Earned: '..amountFarmed
		spentlabel.Text = " Amount Spent: "..amountSpent
		ticklabel.Text = ' Tick: '..tick

		_G.ATMCount = atmsRobbed
		_G.AmountSpent = amountSpent
		_G.AmountEarned = amountFarmed
	end
end)()

_G.loaded = true

local farm = task.spawn(function()
	while true do
		for _, atm in ipairs(workspace.Cashiers:GetChildren()) do
		    if atm.Humanoid.Health == 100 and _G.farming == true then
		    	tick=0
		        root.CFrame = CFrame.new(atm.Head.Position)
		        anchor(.2)
		        lockOn(atm)
		        
		        if backpack:FindFirstChild('[LMG]') then
		            backpack:FindFirstChild('[LMG]').Parent = char
		        end
		
		        LMG = char['[LMG]']
		
		        repeat
		        LMG:Activate()
		        wait(.1)
		        tick=tick+.1
		        if tick>3 then
				reload()
			        if backpack:FindFirstChild('[LMG]') then
			            backpack:FindFirstChild('[LMG]').Parent = char
			        end
		        	unanchor(0.2)
			        root.CFrame = CFrame.new(atm.Head.Position)
			        anchor(0.2)
			        lockOn(atm)
			        tick=0
		        end
		        until
		        atm.Humanoid.Health < 0
		        LMG:Deactivate()
		        atmsRobbed = atmsRobbed + 1
		        unanchor(0.2)
		        
		        coroutine.wrap(function()
		        reload()
		        end)()
		        cashAura()
		        wait(0.8)
		    end
		end
	
		--warn('waiting for an atm to open.')
		wait(1)
	end	
end)()


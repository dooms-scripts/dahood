-- doom#1000
if getgenv().codes == nil then return warn('No codes found, Cannot redeem.')

local data = game.Players.LocalPlayer:WaitForChild('DataFolder')
local money = data.Currency
local storage = game:GetService('ReplicatedStorage')

function redeemCode(code)
	local args = {
    		[1] = "EnterPromoCode",
   		[2] = tostring(code)
	}

	storage:WaitForChild("MainEvent"):FireServer(unpack(args))
end

for _,code in pairs(getgenv().codes) do
	local old_money = money.Value

	repeat task.wait() redeemCode(code) 
	until old_money < money.Value

	storage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Redeemed Code: "..tostring(code), "All")
	task.wait()
end

warn('Auto Redeemer Made By doom#1000 > Redeemed all codes.')

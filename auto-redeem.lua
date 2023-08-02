-- doom#1000
warn('Auto Redeemer Made By doom#IOOO')
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Auto Redeemer Made By doom#1000","All")

game.Players.LocalPlayer:WaitForChild('DataFolder')

function redeemCode(code)
	local args = {
    	[1] = "EnterPromoCode",
   		[2] = tostring(code)
	}

	game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
end

for _,code in pairs(getgenv().codes) do
	redeemCode(code)
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Redeemed Code: "..tostring(code),"All")
	wait(1)
end

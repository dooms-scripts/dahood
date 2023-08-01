-- doom#1000
function redeemCode(code)
	local args = {
    	[1] = "EnterPromoCode",
   		[2] = tostring(code)
	}

	game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
end

for _,code in pairs(getgenv().codes) do
	redeemCode(code)
	wait(3)
end

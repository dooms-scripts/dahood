--[[
      doom.lol
      -----------------------------------------------

      this protects you from flag based attacks, which includes 
      body gyro checks but it could also protect you from more.

      --> if there are more flags i should add, dm me @doom.lol
]]--

-----------------------------------------------------------------------------------------------------------------
meta = getrawmetatable(game)
namecall = meta.__namecall

getgenv().methods = {
      'FireServer',
      'FireClient',
}

getgenv().flags = {
      "CHECKER_1",
      "TeleportDetect",
      "TeleportDetect",
      "OneMoreTime",
      "CHECKER_1",
      "Kick",
      "BreathingHAMON",
      "BR_KICKPC",
      "KICKREMOTE",
      "CHECKER",
      "PERMAIDBAN",
      "checkingSPEED",
      "GUI_CHECK",
      "BANREMOTE",
}

----------------------------------------------------------------------------------------------------------------- 
for k,v in pairs(getgc(true)) do 
	if pcall(function() return rawget(v,"indexInstance") end) 
		and type(rawget(v,"indexInstance")) == "table" 
		and (rawget(v,"indexInstance"))[1] == "kick" then 
		v.tvk = { "kick", function() 
			return game.Workspace:WaitForChild("") 
		end } 
	end 
end

setreadonly(getgenv().meta, false)
meta.__namecall = newcclosure(function(...)
	local method = getnamecallmethod()
	local nc_flags = {...}

	if table.find(getgenv().methods, method) and table.find(getgenv().flags, nc_flags[2]) then
		warn('doom.lol has SAVED you from being PERM BANNED!!! 🤑🤑🤑🤑')

		for _,  flag in pairs(nc_flags) do
			print(flag)
		end

		return
	end

	return namecall(...)
end)

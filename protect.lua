--[[
      doom.lol
      -----------------------------------------------

      this protects you from flag based attacks, which includes body gyro checks but it could also protect you from more than that.

      --> if there are more flags you've found that i should add, dm me on discord @doom.lol
]]--

local meta = getrawmetatable(game)
local namecall = meta.__namecall

local methods = {
      'FireServer',
      'FireClient',
}

local flags = {
      'CHECKER_1',
      'TeleportDetect',
}

setreadonly(meta, false)
meta.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local nc_flags = {...}

    if table.find(methods, method) and table.find(flags, nc_flags[2]) then
        warn('doom.lol has SAVED you from being PERM BANNED!!! 🤑🤑🤑🤑')
        
        for _,  flag in pairs(nc_flags) do
            print(flag)
        end

        return
    end

    return namecall(...)
end)

warn('> dooms anticheat bypass loaded')

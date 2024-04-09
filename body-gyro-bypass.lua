--[[
      doom.lol
      -----------------------------------------------

      this protects you from flag based attacks, which includes body gyro checks but it could also protect you from more than that.

      --> if there are more flags you've found that i should add, dm me on discord @doom.lol
]]--

local meta = getrawmetatable(game)
local namecall = meta.__namecall

setreadonly(meta, false)
meta.__namecall = newcclosure(function(...)
    local method_flag = {...}

    if getnamecallmethod() == 'FireServer' and method_flag[2] == 'CHECKER_1' then
        warn('doom.lol has SAVED you from being PERM BANNED!!! 🤑🤑🤑🤑')
        
        for _,flag in pairs(method_flag) do
            print(flag)
        end

        return
    end

    return namecall(...)
end)

-- dooms dahood egg farm
_G.EGG_FARMING = true -- just turn this off to disable the farm

--> wait for the game to laod
repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild('FULLY_LOADED_CHAR')

--> variables
local plr = game.Players.LocalPlayer
local run = game:GetService('RunService')
local tp = game:GetService('TeleportService')
local eggs = workspace.Ignored

--> start autofarm
while _G.EGG_FARMING do
    local found_egg = false

    for _, egg in ipairs(eggs:GetChildren()) do
        if egg.Name:sub(1,3) == 'Egg' then
            found_egg = true

            local char = plr.Character or plr.CharacterAdded:Wait()
            local root = char.HumanoidRootPart or char:WaitForChild('HumanoidRootPart')

            if egg then root.CFrame = egg.CFrame end

            task.wait(1)
        end
    end

    if found_egg == false then
        _G.EGG_FARMING = false
        tp:Teleport(game.PlaceId, plr)
        queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/dooms-scripts/dahood/main/egg-farm.lua"))()')
    end
end

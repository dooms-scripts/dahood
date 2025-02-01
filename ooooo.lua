local s, e = pcall(function()

--$$$ SETUP $$$--
--$ Variables
local Player = game.Players.LocalPlayer
local GunName = '[AUG]'
local TargetShop = "[AUG] - $2131"
local AmmoShop = "90 [AUG Ammo] - $87"
local TargetPlayer = 'SSuper_SSavage'
local Locked = false

--$ Hooks
local Meta = getrawmetatable(game)
local Old = Meta.__namecall
setreadonly(Meta, false)
Meta.__namecall = newcclosure(function(...)
    local Args = {...}

    if Locked and getnamecallmethod() == 'FireServer' and Args[1] == 'UpdateMousePosI2' then
        local TargetChar = Target.Character
        local TargetRoot = TargetChar:WaitForChild('HumanoidRootPart')
        Args[2] = TargetRoot.Position
            
        return Old(unpack(Args))
    end

    return Old(...)
end)

--$ Functions
function GetShop(TargetShop)
    local Shops = workspace.Ignored.Shop:GetChildren()
    for _, Shop in Shops do
        if Shop.Name == TargetShop then
            return Shop
        end
    end
end

function ResetCharacter()
    local Char = Player.Character
    local Human = Char:WaitForChild('Humanoid')
    Human.Health = 0

    Player.CharacterAdded:Wait()
end

function GoTo(pos, cf)
    local Char = Player.Character
    local Root = Char:WaitForChild('HumanoidRootPart')
    if not cf then
        Root.CFrame = CFrame.new(pos)
    elseif cf then
        Root.CFrame = pos
    end
end

function EquipTool(name : string)
    local Backpack = Player.Backpack
    local Char = Player.Character
    for _, Tool in Backpack:GetChildren() do
        if Tool.Name == name then
            Tool.Parent = Char
        end
    end
end

function UnequipTool(name : string)
    local Backpack = Player.Backpack
    local Char = Player.Character
    for _, Tool in Char:GetChildren() do
        if Tool.Name == name and Tool:IsA('Tool') then
            Tool.Parent = Backpack
        end
    end
end

function EquipDupedGuns()
    local Backpack = Player.Backpack
    local Char = Player.Character

    for _, Tool in Backpack:GetChildren() do
        if Tool:IsA('Tool') and Tool.Name == GunName then
            Tool.Parent = Char
        end
    end
end

function UnequipDupedGuns()
    local Backpack = Player.Backpack
    local Char = Player.Character

    for _, Tool in Char:GetChildren() do
        if Tool:IsA('Tool') and Tool.Name == GunName then
            Tool.Parent = Backpack
        end
    end
end

function FireAllTools()
    local Backpack = Player.Backpack
    local Char = Player.Character

    for _, Tool in Char:GetChildren() do
        if Tool:IsA('Tool') and Tool.Name == GunName then
            Tool:Activate()
            task.wait(.1)
            Tool:Deactivate()
        end
    end
end

function ReloadGuns()
    UnequipDupedGuns()

    local Backpack = Player.Backpack
    local Char = Player.Character

    for _, Tool in Backpack:GetChildren() do
        if Tool:IsA('Tool') and Tool.Name == GunName then
            Tool.Parent = Char

            local args = { [1] = "Reload", [2] = Player.Character:WaitForChild("[AUG]")}
            game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))

            Tool.Parent = Backpack

            print('Reloaded 1 AUG')
            task.wait(2.2)
        end
    end
end

--$ Dupe Function
function DupeWeapons()
    print('Duping...')
    
    local Shop = GetShop(TargetShop)
    local AmmoShop = GetShop(AmmoShop)
    print(Shop.Name)
    
    GoTo(Shop.Head.Position)
    
    task.wait(.2)
    fireclickdetector(Shop.ClickDetector)
    
    task.wait(.2)
    EquipTool('[AUG]')
    
    task.wait(.2)
    ResetCharacter()
    
    task.wait(2)
    GoTo(Shop.Head.Position)
    EquipTool('[AUG]')
    
    task.wait(.2)
    keypress(0x11)
    
    task.wait(.2)
    fireclickdetector(Shop.ClickDetector)
    
    task.wait(.2)
    keyrelease(0x11)
    
    task.wait(2)
    UnequipTool('[AUG]')
    GoTo(AmmoShop.Head.Position)
    
    task.wait(.2)
    fireclickdetector(AmmoShop.ClickDetector) task.wait(.2)
    fireclickdetector(AmmoShop.ClickDetector) task.wait(.2)
    fireclickdetector(AmmoShop.ClickDetector) task.wait(.2)
    
    ReloadGuns()
    
    print('Duped!')
end

function KillTarget(Target)
    print('Attempting to kill target...')
    local Char = Player.Character
    local Root = Char:WaitForChild('HumanoidRootPart')
    local TargetChar = Target.Character
    local TargetRoot = TargetChar:WaitForChild('HumanoidRootPart')

    if TargetRoot then
        GoTo(TargetRoot.Position)
        EquipDupedGuns()
        task.wait()
        Locked = true

        repeat task.wait(.5) FireAllTools()
        until TargetChar.Humanoid.Health <= 0
        print('Killed Target!')
    end
end

DupeWeapons()
KillTarget()
--     task.wait(1)
--     FireAllTools()
--     FireAllTools()
--     FireAllTools()
--     FireAllTools()
--     FireAllTools()

-- task.wait(5)
-- ReloadGuns()

end)

if e then warn(e) end

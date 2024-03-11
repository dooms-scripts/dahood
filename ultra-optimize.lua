-- doom#1000
-- dahood ultra optimization script
-- not meant to be used for casual play
warn('attempting to optimize')

workspace.Lights:Destroy()
workspace.Vehicles:Destroy()
workspace.VehicleSpawner:Destroy()
workspace.Bush:Destroy()
workspace.FireParts:Destroy()
workspace.MAP.Graffiti:Destroy()
workspace.MAP.Map["Game-Houses"]:Destroy()
workspace.MAP.Map["Punching(BAGS)"]:Destroy()
workspace.MAP.Map.Props:Destroy()
workspace.MAP["Fences/UF"]:Destroy()
workspace.MAP.FireTruck:Destroy()
workspace.MAP.EVIL_SPECIAL:Destroy()
workspace.MAP.EVIL_SPECIALx:Destroy()
workspace.MAP.SPECIAL_BRIDGE:Destroy()
workspace.MAP.BullCarnival:Destroy()

for _,x in ipairs(workspace.Ignored:GetChildren()) do if x.Name == 'HouseOwn' or x.Name == 'Folder' or x.Name == 'HouseItemSale'or x.Name == 'ItemsDrop' then x:Destroy() end end
for _,x in ipairs(workspace.MAP.Map:GetChildren()) do if x.ClassName == 'Model' then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x.Name == 'print' then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x.Name == 'Image Ad Unit 2' then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('Accessory') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('Decal') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('ShirtGraphic') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('Shirt') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('Pants') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('Seat') then x:Destroy() end end
for _,x in ipairs(workspace:GetDescendants()) do if x:IsA('VehicleSeat') then x:Destroy() end end

local Terrain = workspace:FindFirstChildOfClass('Terrain')
Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0
game.Lighting.GlobalShadows = false
game.Lighting.FogEnd = 9e9
settings().Rendering.QualityLevel = 1
for i,v in pairs(game:GetDescendants()) do
    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    end
end
for i,v in pairs(game.Lighting:GetDescendants()) do
    if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
        v.Enabled = false
    end
end
workspace.DescendantAdded:Connect(function(child)
    task.spawn(function()
        if child:IsA('ForceField') then
            game.RunService.Heartbeat:Wait()
            child:Destroy()
        elseif child:IsA('Sparkles') then
            game.RunService.Heartbeat:Wait()
            child:Destroy()
        elseif child:IsA('Smoke') or child:IsA('Fire') then
            game.RunService.Heartbeat:Wait()
            child:Destroy()
        end
    end)
end)

warn('sucessfully optimized')

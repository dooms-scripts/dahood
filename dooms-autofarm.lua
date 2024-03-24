--[[

		       __                                          __        ____                   
		  ____/ /___  ____  ____ ___  _____   ____ ___  __/ /_____  / __/___ __________ ___ 
		 / __  / __ \/ __ \/ __ `__ \/ ___/  / __ `/ / / / __/ __ \/ /_/ __ `/ ___/ __ `__ \
		/ /_/ / /_/ / /_/ / / / / / (__  )  / /_/ / /_/ / /_/ /_/ / __/ /_/ / /  / / / / / /
		\__,_/\____/\____/_/ /_/ /_/____/   \__,_/\__,_/\__/\____/_/  \__,_/_/  /_/ /_/ /_/ 
		------------------------------------------------------------------------------------
		doom#1000
		> version: 1.3.0
		> added new interface
		> autofarm now restarts on death

]]--

local autofarm = {
	enabled = true,
	version = '1.3.3',
}

setclipboard = setclipboard or function() warn("Your executor isn't supported. Script may malfunction") end
fireclickdetector = fireclickdetector or function() warn("Your executor isn't supported. Script may malfunction") end

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local root = char:WaitForChild('HumanoidRootPart')

_G.amtfarmed = 0
_G.atms_farmed = 0
_G.time_elapsed = 0

if _G.farm_settings ~= nil then
	farm_settings = _G.farm_settings
	if farm_settings.optimize == true then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/ultra-optimize.lua'))()
	end

	if farm_settings.acbypass == true then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/dooms-scripts/dahood/main/anticheat-bypass.lua'))()
	end

	if farm_settings.muteaudio == true then
		UserSettings().GameSettings.MasterVolume = 0
	end
end

loadstring(game:HttpGet("https://pastebin.com/raw/2MqFBmsU", true))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dooms-scripts/roblox/main/anti-idle.lua"))()
settings().Rendering.QualityLevel = 1


if _G.farmloaded then
	game.StarterGui:SetCore("SendNotification", {
		Title = 'Already loaded',
		Text = 'Autofarm is already loaded on this client!',
		Icon = 'http://www.roblox.com/asset/?id=14173970804',
		Duration = 10,
	})
	return
end

warn(autofarm.version)

if game.Players.LocalPlayer.Backpack:FindFirstChild('Combat') then else
	game.StarterGui:SetCore("SendNotification", {
		Title = 'Notice',
		Text = 'Please wait for the game to load before executing.',
		Icon = 'http://www.roblox.com/asset/?id=14173970804',
		Duration = 10,
	})
	return
end


game.StarterGui:SetCore("SendNotification", {
	Title = 'dooms autofarm v1.0.1',
	Text = 'autofarm will start in 5 seconds',
	Icon = 'rbxassetid://14067565428',
	Duration = 5,
})


wait(5)

_G.farmloaded = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Enabled = false
local Frame = Instance.new("Frame")
local label1 = Instance.new("TextLabel")
label1.Name = 'label1'
local onground = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local amountfarmed = Instance.new("TextLabel")
local onfloor = Instance.new("TextLabel")
local timeelapsed = Instance.new("TextLabel")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(1, 1)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(1, 0, 1, 0)
Frame.Size = UDim2.new(0, 494, 0, 75)
onground.Name = "onground"
onground.Parent = Frame
onground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
onground.BackgroundTransparency = 0
onground.BorderColor3 = Color3.fromRGB(0, 0, 0)
onground.BorderSizePixel = 0
onground.Size = UDim2.new(1, 0, 0.2, 0)
onground.Font = Enum.Font.RobotoMono
onground.Text = " doom#1000"
onground.TextColor3 = Color3.fromRGB(0, 255, 0)
onground.TextSize = 16.000
onground.TextStrokeTransparency = 1
onground.TextTransparency = 0
onground.TextWrapped = true
onground.TextXAlignment = Enum.TextXAlignment.Left

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.Name

amountfarmed.Name = "amountfarmed"
amountfarmed.Parent = Frame
amountfarmed.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
amountfarmed.BackgroundTransparency = 0
amountfarmed.BorderColor3 = Color3.fromRGB(0, 0, 0)
amountfarmed.BorderSizePixel = 0
amountfarmed.Size = UDim2.new(1, 0, 0.2, 0)
amountfarmed.Font = Enum.Font.RobotoMono
amountfarmed.Text = " derp :p "
amountfarmed.TextColor3 = Color3.fromRGB(0, 255, 0)
amountfarmed.TextSize = 16.000
amountfarmed.TextStrokeTransparency = 1
amountfarmed.TextWrapped = true
amountfarmed.TextXAlignment = Enum.TextXAlignment.Left

timeelapsed.Name = "amountfarmed"
timeelapsed.Parent = Frame
timeelapsed.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
timeelapsed.BackgroundTransparency = 0
timeelapsed.BorderColor3 = Color3.fromRGB(0, 0, 0)
timeelapsed.BorderSizePixel = 0
timeelapsed.Size = UDim2.new(1, 0, 0.2, 0)
timeelapsed.Font = Enum.Font.RobotoMono
timeelapsed.Text = " derp :p "
timeelapsed.TextColor3 = Color3.fromRGB(0, 255, 0)
timeelapsed.TextSize = 16.000
timeelapsed.TextStrokeTransparency = 1
timeelapsed.TextWrapped = true
timeelapsed.TextXAlignment = Enum.TextXAlignment.Left

label1.Name = "1label1"
label1.Parent = Frame
label1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label1.BackgroundTransparency = 0
label1.BorderColor3 = Color3.fromRGB(0, 0, 0)
label1.BorderSizePixel = 0
label1.Size = UDim2.new(1, 0, 0.2, 0)
label1.Font = Enum.Font.RobotoMono
label1.Text = " doom's autofarm"
label1.TextColor3 = Color3.fromRGB(255, 255, 255)
label1.TextSize = 16.000
label1.TextStrokeTransparency = 1
label1.TextWrapped = true
label1.TextXAlignment = Enum.TextXAlignment.Left

onfloor.Name = "onfloor"
onfloor.Parent = Frame
onfloor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
onfloor.BackgroundTransparency = 0
onfloor.BorderColor3 = Color3.fromRGB(0, 0, 0)
onfloor.BorderSizePixel = 0
onfloor.Size = UDim2.new(1, 0, 0.2, 0)
onfloor.Font = Enum.Font.RobotoMono
onfloor.Text = " doom#1000"
onfloor.TextColor3 = Color3.fromRGB(0, 255, 0)
onfloor.TextSize = 16.000
onfloor.TextStrokeTransparency = 1
onfloor.TextTransparency = 0
onfloor.TextWrapped = true
onfloor.TextXAlignment = Enum.TextXAlignment.Left
onfloor.Visible = false

local DOOM1000 = Instance.new("ScreenGui")
local Fade = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local Modal = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local BioLabel = Instance.new("TextLabel")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local StatsLabel = Instance.new("TextLabel")
local StatsFrame = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local AmountFarmed = Instance.new("Frame")
local Icon = Instance.new("ImageLabel")
local FarmedLabel = Instance.new("TextLabel")
local ValueLabel = Instance.new("TextLabel")
local UIPadding_2 = Instance.new("UIPadding")
local UIListLayout_2 = Instance.new("UIListLayout")
local AtmsFarmed = Instance.new("Frame")
local Icon_2 = Instance.new("ImageLabel")
local AtmsLabel = Instance.new("TextLabel")
local ValueLabel_2 = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")
local UIListLayout_3 = Instance.new("UIListLayout")
local TimeElapsed = Instance.new("Frame")
local Icon_3 = Instance.new("ImageLabel")
local TimeLabel = Instance.new("TextLabel")
local ValueLabel_3 = Instance.new("TextLabel")
local UIPadding_4 = Instance.new("UIPadding")
local UIListLayout_4 = Instance.new("UIListLayout")
local WalletFrame = Instance.new("Frame")
local Icon_4 = Instance.new("ImageLabel")
local WalletLabel = Instance.new("TextLabel")
local ValueLabel_4 = Instance.new("TextLabel")
local UIListLayout_5 = Instance.new("UIListLayout")
local UIPadding_5 = Instance.new("UIPadding")
local Placeholder = Instance.new("Frame")
local CopyButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local VersionLabel = Instance.new("TextLabel")

DOOM1000.Name = "DOOM1000"
DOOM1000.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
DOOM1000.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fade.Name = "Fade"
Fade.Parent = DOOM1000
Fade.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Fade.BackgroundTransparency = 0.150
Fade.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fade.BorderSizePixel = 0
Fade.Size = UDim2.new(1, 0, 1, 0)

UIGradient.Rotation = -90
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
UIGradient.Parent = Fade

Modal.Name = "Modal"
Modal.Parent = DOOM1000
Modal.AnchorPoint = Vector2.new(0.5, 0.5)
Modal.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Modal.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modal.BorderSizePixel = 0
Modal.Position = UDim2.new(0.5, 0, 0.5, 0)
Modal.Size = UDim2.new(0, 275, 0, 250)

local Outline = Instance.new('UIStroke', Modal)
Outline.Color = Color3.fromRGB(125,125,125)
Outline.Thickness = 1.25
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

UICorner.Parent = Modal

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = Modal
TitleLabel.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1.000
TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.BorderSizePixel = 0
TitleLabel.Position = UDim2.new(0.5, 0, 0.050999999, 0)
TitleLabel.Size = UDim2.new(1, 0, 0, 25)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.Text = "doom's autofarm"
TitleLabel.TextColor3 = Color3.fromRGB(121, 215, 255)
TitleLabel.TextScaled = true
TitleLabel.TextSize = 14.000
TitleLabel.TextWrapped = true

local Outline = Instance.new('UIStroke', TitleLabel)
Outline.Color = Color3.fromRGB(0, 136, 225)
Outline.Thickness = 0.5
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

BioLabel.Name = "BioLabel"
BioLabel.Parent = Modal
BioLabel.AnchorPoint = Vector2.new(0.5, 0)
BioLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BioLabel.BackgroundTransparency = 1.000
BioLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
BioLabel.BorderSizePixel = 0
BioLabel.Position = UDim2.new(0.5, 0, 0.150999993, 0)
BioLabel.Size = UDim2.new(1, 0, 0, 14)
BioLabel.Font = Enum.Font.Gotham
BioLabel.Text = "atm - punch farm"
BioLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BioLabel.TextScaled = true
BioLabel.TextSize = 14.000
BioLabel.TextStrokeTransparency = 0.750
BioLabel.TextWrapped = true

DropShadowHolder.Name = "DropShadowHolder"
DropShadowHolder.Parent = Modal
DropShadowHolder.BackgroundTransparency = 1.000
DropShadowHolder.BorderSizePixel = 0
DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
DropShadowHolder.ZIndex = 0

DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 47, 1, 47)
DropShadow.ZIndex = 0
DropShadow.Image = "rbxassetid://6014261993"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.750
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

StatsLabel.Name = "StatsLabel"
StatsLabel.Parent = Modal
StatsLabel.AnchorPoint = Vector2.new(0.5, 0)
StatsLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StatsLabel.BackgroundTransparency = 1.000
StatsLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
StatsLabel.BorderSizePixel = 0
StatsLabel.Position = UDim2.new(0.5, 0, 0.270000011, 0)
StatsLabel.Size = UDim2.new(1, 0, 0, 17)
StatsLabel.Font = Enum.Font.Gotham
StatsLabel.Text = "farm stats"
StatsLabel.TextColor3 = Color3.fromRGB(11, 184, 60)
StatsLabel.TextScaled = true
StatsLabel.TextSize = 14.000
StatsLabel.TextWrapped = true

local Outline = Instance.new('UIStroke', StatsLabel)
Outline.Color = Color3.fromRGB(5, 93, 27)
Outline.Thickness = 0.5
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

StatsFrame.Name = "StatsFrame"
StatsFrame.Parent = Modal
StatsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
StatsFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
StatsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
StatsFrame.BorderSizePixel = 0
StatsFrame.Position = UDim2.new(0.5, 0, 0.593142807, 0)
StatsFrame.Size = UDim2.new(0, 228, 0, 120)

local Outline = Instance.new('UIStroke', StatsFrame)
Outline.Color = Color3.fromRGB(75, 75, 75)
Outline.Thickness = 1.25
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

UICorner_2.CornerRadius = UDim.new(0, 4)
UICorner_2.Parent = StatsFrame

UIListLayout.Parent = StatsFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UIPadding.Parent = StatsFrame
UIPadding.PaddingBottom = UDim.new(0, 4)
UIPadding.PaddingLeft = UDim.new(0, 4)
UIPadding.PaddingRight = UDim.new(0, 4)
UIPadding.PaddingTop = UDim.new(0, 4)

AmountFarmed.Name = "AmountFarmed"
AmountFarmed.Parent = StatsFrame
AmountFarmed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AmountFarmed.BackgroundTransparency = 1.000
AmountFarmed.BorderColor3 = Color3.fromRGB(0, 0, 0)
AmountFarmed.BorderSizePixel = 0
AmountFarmed.Position = UDim2.new(0, 0, 0.394366205, 0)
AmountFarmed.Size = UDim2.new(0, 220, 0, 20)

Icon.Name = "1_Icon"
Icon.Parent = AmountFarmed
Icon.AnchorPoint = Vector2.new(0, 0.5)
Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon.BackgroundTransparency = 1.000
Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon.BorderSizePixel = 0
Icon.Position = UDim2.new(0, 0, 0.5, 0)
Icon.Size = UDim2.new(0, 12, 1, 0)
Icon.Image = "http://www.roblox.com/asset/?id=6023426988"
Icon.ImageColor3 = Color3.fromRGB(125, 125, 125)

FarmedLabel.Name = "FarmedLabel"
FarmedLabel.Parent = AmountFarmed
FarmedLabel.AnchorPoint = Vector2.new(0, 0.5)
FarmedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FarmedLabel.BackgroundTransparency = 1.000
FarmedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
FarmedLabel.BorderSizePixel = 0
FarmedLabel.Position = UDim2.new(0.0754716992, 0, 0.5, 0)
FarmedLabel.Size = UDim2.new(0.621999979, 0, -0.166999996, 12)
FarmedLabel.Font = Enum.Font.Gotham
FarmedLabel.Text = "amount farmed:"
FarmedLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
FarmedLabel.TextSize = 15.000
FarmedLabel.TextWrapped = true
FarmedLabel.TextXAlignment = Enum.TextXAlignment.Left

ValueLabel.Name = "ValueLabel"
ValueLabel.Parent = FarmedLabel
ValueLabel.AnchorPoint = Vector2.new(0.5, 0)
ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ValueLabel.BackgroundTransparency = 1.000
ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ValueLabel.BorderSizePixel = 0
ValueLabel.Position = UDim2.new(1.13496876, 0, 0, 0)
ValueLabel.Size = UDim2.new(0.762000024, 0, 0, 9)
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.Text = "999"
ValueLabel.TextColor3 = Color3.fromRGB(143, 200, 209)
ValueLabel.TextSize = 15.000
ValueLabel.TextWrapped = true
ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

UIPadding_2.Parent = AmountFarmed
UIPadding_2.PaddingBottom = UDim.new(0, 4)
UIPadding_2.PaddingLeft = UDim.new(0, 4)
UIPadding_2.PaddingRight = UDim.new(0, 4)
UIPadding_2.PaddingTop = UDim.new(0, 4)

UIListLayout_2.Parent = AmountFarmed
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.SortOrder = Enum.SortOrder.Name
UIListLayout_2.Padding = UDim.new(0, 4)

AtmsFarmed.Name = "AtmsFarmed"
AtmsFarmed.Parent = StatsFrame
AtmsFarmed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AtmsFarmed.BackgroundTransparency = 1.000
AtmsFarmed.BorderColor3 = Color3.fromRGB(0, 0, 0)
AtmsFarmed.BorderSizePixel = 0
AtmsFarmed.Position = UDim2.new(0, 0, 0.394366205, 0)
AtmsFarmed.Size = UDim2.new(0, 220, 0, 20)

Icon_2.Name = "1_Icon"
Icon_2.Parent = AtmsFarmed
Icon_2.AnchorPoint = Vector2.new(0, 0.5)
Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon_2.BackgroundTransparency = 1.000
Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon_2.BorderSizePixel = 0
Icon_2.Position = UDim2.new(0, 0, 0.5, 0)
Icon_2.Size = UDim2.new(0, 12, 1, 0)
Icon_2.Image = "http://www.roblox.com/asset/?id=6023426988"
Icon_2.ImageColor3 = Color3.fromRGB(125, 125, 125)

AtmsLabel.Name = "AtmsLabel"
AtmsLabel.Parent = AtmsFarmed
AtmsLabel.AnchorPoint = Vector2.new(0, 0.5)
AtmsLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AtmsLabel.BackgroundTransparency = 1.000
AtmsLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
AtmsLabel.BorderSizePixel = 0
AtmsLabel.Position = UDim2.new(0.0754716992, 0, 0.5, 0)
AtmsLabel.Size = UDim2.new(0.621999979, 0, -0.166999996, 12)
AtmsLabel.Font = Enum.Font.Gotham
AtmsLabel.Text = "atms farmed:"
AtmsLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
AtmsLabel.TextSize = 15.000
AtmsLabel.TextWrapped = true
AtmsLabel.TextXAlignment = Enum.TextXAlignment.Left

ValueLabel_2.Name = "ValueLabel"
ValueLabel_2.Parent = AtmsLabel
ValueLabel_2.AnchorPoint = Vector2.new(0.5, 0)
ValueLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ValueLabel_2.BackgroundTransparency = 1.000
ValueLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ValueLabel_2.BorderSizePixel = 0
ValueLabel_2.Position = UDim2.new(1.13496876, 0, 0, 0)
ValueLabel_2.Size = UDim2.new(0.762000024, 0, 0, 9)
ValueLabel_2.Font = Enum.Font.Gotham
ValueLabel_2.Text = "999"
ValueLabel_2.TextColor3 = Color3.fromRGB(143, 200, 209)
ValueLabel_2.TextSize = 15.000
ValueLabel_2.TextWrapped = true
ValueLabel_2.TextXAlignment = Enum.TextXAlignment.Right

UIPadding_3.Parent = AtmsFarmed
UIPadding_3.PaddingBottom = UDim.new(0, 4)
UIPadding_3.PaddingLeft = UDim.new(0, 4)
UIPadding_3.PaddingRight = UDim.new(0, 4)
UIPadding_3.PaddingTop = UDim.new(0, 4)

UIListLayout_3.Parent = AtmsFarmed
UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_3.SortOrder = Enum.SortOrder.Name
UIListLayout_3.Padding = UDim.new(0, 4)

TimeElapsed.Name = "TimeElapsed"
TimeElapsed.Parent = StatsFrame
TimeElapsed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TimeElapsed.BackgroundTransparency = 1.000
TimeElapsed.BorderColor3 = Color3.fromRGB(0, 0, 0)
TimeElapsed.BorderSizePixel = 0
TimeElapsed.Position = UDim2.new(0, 0, 0.394366205, 0)
TimeElapsed.Size = UDim2.new(0, 220, 0, 20)

Icon_3.Name = "1_Icon"
Icon_3.Parent = TimeElapsed
Icon_3.AnchorPoint = Vector2.new(0, 0.5)
Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon_3.BackgroundTransparency = 1.000
Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon_3.BorderSizePixel = 0
Icon_3.Position = UDim2.new(0, 0, 0.5, 0)
Icon_3.Size = UDim2.new(0, 12, 1, 0)
Icon_3.Image = "http://www.roblox.com/asset/?id=6026568197"
Icon_3.ImageColor3 = Color3.fromRGB(125, 125, 125)

TimeLabel.Name = "TimeLabel"
TimeLabel.Parent = TimeElapsed
TimeLabel.AnchorPoint = Vector2.new(0, 0.5)
TimeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.BackgroundTransparency = 1.000
TimeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TimeLabel.BorderSizePixel = 0
TimeLabel.Position = UDim2.new(0.0754716992, 0, 0.5, 0)
TimeLabel.Size = UDim2.new(0.621999979, 0, -0.166999996, 12)
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.Text = "time elapsed:"
TimeLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
TimeLabel.TextSize = 15.000
TimeLabel.TextWrapped = true
TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

ValueLabel_3.Name = "ValueLabel"
ValueLabel_3.Parent = TimeLabel
ValueLabel_3.AnchorPoint = Vector2.new(0.5, 0)
ValueLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ValueLabel_3.BackgroundTransparency = 1.000
ValueLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
ValueLabel_3.BorderSizePixel = 0
ValueLabel_3.Position = UDim2.new(1.13496876, 0, 0, 0)
ValueLabel_3.Size = UDim2.new(0.762000024, 0, 0, 9)
ValueLabel_3.Font = Enum.Font.Gotham
ValueLabel_3.Text = "999"
ValueLabel_3.TextColor3 = Color3.fromRGB(143, 200, 209)
ValueLabel_3.TextSize = 15.000
ValueLabel_3.TextWrapped = true
ValueLabel_3.TextXAlignment = Enum.TextXAlignment.Right

UIPadding_4.Parent = TimeElapsed
UIPadding_4.PaddingBottom = UDim.new(0, 4)
UIPadding_4.PaddingLeft = UDim.new(0, 4)
UIPadding_4.PaddingRight = UDim.new(0, 4)
UIPadding_4.PaddingTop = UDim.new(0, 4)

UIListLayout_4.Parent = TimeElapsed
UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_4.SortOrder = Enum.SortOrder.Name
UIListLayout_4.Padding = UDim.new(0, 4)

WalletFrame.Name = "WalletFrame"
WalletFrame.Parent = StatsFrame
WalletFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalletFrame.BackgroundTransparency = 1.000
WalletFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalletFrame.BorderSizePixel = 0
WalletFrame.Position = UDim2.new(0, 0, 0.394366205, 0)
WalletFrame.Size = UDim2.new(0, 220, 0, 20)

Icon_4.Name = "1_Icon"
Icon_4.Parent = WalletFrame
Icon_4.AnchorPoint = Vector2.new(0, 0.5)
Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Icon_4.BackgroundTransparency = 1.000
Icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Icon_4.BorderSizePixel = 0
Icon_4.Position = UDim2.new(0, 0, 0.5, 0)
Icon_4.Size = UDim2.new(0, 12, 1, 0)
Icon_4.Image = "http://www.roblox.com/asset/?id=6022668892"
Icon_4.ImageColor3 = Color3.fromRGB(125, 125, 125)

WalletLabel.Name = "WalletLabel"
WalletLabel.Parent = WalletFrame
WalletLabel.AnchorPoint = Vector2.new(0, 0.5)
WalletLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WalletLabel.BackgroundTransparency = 1.000
WalletLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
WalletLabel.BorderSizePixel = 0
WalletLabel.Position = UDim2.new(0.0754716992, 0, 0.5, 0)
WalletLabel.Size = UDim2.new(0.621999979, 0, -0.166999996, 12)
WalletLabel.Font = Enum.Font.Gotham
WalletLabel.Text = "wallet:"
WalletLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
WalletLabel.TextSize = 15.000
WalletLabel.TextWrapped = true
WalletLabel.TextXAlignment = Enum.TextXAlignment.Left

ValueLabel_4.Name = "ValueLabel"
ValueLabel_4.Parent = WalletLabel
ValueLabel_4.AnchorPoint = Vector2.new(0.5, 0)
ValueLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ValueLabel_4.BackgroundTransparency = 1.000
ValueLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
ValueLabel_4.BorderSizePixel = 0
ValueLabel_4.Position = UDim2.new(1.13496876, 0, 0, 0)
ValueLabel_4.Size = UDim2.new(0.762000024, 0, 0, 9)
ValueLabel_4.Font = Enum.Font.Gotham
ValueLabel_4.Text = "999"
ValueLabel_4.TextColor3 = Color3.fromRGB(24, 209, 61)
ValueLabel_4.TextSize = 15.000
ValueLabel_4.TextWrapped = true
ValueLabel_4.TextXAlignment = Enum.TextXAlignment.Right

UIListLayout_5.Parent = WalletFrame
UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_5.SortOrder = Enum.SortOrder.Name
UIListLayout_5.Padding = UDim.new(0, 4)

UIPadding_5.Parent = WalletFrame
UIPadding_5.PaddingBottom = UDim.new(0, 4)
UIPadding_5.PaddingLeft = UDim.new(0, 4)
UIPadding_5.PaddingRight = UDim.new(0, 4)
UIPadding_5.PaddingTop = UDim.new(0, 4)

Placeholder.Name = "Placeholder"
Placeholder.Parent = StatsFrame
Placeholder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Placeholder.BackgroundTransparency = 1.000
Placeholder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Placeholder.BorderSizePixel = 0
Placeholder.Position = UDim2.new(0, 0, 0.563380301, 0)
Placeholder.Size = UDim2.new(0, 219, 0, 10)

CopyButton.Name = "CopyButton"
CopyButton.Parent = StatsFrame
CopyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CopyButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
CopyButton.BorderSizePixel = 0
CopyButton.Position = UDim2.new(0, 0, 0.803571403, 0)
CopyButton.Size = UDim2.new(0, 219, 0, 22)
CopyButton.AutoButtonColor = false
CopyButton.Font = Enum.Font.Gotham
CopyButton.Text = "copy"
CopyButton.TextColor3 = Color3.fromRGB(125, 125, 125)
CopyButton.TextSize = 14.000

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = CopyButton

VersionLabel.Name = "VersionLabel"
VersionLabel.Parent = Modal
VersionLabel.AnchorPoint = Vector2.new(0.5, 0)
VersionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VersionLabel.BackgroundTransparency = 1.000
VersionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
VersionLabel.BorderSizePixel = 0
VersionLabel.Position = UDim2.new(0.5, 0, 0.875999987, 0)
VersionLabel.Size = UDim2.new(1, 0, 0, 17)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "v"..autofarm.version
VersionLabel.TextColor3 = Color3.fromRGB(75, 75, 75)
VersionLabel.TextScaled = true
VersionLabel.TextSize = 14.000
VersionLabel.TextWrapped = true

CopyButton.MouseButton1Click:Connect(function()
	local formatted_wallet = format_money(plr.DataFolder.Currency.Value)
	local formatted_time = format_time(_G.time_elapsed)
	local formatted_profit = format_money(_G.amtfarmed)
	local atms_farmed = tostring(_G.atms_farmed)

	local str = [[```
dooms autofarm stats
---------------------
💰 amount farmed: %s
💰 atms farmed:   %s
🕒 time elapsed:  %s
---------------------
💸 wallet:        %s
```]]

	setclipboard(str:format(
		formatted_profit, 
		atms_farmed, 
		formatted_time, 
		formatted_wallet
		))

	CopyButton.Text = 'copied'
	task.wait(3)
	CopyButton.Text = 'copy'
end)


local run = game:GetService('RunService')

_G.farming = true

amtfarmed = 0

for _,seat in ipairs(workspace:GetDescendants()) do
	if seat:IsA('Seat') then seat.Disabled = true end
	if seat:IsA('VehicleSeat') then seat.Disabled = true end
end

function spin()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')

	for i,v in pairs(root:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end

	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = root
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,50,0)
end

function stopspin()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')

	for i,v in pairs(root:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
end

function cashaura()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')
	
	_G.noclip = false
	stopspin()
	for _,cashdrop in ipairs(workspace.Ignored.Drop:GetChildren()) do
		if cashdrop.Name == 'MoneyDrop' then
			local dist = (cashdrop.Position - root.Position).Magnitude

			if dist < 15 then
				--if _G.farm_settings ~= nil and _G.farm_settings.tp_to_money == true then 
				root.CFrame = CFrame.new(cashdrop.Position)
				--end
				wait(.15)
				amtfarmed = amtfarmed + tonumber(cashdrop.BillboardGui.TextLabel.Text:sub(2, 99))
				_G.amtfarmed = _G.amtfarmed + tonumber(cashdrop.BillboardGui.TextLabel.Text:sub(2, 99))
				fireclickdetector(cashdrop.ClickDetector)
				wait(.75)
			end
		end
	end
	_G.noclip = true
end

-- noclip
_G.noclip = true
run.Stepped:Connect(function()
	for _,part in ipairs(char:GetDescendants()) do
		if part:IsA('BasePart') and part.CanCollide and _G.farming and _G.noclip then part.CanCollide = false end
		if part:IsA('MeshPart') and part.CanCollide and _G.farming and _G.noclip  then part.CanCollide = false end
		if part:IsA('Part') and part.CanCollide and _G.farming and _G.noclip  then part.CanCollide = false end
	end
end)

lastatm = nil
count = 0

-- start clock
function format_time(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local remainingSeconds = seconds % 60
	return string.format("%02dh, %02dm, %02ds", hours, minutes, remainingSeconds)
end

function format_money(amount)
	local formatted = tostring(amount)
	local k = 0
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

function get_floor_money()
	local floor_money = 0

	for _,money in ipairs(workspace.Ignored.Drop:GetChildren()) do
		if money.Name == 'MoneyDrop' then
			floor_money += tonumber(money.BillboardGui.TextLabel.Text:sub(2, 99))
		end
	end

	return floor_money
end

coroutine.wrap(function()
	while task.wait(1) do
		_G.time_elapsed += 1
		ValueLabel.Text   = tostring(format_money(_G.amtfarmed))
		ValueLabel_2.Text = tostring(_G.atms_farmed)
		ValueLabel_3.Text = tostring(format_time(_G.time_elapsed))
		ValueLabel_4.Text = tostring(format_money(game.Players.LocalPlayer.DataFolder.Currency.Value))
		-- onfloor.Text = " money on floor: " ..tostring(format_money(get_floor_money())) causes issues so i just commented it
	end
end)()

coroutine.wrap(function()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local root = char:WaitForChild('HumanoidRootPart')
	
	while wait() do
		if root.Position.Y < -20 then
			root.Anchored = false
			root.CFrame = CFrame.new(lastatm.Head.Position)
			--root.CFrame = CFrame.new(-404, 21, 88)
			wait(.1)
			root.Anchored = true
		end

		if count > 7 then
			root.Anchored = false
			root.CFrame = CFrame.new(lastatm.Head.Position)
			_G.noclip = true
			wait(.1)
			root.Anchored = true
			count = 0
		end
	end
end)()

warn('Loaded dooms autofarm')

-- autofarm
while _G.farming == true do
	local char = plr.Character or plr.CharacterAdded:Wait()
	local combat = nil
	if plr.Backpack:FindFirstChild('Combat') then 
		combat = plr.Backpack['Combat']
	elseif char:FindFirstChild('Combat') then
		combat = char:WaitForChild('Combat')
	end
	
	local root = char:WaitForChild('HumanoidRootPart')
	combat.Parent = char

	for _,atm in ipairs(workspace.Cashiers:GetChildren()) do
		if atm.Humanoid.Health == 100 and _G.farming == true then
			local char = plr.Character or plr.CharacterAdded:Wait()
			local root = char:WaitForChild('HumanoidRootPart')
			
			if plr.Backpack:FindFirstChild('Combat') then 
				combat = plr.Backpack['Combat']
			elseif char:FindFirstChild('Combat') then
				combat = char:WaitForChild('Combat')
			end
			
			_G.atms_farmed += 1
			lastatm = atm
			count=0
			root.CFrame = CFrame.new(Vector3.new(
				atm.Head.Position.X,
				atm.Head.Position.Y-2,
				atm.Head.Position.Z
				))
			task.wait(.25) 
			root.Anchored = true task.wait() 
			root.Anchored = false 
			spin()

			repeat 
				if char:FindFirstChild('Combat') then 
					else combat.Parent = char
				end

				char.Combat:Activate()
				count=count+.55
				task.wait(.55) 
			until atm.Humanoid.Health<1
			task.wait(.5) root.Anchored = false
			cashaura()
		end
	end
end

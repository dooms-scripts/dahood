--> Variables <-------------------------------------------------------------
local https = game:GetService("HttpService")

local WebhookURL = _G.Webhook -- The Discord Webhook URL it'll use to send the embed through.
local userThumbnail = loadstring(game:HttpGet('https://pastebin.com/raw/AC35HBac'))()
----------------------------------------------------------------------------

warn('--> Loaded Stats Hook')

--> Functions <-------------------------------------------------------------
coroutine.wrap(function()

    -- Wait for player to load before running
    game.Players.LocalPlayer:WaitForChild('DataFolder')

    -- Loops until the player is kicked
    local function sendWebhook()
        local Player = game.Players.LocalPlayer
        local Currency = Player.DataFolder.Currency.Value
    
        local formattedMoney = string.format("%d", Currency)
    
        local function formatNumberWithCommas(amount)
            local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
            return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
        end
    
        formattedMoney = formatNumberWithCommas(formattedMoney)
    
        -- local embColor = 0x1CA6E4 [ old embed color ]
	local embColor = 0x5AB7E2 -- [ new embed color ]

	--icon_url = "https://cdn.discordapp.com/attachments/1136792419057283082/1137763658332651520/blueinfo.png"
			
        local data = {
            Url = WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                embeds = {{
                    author = {
                        name = "dooms autofarm - STATS"
                    },
                    title = string.format("%s `(%s)`", Player.Name, Player.UserId),
                    description = string.format("Money: `%s` \n\nAmount Earned: `%s` \nAmount Spent: `%s` \n\nElapsed: `%s seconds` \nATMs Farmed: `%s`", formattedMoney, tostring(_G.AmountEarned), tostring(_G.AmountSpent), tostring(_G.Elapsed), tostring(_G.ATMCount)),
                    thumbnail = {
                        url = tostring(userThumbnail),
                    },
                    color = embColor
                }}
            })
        }
            
        local response = http.request(data)
    end

    local function sendWebhook2()
        local Player = game.Players.LocalPlayer
        local Currency = Player.DataFolder.Currency.Value
    
        local formattedMoney = string.format("%d", Currency)
    
        local function formatNumberWithCommas(amount)
            local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
            return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
        end
    
        formattedMoney = formatNumberWithCommas(formattedMoney)
    
        local embColor = 0x1AE262
    
        local data = {
            Url = WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                embeds = {{
                    author = {
                        name = "dooms autofarm",
                        icon_url = "https://ibb.co/YWyJZrw"
                    },
                    title = string.format("%s `(%s)` - Connected!", Player.Name, Player.UserId),
                    description = string.format("Starting Amount: `%s`", formattedMoney),
                    thumbnail = {
                        url = tostring(userThumbnail),
                    },
                    color = embColor
                }}
            })
        }
            
        local response = http.request(data)
    end

    sendWebhook2()

    -- Sends the webhook every 10 minutes
    while true do
        wait(_G.WebhookInterval)
        sendWebhook()
    end
end)()
----------------------------------------------------------------------------

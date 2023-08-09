--> Variables <-------------------------------------------------------------
local https = game:GetService("HttpService")

local WebhookURL = _G.Webhook -- The Discord Webhook URL it'll use to send the embed through.
local userThumbnail = loadstring(game:HttpGet('https://pastebin.com/raw/AC35HBac'))()

local debounce = false
_G.errMsg = 'Couldnt fetch'
----------------------------------------------------------------------------

warn('yeahyeah')

--> Functions <-------------------------------------------------------------
coroutine.wrap(function()

  -- Wait for player to load before running
	game.Players.LocalPlayer:WaitForChild('DataFolder')

  -- Loops until the player is kicked
	while debounce == false do wait()
		local function sendWebhook()
		    local Player = game.Players.LocalPlayer
		    local Currency = Player.DataFolder.Currency.Value
		
		    local formattedMoney = string.format("%d", Currency)
		
		    local function formatNumberWithCommas(amount)
		        local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
		        return left .. (num:reverse():gsub("(%d%d%d)", "%1,"):reverse()) .. right
		    end
		
		    formattedMoney = formatNumberWithCommas(formattedMoney)
		
		    local embColor = 0xEF2D24
		
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
		                    icon_url = "https://cdn.discordapp.com/attachments/1136792419057283082/1137717097879834685/info.png"
		                },
		                title = string.format("%s (%s) Disconnected.", Player.Name, Player.UserId),
		                description = string.format("Disconnect message: `%s` \n\nMoney: `%s` \nAmount Earned: `%s` \nAmount Spent: `%s`  \nElapsed: `%s seconds` \nATMs Farmed: `%s`", tostring(_G.errMsg), formattedMoney, tostring(_G.AmountEarned), tostring(_G.AmountSpent), tostring(_G.Elapsed), tostring(_G.ATMCount)),
		                thumbnail = {
		                    url = tostring(userThumbnail),
		                },
		                color = embColor
		            }}
		        })
			}
			   
		    local response = http.request(data)
		end
		
		-- Check for kick message
		for _,v in ipairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetDescendants()) do

      -- If an error mesage is found, sets the errMsg and sends the webhook.
			if v.Name == 'ErrorMessage' then
				_G.errMsg = v.Text:gsub('You were kicked from this experience: ','')
				_G.errMsg = _G.errMsg:gsub('\n', ' ')

				sendWebhook()
				debounce=true
			end
		end
	end
end)()
----------------------------------------------------------------------------

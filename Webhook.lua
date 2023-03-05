local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function found")
local HttpService = game:GetService("HttpService")

local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()

local Webhook = {}

function Webhook:Send(WebhookUrl, Message)
    local Success, Error = pcall(function()
        local Data = {
            ["content"] = Message
        }
        Request({
            Url = WebhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(Data)
        })
    end)

    if not Success then
        Lib.prompt("Error", Error, 5)
    end
end

function Webhook:Name(Webhook, Name)
    local Success, Error = pcall(function()
        Request({
            Url = Webhook,
            Method = "PATCH",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                name = Name
            })
        })
    end)

    if not Success then
        Lib.prompt("Error", Error, 5)
    end
end

return Webhook
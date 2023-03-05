local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function found")
local HttpService = game:GetService("HttpService")
local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()

function Send(Webhook, Message)
    local Succes, Error = pcall(function()
        local Data = {
            ["content"] = Message
        }
        Request({
            Url = Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(Data)
        })
    end)

    if not Succes then
        Lib.prompt("Error", Error, 5)
    end

end

local Webhook = {}

function Webhook:Send(Webhook, Message)
    Send(Webhook, Message)
end

return Webhook
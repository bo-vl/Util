local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function found")
local HttpService = game:GetService("HttpService")
local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()

local WebhookSettings = {
    ["@everyone"] = true;
}

function Send(Webhook, Message)
    local Succes, Error = pcall(function()
        Request({
            Url = Webhook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                allowed_mentions = {
                    parse = WebhookSettings["@everyone"] and {"everyone"} or {}
                },
                content = Message
            })
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
local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function found")
local HttpService = game:GetService("HttpService")
local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()

local Webhook = {}; do
    function Webhook:Send(Webhook, Message)
        local Succes, Error = pcall(function()
            Request({
                Url = Webhook,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode({
                    ["content"] = Message
                })
            })
        end)

        if not Succes then
            warn("Failed to send webhook: " .. Error)
            Lib.prompt('Error', 'Failed to send webhook:' .. Error, 2)
        end

end

function Webhook:Send(Webhook, Message) 
    Webhook:Send(Webhook, Message)
end

return Webhook
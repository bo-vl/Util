local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function found")
local HttpService = game:GetService("HttpService")
local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()

local WebhookSettings = {
    ["@everyone"] = false;
}

local Webhook = {}; do
    function Webhook:Send(Webhook, Message)
        local Success, Error = pcall(function()

            if WebhookSettings["@everyone"] then
                Message = string.format("@everyone %s", Message)
            end

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

        if not Success then
            error(Error)
        end
    end;
end
return Webhook
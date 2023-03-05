local HttpService = game:GetService("HttpService")

local function getRequestFunction()
    if syn and syn.request then
        return syn.request
    elseif request then
        return request
    elseif http and http.request then
        return http.request
    elseif http_request then
        return http_request
    else
        error("No request function found")
    end
end

local Request = getRequestFunction()

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

return Webhook

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
        Lib.prompt("Error", "" .. Error, 5)
    else
        Lib.prompt("Success", "Message sent to webhook", 5)
    end
end

function Webhook:Embed(WebhookUrl, Message, Title, description)
    local Success, Error = pcall(function()
        local Data = {
            ["type"] = "rich",
            ["content"] = Message,
            ["tts"] = false,
            ["embed"] = {
                ["title"] = Title,
                ["description"] = description,
            }
        }
        Request({
            Url = WebhookUrl,
            Method = "rich",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(Data)
        })
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        Lib.prompt("Success", "Embed sent to webhook", 5)
    end

end

return Webhook
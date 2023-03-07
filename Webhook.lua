local Request = (syn and syn.request or request or http and http.request or http_request) or error("No request function")
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
        --working
    end
end

function Webhook:Embed(WebhookUrl, Content, Title, description)
    local Success, Error = pcall(function()
        local Data = Request(
            {
                Url = WebhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(
                    {
                        ["content"] = Content,
                        ["embeds"] = {
                            {
                                ["title"] = Title,
                                ["description"] = description
                            }
                        }
                    }
                )
            }
        )
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        --working
    end

end

return Webhook

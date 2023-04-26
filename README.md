# Util

```lua
--webhook explained
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
Util.Webhook:Send(WebhookUrl, Message)
Util.Webhook:Embed(WebhookUrl, Content, Title, description)
```
```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local endPosition = CFrame.new(1,1,1)
local durection = 10 -- seconds
local CTween = Util.CTween:go(player, endPosition, durection)
CTween()
```

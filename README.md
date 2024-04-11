# Util

```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local endPosition = CFrame.new(1,1,1)
local duration = 10
Util.CTween:go(endPosition, duration)
```
```lua
local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local endPosition = CFrame.new(1,1,1).Position
local duration = 10
FindPath(endPosition)
ShowPath(endPosition)
MoveCharacter(endPosition)
```
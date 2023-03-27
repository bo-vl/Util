local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'), true))()
local TweenService = game:GetService("TweenService")
local lplr = game:GetService("Players").LocalPlayer

function Tween(Position, Time)
    local Success, Error = pcall(function()
        local startpos = lplr.Character.HumanoidRootPart.Position
        local endpos = Position
        local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 0)

        local tween = TweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo, {Position = endpos})
        tween:Play()
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        --working
    end
end

return Tween

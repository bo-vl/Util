local Lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Robobo2022/notify-lib/main/lib'),true))()
local TweenService = game:GetService("TweenService")
local lplr = game:GetService("Players").LocalPlayer

function Tween:Start(Position, Time)
    local Success, Error = pcall(function()
        local startpos = lplr.Character.HumanoidRootPart.Position
        local endpos = Position
        local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true,0)

        local Tween = TweenService:Create(endpos, TweenInfo, {startpos - endpos})
        tween:Play()
    end)

    if not Success then
        Lib.prompt("Error", "" .. Error, 5)
    else
        --working
    end
end
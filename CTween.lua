local ctween = {}

function ctween:go(player, endPosition, duration)
    local humanoidRootPart = player.Character.HumanoidRootPart
    local startPosition = humanoidRootPart.CFrame
    local startTime = os.clock()

    local function updatePosition()
        local elapsedTime = os.clock() - startTime
        if elapsedTime >= duration then
            humanoidRootPart.CFrame = endPosition
        else
            local t = elapsedTime / duration
            humanoidRootPart.CFrame = startPosition:Lerp(endPosition, t)
        end
    end

    local connection = game:GetService("RunService").Heartbeat:Connect(updatePosition)

    return function()
        connection:Disconnect()
    end
end

return ctween

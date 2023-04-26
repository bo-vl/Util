local ctween = {}

function ctween:go(part, endPosition, duration)
    local startPosition = part.CFrame
    local startTime = os.clock()

    local function updatePosition()
        local elapsedTime = os.clock() - startTime
        if elapsedTime >= duration then
            part.CFrame = endPosition
        else
            local t = elapsedTime / duration
            part.CFrame = startPosition:Lerp(endPosition, t)
        end
    end

    local connection = game:GetService("RunService").Heartbeat:Connect(updatePosition)

    return function()
        connection:Disconnect()
    end
end

return ctween

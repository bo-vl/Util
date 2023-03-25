local lplr = game.Players.LocalPlayer

local closestPlayer = nil
local closestDistance = math.huge

while task.wait() do
    local newClosestPlayer = nil
    local newClosestDistance = math.huge
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        -- Skip the local player
        if player ~= lplr then
            local distance = (lplr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < newClosestDistance then
                if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    newClosestPlayer = player
                    newClosestDistance = distance
                end
            end
        end
    end
    
    if newClosestPlayer then
        closestPlayer = newClosestPlayer
        closestDistance = newClosestDistance
        print("Closest player is " .. closestPlayer.Name .. " with a distance of " .. closestDistance)
    else
        closestPlayer = nil
        closestDistance = math.huge
        print("No other players found")
    end
    
    wait(1)
end

local Util = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robobo2022/Util/main/Load.lua"))()
local pathfinding = {}

function pathfinding:findPath(endPosition)
    local path = game:GetService("PathfindingService"):CreatePath()
    path:ComputeAsync(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, endPosition)

    local waypoints = {}
    if path.Status == Enum.PathStatus.Success then
        for _, waypoint in ipairs(path:GetWaypoints()) do
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 1, 1)
            part.Position = waypoint.Position
            part.Anchored = true
            part.CanCollide = false
            part.Color = Color3.new(0, 1, 0)
            part.Parent = workspace
            table.insert(waypoints, waypoint.Position)
        end
    end
    return waypoints
end

function pathfinding:followPath(player, waypoints)
    local currentWaypointIndex = 1
    local targetPosition = waypoints[currentWaypointIndex]

    local humanoid = player.Character.Humanoid
    humanoid:MoveTo(targetPosition)

    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local humanoidRootPart = player.Character.HumanoidRootPart
        local distanceToTarget = (targetPosition - humanoidRootPart.Position).Magnitude

        if distanceToTarget <= 1 then
            currentWaypointIndex = currentWaypointIndex + 1
            if currentWaypointIndex > #waypoints then
                connection:Disconnect()
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                return
            else
                targetPosition = waypoints[currentWaypointIndex]

                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.FilterDescendantsInstances = {player.Character}

                local raycastResult = workspace:Raycast(humanoidRootPart.Position, targetPosition, raycastParams)
                if not raycastResult then
                    humanoid:MoveTo(targetPosition)
                else
                    local endPosition = targetPosition
                    local duration = (endPosition - humanoidRootPart.Position).Magnitude / humanoid.WalkSpeed
                    Util.CTween:go(player, endPosition, duration)
                end
            end
        end

        local moveDirection = (targetPosition - humanoidRootPart.Position).Unit
        local moveVelocity = moveDirection * humanoid.WalkSpeed
        humanoidRootPart.Velocity = Vector3.new(moveVelocity.X, humanoidRootPart.Velocity.Y, moveVelocity.Z)

        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, targetPosition) + moveDirection
    end)

    return function()
        connection:Disconnect()
    end
end
